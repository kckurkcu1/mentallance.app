part of TaskAssignment;

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<Map<String, dynamic>> patients = [];
  @override
  void initState() {
    super.initState();
    getPatients();
  }

  Future<void> getPatients() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final doctorId = currentUser.uid;
        final snapshot = await FirebaseFirestore.instance
            .collection('KayitOlanDanisan')
            .where('DoktorId', isEqualTo: doctorId)
            .get();
        final List<Map<String, dynamic>> patientsList = [];
        snapshot.docs.forEach((doc) {
          final patientData = doc.data();
          patientsList.add(patientData);
        });
        setState(() {
          patients = patientsList;
        });
      }
    } catch (e) {
      Text("Hata oluştu: $e");
      print('Hastaları alırken hata oluştu: $e');
    }
  }

  void navigateToHastaGorev(String patientId, String patientEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HastaGorevPage(
          patientId: patientId,
          patientEmail: patientEmail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'HASTALARIM'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddClient()));
        },
        child: Image.asset(auth2),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: patients.isNotEmpty
                ? ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patientId = patients[index]['DanisanId'];
                      final patientEmail = patients[index]['DanisanEmail'];
                      return ListTile(
                        title: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Center(child: Text('Email: $patientEmail')),
                        ),
                        // Text('Email: $patientEmail') ,
                        onTap: () {
                          navigateToHastaGorev(patientId, patientEmail);
                        },
                      );
                    },
                  )
                : Center(child: Image.asset(sonucBulunamadi)),
          ),
        ],
      ),
    );
  }
}

class HastaGorevPage extends StatefulWidget {
  final String patientId;
  final String patientEmail;
  const HastaGorevPage({
    Key? key,
    required this.patientId,
    required this.patientEmail,
  });
  @override
  State<HastaGorevPage> createState() => _HastaGorevPageState();
}

class _HastaGorevPageState extends State<HastaGorevPage> {
  late TextEditingController _baslikController;
  late TextEditingController _aciklamaController;
  @override
  void initState() {
    super.initState();
    _baslikController = TextEditingController();
    _aciklamaController = TextEditingController();
  }

  @override
  void dispose() {
    _baslikController.dispose();
    _aciklamaController.dispose();
    super.dispose();
  }

  void _gorevAta() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final doctorId = currentUser.uid;
        final gorevData = {
          'DoktorId': doctorId,
          'DanisanId': widget.patientId,
          'GorevBaslik': _baslikController.text,
          'GorevAciklama': _aciklamaController.text,
          'GorevDurum': 'görev atandı',
          'GorevTamamlanma': false,
        };
        final newGorevRef =
            await FirebaseFirestore.instance.collection('Gorev').add(gorevData);
        final newGorevId = newGorevRef.id;
        await newGorevRef.update({'GorevId': newGorevId});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Danışana görev atandı.'),
          ),
        );
        // Görev atandıktan sonra yapılacak diğer işlemler
      }
    } catch (e) {
      print('Görev atama hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasta Görev Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Center(
                      child: Text('Hasta E-postası: ${widget.patientEmail}'))),
              SizedBox(height: 16),
              Text('Görev Başlığı:'),
              reusableTextField('Görev Başlığı', Icons.person_outline, false,
                  _baslikController),
              SizedBox(height: 16),
              Text('Görev Açıklama:'),
              Column(
                children: [
                  gorevTextField(
                      "Görev Açıklama", Icons.toc, _aciklamaController),
                ],
              ),
              SizedBox(height: 16),
              reusableButton(context, 'Görev Ata', _gorevAta)
            ],
          ),
        ),
      ),
    );
  }

  TextField gorevTextField(
      String text, IconData icon, TextEditingController controller) {
    return TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
    );
  }
}
