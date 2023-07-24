library authentication;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/components/reusable_widgets/reusable_text_field.dart';
import 'package:mentallance/logger.dart';
import 'package:mentallance/main.dart';
import 'package:mentallance/services/task_assignment.dart';
import 'package:mentallance/view/introduction_page/introduction.dart';


import '../../components/assets.dart';
import '../../components/custom_widgets/custom_wıdgets.dart';


part 'package:mentallance/services/AuthenticationServices/forgot_password_service.dart';
part 'package:mentallance/services/AuthenticationServices/customer_auth_service.dart';
part 'package:mentallance/services/AuthenticationServices/customer_information_service.dart';
part 'package:mentallance/view/Authentication/doctor_authentication/doctor_singin.dart';
part 'package:mentallance/view/Authentication/doctor_authentication/doctor_singup.dart';
part 'package:mentallance/view/Authentication/user_authentication/user_singin.dart';
part 'package:mentallance/view/Authentication/forgot_password.dart';  
part 'package:mentallance/view/Authentication/user_authentication/user_information.dart';




Future<void> docSingin(BuildContext context, econtroller, pcontroller) async {
  final logg = logger(UserSingUp);
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: econtroller.text,
      password: pcontroller.text,
    )
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DocBottonNavBar()),
          (route) => false);
      return value;
    });

    User? user = userCredential.user;
    logg.v('Giris yapan doktor: ${user?.uid}');

    final doctorDoc = await FirebaseFirestore.instance
        .collection('KayitOlanDoktor')
        .doc(user?.uid)
        .get();

    if (!doctorDoc.exists) {
      String welcomeMessage = 'Bu bilgiler doktora ait değil!!!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(welcomeMessage),
          backgroundColor: Colors.red,
        ),
      );
      throw Exception('Bu kullanıcı doktor değil!');
    } else {
      FirebaseFirestore.instance.collection('GirisYapanDoktor').add({
        'DoktorId': user?.uid,
        'DoktorEmail': user?.email,
        'GirisZamani': DateTime.now(),
        'DoktorIsim': "",
        'DoktorSoyIsim': "",
      });
    }

    logg.v('"GirisYapanDoktor" koleksiyonunda dokuman olusturuldu.');

    String welcomeMessage = 'Hoşgeldin, ${user?.email}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(welcomeMessage),
        backgroundColor: Colors.green,
      ),
    );

    // Giriş başarılı olduğunda gerekli yönlendirmeyi burada gerçekleştirebilirsiniz.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyWidget()),
    );
  } catch (e) {
    if (e is FirebaseAuthException) {
      String errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage =
              'Kullanıcı bulunamadı. Lütfen geçerli bir e-posta adresi girin.';
          logg.e(errorMessage);
          break;
        case 'wrong-password':
          errorMessage = 'Hatalı şifre. Lütfen doğru şifreyi girin.';
          logg.e(errorMessage);
          break;
        case 'invalid-email':
          errorMessage =
              'Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin.';
          logg.e(errorMessage);
          break;
        default:
          errorMessage = 'Giriş başarısız oldu. Hata: ${e.code}';
          logg.e(errorMessage);
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      logg.e('Sign in failed: $e');
    }
  }
}

void docSingUp(
    BuildContext context, econtroller, pcontroller, unamecontroller,usurnamecontrpller) async {
  final logg = logger(Doctor_singIn);
  try {
    String name = unamecontroller.text;
    String surname = usurnamecontrpller.text;
    String email = econtroller.text;
    String password = pcontroller.text;

    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Doktor oluşturuluyor
    User? user = userCredential.user;
    logg.i('Doktor Kaydı Gerçekleştirildi: ${user?.uid}');

    // KayitOlanDoktor koleksiyonunda doküman oluşturuluyor.
    await FirebaseFirestore.instance
        .collection('KayitOlanDoktor')
        .doc(user?.uid)
        .set({
      'DoktorIsim': name,
      'DoktorSoyisim': surname,
      'DoktorEmail': email,
      'DoktorId': user?.uid,
      'DoktorRandevu': [
        '08.00',
        '09.00',
        '10:00',
        '11:00',
        '13.00',
        '14:00',
        '15.00',
        '16.00'
      ],
      'Danisanlar': [], // Başlangıçta boş bir danışanlar listesi ekleniyor
    });

    logg.i('"KayitOlanDoktor" koleksiyonunda doküman oluşturuldu.');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doktor başarılı bir şekilde kaydedildi!'),
        backgroundColor: Colors.green,
      ),
    );

    if (!user!.emailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Lütfen e-posta adresinizi doğrulayın. Doğrulama e-postası gönderildi.'),
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bilgilerinizle giriş yapabilirsiniz.'),
          backgroundColor: Colors.green,
        ),
      );
    }

    await user.sendEmailVerification();
  } catch (e) {
    String errorMessage = 'Kayıt işlemi gerçekleştirilemedi. Tekrar deneyiniz.';
    String errorMessage1 = '';
    logg.e(errorMessage);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );

    if (e is FirebaseAuthException) {
      if (e.code == 'weak-password') {
        errorMessage1 = 'Şifreniz 6 haneden az olamaz.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage1),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        errorMessage1 =
            'Bu mail adresi zaten kayıtlı. Farklı bir adres deneyiniz.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage1),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'invalid-email') {
        errorMessage1 = 'Lütfen geçerli bir mail adresi giriniz.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage1),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    logg.e('Sign up failed: $e');
  }
}