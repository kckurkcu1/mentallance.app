part of authentication;

/*
! Bu dosyada Olanlar

* kayit ekrani 
* firebase altyapili Sing Up 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class UserSingUp extends StatefulWidget {
  const UserSingUp({Key? key}) : super(key: key);

  @override
  _UserSingUpState createState() => _UserSingUpState();
}

class _UserSingUpState extends State<UserSingUp> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userSurnameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hesap Oluştur'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.01, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              
              children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(auth2, height: 150, width: 150,),
              ),
              
              reusableTextField("Adınızı Giriniz", Icons.person_outline,
                  false, _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Soyadınızı Giriniz", Icons.person_outline,
                  false, _userSurnameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Mailinizi Giriniz", Icons.email_outlined,
                  false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Şifrenizi Giriniz", Icons.lock_outline,
                  true, _passwordTextController),
              const SizedBox(
                height: 20,
                
              ),
              reusableButton(context, "Kayıt Ol",  (){
                  docSingUp(context,_emailTextController, _passwordTextController, _userNameTextController, _userSurnameTextController);
                })
            ]),
          ),
        ));
  }
}