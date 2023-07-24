import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentallance/components/custom_widgets/custom_w%C4%B1dgets.dart';

class AnketDoldur extends StatefulWidget {
  const AnketDoldur({super.key});

  @override
  _AnketDoldurState createState() => _AnketDoldurState();
}

class _AnketDoldurState extends State<AnketDoldur> {
  final TextEditingController _cevapController = TextEditingController();

  void _anketiGonder() {
    String soru =
        'Seans sonrası duygu ve düşüncelerinizi paylaşmanız bizim için önemlidir.İsimsiz olarak bizimle düşüncelerinizi  paylaşabilirsiniz.'; // Başlık olarak kullanılacak sabit bir soru metni
    String cevap = _cevapController.text;

    // Firestore koleksiyonuna anketi kaydet
    FirebaseFirestore.instance.collection('anketler').add({
      'soru': soru,
      'cevap': cevap,
      'AnketTarihi': DateTime.now(),
    });

    // Text alanını temizle
    _cevapController.clear();

    // Geri bildirim göster
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Anket gönderildi')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'Anket Doldurma Sayfası'),
      //  AppBar(        title: const Text('Anket Doldurma Sayfası'),      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Seans sonrası duygu ve düşüncelerinizi paylaşmanız bizim için önemlidir.İsimsiz olarak bizimle  düşüncelerinizi paylaşabilirsiniz.', // Başlık olarak gösterilen sabit soru metni
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                surveyTextField('Cevap', _cevapController),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _anketiGonder,
                  child: const Text('Gönder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
TextField surveyTextField(
      String text, TextEditingController controller) {
    return TextField(
      maxLines: 5,
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
