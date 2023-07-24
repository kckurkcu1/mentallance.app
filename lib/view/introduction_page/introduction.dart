import 'package:flutter/material.dart';
import 'package:mentallance/components/assets.dart';
import 'package:mentallance/main.dart';
import 'package:mentallance/services/AuthenticationServices/doctor_auth_service.dart';

import '../../components/custom_widgets/custom_wıdgets.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarr(context, 'Tanıtım Sayfası'),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0, 20, 0),
            child: Column(
              children: [
                const TabBar(tabs: [
                  Tab(text: '............................', height: 1),
                  Tab(
                    text: '............................',
                    height: 1,
                  ),
                  Tab(
                    text: '............................',
                    height: 1,
                  ),
                  
                ]),
                Expanded(
                  child: TabBarView(children: [
                    page_1(context),
                    page_2(context),
                    page_3(context),
                    
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}

Container page_1(context) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            introPng,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: ThemeData().colorScheme.onTertiaryContainer,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                  "Mentallance, psikologlar ve danışanlar arasında interaktif bir deneyim sunan yenilikçi bir mobil uygulamadır. Artık psikolojik destek ve danışmanlık ihtiyaçlarınızı uygulama üzerinden kolayca sağlayabilirsiniz."),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child:
                Image.asset(solaKaydirPng, height: 50, width: 50, scale: 1.5)),
      ],
    ),
  );
}

Container page_2(context) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            introPng2,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                  "Mentallance, ihtiyaçlarınıza ve hedeflerinize uygun terapi süreci sunar. Psikolojik destek seanslarınızı istediğiniz zaman planlayabilir ve sürecinizi yönetebilirsiniz."),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child:
                Image.asset(solaKaydirPng, height: 50, width: 50, scale: 1.5)),
      ],
    ),
  );
}

Container page_3(context) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            introPng3,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                  "Şimdi Mentallance ile tanışmadan önce biraz kendinizden bahsedin. Bu bilgiler, psikologlarımızın size uygun terapi sürecini planlamasına yardımcı olacaktır."),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child:
                ElevatedButton(onPressed: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CusBottonNavBar(),), (route) => false);}, child: Text('Başla'))),
      ],
    ),
  );
}