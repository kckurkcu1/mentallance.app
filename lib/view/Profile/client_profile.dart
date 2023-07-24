import 'package:flutter/material.dart';
import 'package:mentallance/view/Sent_message/sent_message.dart';

import '../../components/custom_widgets/custom_wıdgets.dart';
import '../../services/appointment_service.dart';
import '../../theme/color_schemes.g.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({super.key});

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  String name = 'İsim Soyisim';

  @override
  Widget build(BuildContext context) {
    return Stack(children: [     
      Container(color: lightColorScheme.primaryContainer,height: MediaQuery.of(context).size.height*0.2,width: MediaQuery.of(context).size.width,),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppBarr(context, 'DOKTOR PROFİLİ'),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/doctor_profile.png'),
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Perform send message functionality
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ComposeEmail()));
                },
                child: Text('Mesaj Gönder'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentPage()));
                  // Perform make an appointment functionality
                },
                child: Text('Randevu Al'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(), // Empty Container
        ],
      ),
      )
    ]);
  }
}



//  Container(
//       padding: EdgeInsets.all(16.0),
//       child: 
//     );

