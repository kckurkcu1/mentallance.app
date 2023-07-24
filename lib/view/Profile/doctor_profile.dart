import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/components/custom_widgets/custom_w%C4%B1dgets.dart';
import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/components/reusable_widgets/reusable_text_field.dart';
import 'package:mentallance/theme/color_schemes.g.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  String name = 'İsim Soyisim';

  @override
  void initState() {
    super.initState();
    loadDoctorProfile();
  }

  Future<void> loadDoctorProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doctorId = currentUser?.uid;
    final doctorSnapshot = await FirebaseFirestore.instance
        .collection('KayitOlanDoktor')
        .doc(doctorId)
        .get();

    if (doctorSnapshot.exists) {
      final doctorData = doctorSnapshot.data();
      setState(() {
        name = '${doctorData?['DoktorIsim']} ${doctorData?['DoktorSoyisim']}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [     
      Container(color: lightColorScheme.primaryContainer,height: MediaQuery.of(context).size.height*0.2,width: MediaQuery.of(context).size.width,),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppBarr(context, 'PROFİLİM'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/doctor_profile.png'),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WriteBlogPage()),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          name = value;
                        });
                      }
                    });
                  },
                  child: const Text('Blog Yaz'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          name = value;
                        });
                      }
                    });
                  },
                  child: const Text('Düzenle'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Yazılarım',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('BlogYazilari')
                    .where('DoktorId',
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Veriler alınırken bir hata oluştu');
                  }
                  if (!snapshot.hasData) {
                    return Text('Gösterilecek veri yok');
                  }
                  final blogYazilari = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: blogYazilari.length,
                    itemBuilder: (context, index) {
                      final blogYazi =
                          blogYazilari[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightColorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(blogYazi['BlogBaslik']),
                            subtitle: Text(
                              blogYazi['BlogYazi'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(blogYazi['BlogBaslik']),
                                    content: SingleChildScrollView(
                                      child: Text(blogYazi['BlogYazi']),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Tamam'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class WriteBlogPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'Blog Yaz'),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              reusableTextField('Başlık', Icons.view_headline_sharp, false, _titleController),
              const SizedBox(height: 16.0),
              blogTextField('Yazı', _contentController),
        
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String title = _titleController.text;
                  String content = _contentController.text;
        
                  final currentUser = FirebaseAuth.instance.currentUser;
                  final doctorId = currentUser?.uid;
                  final doctorSnapshot = await FirebaseFirestore.instance
                      .collection('KayitOlanDoktor')
                      .doc(doctorId)
                      .get();
        
                  if (doctorSnapshot.exists) {
                    final doctorData = doctorSnapshot.data();
        
                    //String DoktorIsim =  '${doctorData?['DoktorIsim']} ${doctorData?['DoktorSoyisim']}';
        
                    // Verileri Firebase'e kaydet
                    await FirebaseFirestore.instance
                        .collection('BlogYazilari')
                        .add({
                      'DoktorId': doctorId,
                      'DoktorIsim': doctorData?['DoktorIsim'],
                      'DoktorSoyisim': doctorData?['DoktorSoyisim'],
                      'BlogBaslik': title,
                      'BlogYazi': content,
                    });
        
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Başarılı'),
                          content: const Text('Blog yazınız paylaşıldı.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    TextField blogTextField(
      String text, TextEditingController controller) {
    return TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
    );}
}

class EditProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final CollectionReference _doctorsCollection =
      FirebaseFirestore.instance.collection('KayitOlanDoktor');

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doctorId = currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Düzenle'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableTextField('Adınız', Icons.person, false, _nameController),
              SizedBox(height: 16.0),
              reusableTextField('Soy Adınız', Icons.person, false, _surnameController),
              SizedBox(height: 16.0),
              reusableTextField('Emailiniz', Icons.person, false, _emailController),
              SizedBox(height: 16.0),
              reusableTextField('Şifreniz', Icons.person, true, _passwordController),
              SizedBox(height: 16.0),
              
              reusableButton(context, 'Kaydet', ()async {
                  String name = _nameController.text;
                  String surname = _surnameController.text;
                  String email = _emailController.text;
                  String newPassword = _passwordController.text;
        
                  await _doctorsCollection.doc(doctorId).update({
                    'DoktorIsim': name,
                    'DoktorSoyisim': surname,
                    'DoktorEmail': email,
                  });
        
                  await currentUser?.updatePassword(newPassword);
        
                  Navigator.pop(context, '$name $surname');
                },),
              
            ],
          ),
        ),
      ),
    );
    
  }
  

}