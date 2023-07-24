part of authentication;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'Şifremi Unuttum'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.width * 0.1, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(forgotimg),
                reusableTextField("Maitinizi Giriniz",
                    Icons.person_outline, false, _emailTextController),
                    SizedBox(height: 20,),
                reusableButton(
                    context, 'Şifremi Unuttum',  () {
                      resetPassword(context,_emailTextController);
        
                     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
