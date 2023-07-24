import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mentallance/services/task_assignment.dart';
import 'package:mentallance/theme/color_schemes.g.dart';
import 'package:mentallance/view/Profile/client_profile.dart';
import 'package:mentallance/view/Profile/doctor_profile.dart';
import 'package:mentallance/view/Settings/settings.dart';


import 'package:mentallance/view/entry_page/entry_page_view_mobile.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const EntryPageView(),
    );
  }
}

class DocBottonNavBar extends StatefulWidget {
  const DocBottonNavBar({super.key});

  @override
  State<DocBottonNavBar> createState() => _DocBottonNavBarState();
}

class _DocBottonNavBarState extends State<DocBottonNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DoctorProfilePage(),
    MyWidget(),
    SettingsPage(),
  ];  
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(decoration: BoxDecoration(color: lightColorScheme.primaryContainer, borderRadius: BorderRadius.circular(50)),
          child: GNav(
            padding: const EdgeInsets.all(8),
            activeColor: lightColorScheme.onPrimaryContainer,
            tabActiveBorder: Border.all(color: lightColorScheme.onPrimaryContainer, width: 1),
            color: lightColorScheme.onSecondaryContainer,
            gap: 8,
            
            tabs:const  [
            GButton(
              icon: Icons.person,
              text: 'Profil',
            ),
            GButton(
              icon: Icons.medical_information,
              text: 'Hastalarim',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Ayarlar',
            ),
        
            
          ],onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },),
        ),
      ),   body: _widgetOptions.elementAt(_selectedIndex),   
    );
  }
}
class CusBottonNavBar extends StatefulWidget {
  const CusBottonNavBar({super.key});

  @override
  State<CusBottonNavBar> createState() => _CusBottonNavBarState();
}

class _CusBottonNavBarState extends State<CusBottonNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // DoctorProfilePage(),
    // MyWidget(),
    // SettingsPage(),
    ClientProfilePage(),
    OdevListe(),
    SettingsPage(),
    
    
  ];  
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(decoration: BoxDecoration(color: lightColorScheme.primaryContainer, borderRadius: BorderRadius.circular(50)),
          child: GNav(
            padding: const EdgeInsets.all(8),
            activeColor: lightColorScheme.onPrimaryContainer,
            tabActiveBorder: Border.all(color: lightColorScheme.onPrimaryContainer, width: 1),
            color: lightColorScheme.onSecondaryContainer,
            gap: 8,
            
            tabs:const  [
            GButton(
              icon: Icons.person,
              text: 'Profil',
            ),
            GButton(
              icon: Icons.medical_services,
              text: 'Görevlerim',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Ayarlar',
            ),
        
            
          ],onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },),
        ),
      ),   body: _widgetOptions.elementAt(_selectedIndex),   
    );
  }
}