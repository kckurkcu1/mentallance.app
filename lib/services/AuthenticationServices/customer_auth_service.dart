part of authentication;
Future<void> cusSingin(BuildContext context, econtroller, pcontroller) async {
  final logg = logger(UserSingUp);
  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: econtroller.text,
      password: pcontroller.text,
    ).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IntroductionPage(),
        ),
      );});
    final user = userCredential.user;
    logg.v('Giriş yapan danışan: ${user?.uid}');
    final danisanDoc = await FirebaseFirestore.instance
        .collection('KayitOlanDanisan')
        .doc(user?.uid)
        .get();
    if (!danisanDoc.exists) {
      String welcomeMessage = 'Bu bilgiler danışana ait değil!!!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(welcomeMessage),
          backgroundColor: Colors.red,
        ),
      );
      throw Exception('Bu kullanıcı danışan değil!');
    }
    FirebaseFirestore.instance.collection('GirisYapanDanisan').add({
      'DanisanId': user?.uid,
      'DanisanEmail': user?.email,
      'GirisZamanı': DateTime.now(),
      'DanisanIsim': '',
      'DanisanSoyisim': '',
    });
    logg.v('"GirisYapanDanisan" koleksiyonunda belge oluşturuldu.');
    String welcomeMessage = 'Hoş geldiniz, ${user?.email}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(welcomeMessage),
        backgroundColor: Colors.green,
      ),
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