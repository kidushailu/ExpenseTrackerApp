import 'package:flutter/material.dart';
import 'account_page.dart';
import 'appearance_page.dart';
import 'privacy_security_page.dart';
import 'help_page.dart';
import 'about_page.dart';


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
            title: Text('Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
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
          ListTile(
            title: Text('Appearance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppearancePage()),
              );
            },
          ),
          ListTile(
            title: Text('Help and Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

