import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'notification_page.dart';
import 'privacy_security_page.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            title: Text('Notification'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          ListTile(
            title: Text('Privacy and Security'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacySecurityPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
