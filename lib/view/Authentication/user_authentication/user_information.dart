part of authentication;

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userSurnameTextController =
      TextEditingController();
  // final TextEditingController _genderTextController = TextEditingController();
  String dropDownValue = 'Cinsiyetinizi Seçiniz';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarr(context, 'Kullanıcı Bilgileri'),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.01, 20, 0),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  auth2,
                  height: 150,
                  width: 150,
                ),
              ),
              reusableTextField("Adınızı Giriniz", Icons.person_outline, false,
                  _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Soyadınızı Giriniz", Icons.person_outline,
                  false, _userSurnameTextController),
              const SizedBox(
                height: 20,
              ),
             
              reusableButton(context, "Giriş", () {
                userInformation(_userNameTextController,_userSurnameTextController);
              })
            ]),
          ),
        ));
  }

    
}