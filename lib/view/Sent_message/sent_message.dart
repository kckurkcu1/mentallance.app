import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/components/reusable_widgets/reusable_text_field.dart';

class ComposeEmail extends StatefulWidget {
  const ComposeEmail({Key? key});

  @override
  _ComposeEmailState createState() => _ComposeEmailState();
}

class _ComposeEmailState extends State<ComposeEmail> {
  TextEditingController _toController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _fromController = TextEditingController();

  @override
  void dispose() {
    _toController.dispose();
    _subjectController.dispose();
    _fromController.dispose();
    super.dispose();
  }
void _sendEmail() {
  String to = _toController.text;
  String subject = _subjectController.text;
  String from = _fromController.text;
  String mailId = generateRandomId(); // Rastgele bir mail ID oluşturma

  // Firestore koleksiyonuna e-postayı kaydetme
  FirebaseFirestore.instance.collection('Mailler').doc(mailId).set({
    'AliciMail': to,
    'GonderenMail': from,
    'Konu': subject,
    'MailId': mailId,
    'Zaman': DateTime.now(),
  }).then((value) {
    // Gönderildikten sonra, kullanıcıyı ana sayfaya yönlendirebilirsiniz
    Navigator.pop(context);
  }).catchError((error) {
    // Hata durumunda kullanıcıya bilgi verebilirsiniz
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while sending the email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  });
}

String generateRandomId() {
  return UniqueKey().toString();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesaj Gönder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
        
              reusableTextField('Kime', Icons.person, false, _toController),
              SizedBox(height: 8.0),
              messageTextField('text', _subjectController),
              SizedBox(height: 8.0),
              reusableTextField('Kimden', Icons.person, false, _fromController),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _sendEmail,
                child: Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  TextField messageTextField(
      String text, TextEditingController controller) {
    return TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(
          Icons.message,
          color: Colors.black,
        ),
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
