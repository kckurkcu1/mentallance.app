import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addCustomerService(String email, String doctorId, BuildContext context) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: generateRandomPassword(8),
      );

      final user = userCredential.user;
      await resetPassword(email);
      await addDanisanToCollection(user?.uid, email, doctorId);
      await addDanisanToDoktor(user?.uid, doctorId);

      print('New customer created with email: $email');
      showSuccessSnackBar(context, 'Danışan mailine şifre oluşturma bağlantısı gönderilmiştir.');
    } catch (e) {
      print('Error adding customer: $e');
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('Bir hata oluştu: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Kapat'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Email gönderilemedi!!!: $e');
    }
  }

  Future<void> addDanisanToCollection(String? userId, String email, String doctorId) async {
    if (userId != null) {
      final danisanData = {
        'DanisanId': userId,
        'DanisanEmail': email,
        'GirisZamani': DateTime.now(),
        'DanisanIsim': '',
        'DanisanSoyisim': '',
        'DoktorId': doctorId, // Doktorun ID'sini danışan verisine ekleyin
      };

      try {
        await FirebaseFirestore.instance.collection('KayitOlanDanisan').doc(userId).set(danisanData);
        print('Danışan kaydı başarıyla oluşturuldu.');
      } catch (e) {
        print('Koleksiyona kayıt gerçekleştirilemedi: $e');
      }
    }
  }

  Future<void> addDanisanToDoktor(String? danisanId, String doctorId) async {
    if (danisanId != null) {
      try {
        await FirebaseFirestore.instance.collection('KayitOlanDoktor').doc(doctorId).update({
          'Danisanlar': FieldValue.arrayUnion([danisanId]),
        });
        print('Danisan, doktorun "Danisanlar" dizisine eklendi.');
      } catch (e) {
        print('Danisan, doktora eklenirken hata oluştu: $e');
      }
    }
  }

  String generateRandomPassword(int length) {
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = Random();
    String password = '';

    for (int i = 0; i < length; i++) {
      int index = random.nextInt(characters.length);
      password += characters[index];
    }

    return password;
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
