part of authentication;

Future<void> resetPassword(BuildContext buildContext, econtroller) async {
  final String email = econtroller.text;
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(buildContext).showSnackBar(
      const SnackBar(
        content: Text('Şifre sıfırlama e-postası gönderildi.'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(buildContext).showSnackBar(
      SnackBar(
        content: Text('Şifre sıfırlama e-postası gönderilemedi. Hata: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
