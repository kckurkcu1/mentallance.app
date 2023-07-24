part of TaskAssignment;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUserUid() async {
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }
}

class OdevListe extends StatefulWidget {
  const OdevListe({Key? key}) : super(key: key);

  @override
  _OdevListeState createState() => _OdevListeState();
}

class _OdevListeState extends State<OdevListe> {
  List<Map<String, dynamic>> gorevler = [];

  @override
  void initState() {
    super.initState();
    getGorevler();
  }

  Future<void> getGorevler() async {
    AuthService authService = AuthService();
    String? danisanId = await authService.getCurrentUserUid();

    DocumentSnapshot<Map<String, dynamic>> danisanSnapshot =
        await FirebaseFirestore.instance
            .collection('KayitOlanDanisan')
            .doc(danisanId)
            .get();
    String? doktorId = danisanSnapshot.get('DoktorId');

    if (doktorId != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Gorev')
          .where('DanisanId', isEqualTo: danisanId)
          .where('DoktorId', isEqualTo: doktorId)
          .get();

      List<Map<String, dynamic>> gorevler = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      setState(() {
        this.gorevler = gorevler;
      });
    }
  }

  void toggleGorevYapildi(int index) async {
    String gorevId = gorevler[index]['GorevId'];

    bool yapildi = gorevler[index]['GorevTamamlanma'] ?? false;
    yapildi = !yapildi;

    await FirebaseFirestore.instance
        .collection('Gorev')
        .doc(gorevId)
        .update({'GorevTamamlanma': yapildi});

    setState(() {
      gorevler[index]['GorevTamamlanma'] = yapildi;
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: customAppBarr(context, "Görevlerim"),
    ),
    body: gorevler.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: gorevler.length,
            itemBuilder: (context, index) {
              bool yapildi = gorevler[index]['GorevTamamlanma'] ?? false;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: lightColorScheme.secondaryContainer.withOpacity(0.3),borderRadius: BorderRadius.circular(50)),
                  
                  child: ListTile(
                    title: Text(gorevler[index]['GorevBaslik'],style: TextStyle(color: lightColorScheme.onSecondaryContainer),),
                    leading: Checkbox(
                      value: yapildi,
                      onChanged: (value) {
                        toggleGorevYapildi(index);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
  );
}

}