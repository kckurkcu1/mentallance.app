part of authentication;

/*
! Bu dosyada Olanlar

* girs ekrani 
* firebase altyapili Sing in 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class Doctor_singIn extends StatefulWidget {
  const Doctor_singIn({super.key});

  @override
  State<Doctor_singIn> createState() => _Doctor_singInState();
}

class _Doctor_singInState extends State<Doctor_singIn> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final log = logger(Doctor_singIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'DOKTOR GIRIS'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                auth,
                height: 150,
                width: 150,
              ),
              //logoWidget("assets/images/logo1.png"),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Mailinizi Giriniz",
                  Icons.person_outline, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Şifrenizi Giriniz", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 5,
              ),
              forgetPassword(context),
              // docSingIn(context, _emailTextController, _passwordTextController),

              reusableButton(context, "Giriş", () {
                docSingin(
                    context, _emailTextController, _passwordTextController);

              }),
              signUpOption()
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Henüz bir hesaba sahip değil misiniz?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w400)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserSingUp(),
                ));
          },
          child: const Text(
            " Hesap oluşur",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Şifremi unuttum?",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.right,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          }),
    );
  }
}

