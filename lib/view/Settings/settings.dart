import 'package:flutter/material.dart';
import 'package:mentallance/view/entry_page/entry_page_view_mobile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Hesap Başlığı
          ListTile(
            title: Text(
              'Hesap',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {
              // Profil düzenleme sayfasına yönlendirme işlemleri burada yapılabilir
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Şifre'),
            onTap: () {
              // Şifre değiştirme sayfasına yönlendirme işlemleri burada yapılabilir
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Bildirimler'),
            onTap: () {
              // Bildirimler sayfasına yönlendirme işlemleri burada yapılabilir
            },
          ),
          Divider(),
          // Daha Fazla Başlığı
          ListTile(
            title: Text(
              'Daha Fazla',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Puanla & Oyla'),
            onTap: () {
              // Puanlama ve oylama işlemleri burada yapılabilir
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Yardım'),
            onTap: () {
              // Yardım sayfasına yönlendirme işlemleri burada yapılabilir
            },
          ),
          Divider(),
          // Çıkış Butonu
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Çıkış',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EntryPageView(),), (route) => false);
              // Çıkış işlemleri burada yapılabilir
            },
          ),
        ],
      ),
    );
  }
}
