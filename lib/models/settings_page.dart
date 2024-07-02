import 'package:flutter/material.dart';
import 'account_page.dart';
import 'appearance_page.dart';
import 'privacy_security_page.dart';
import 'help_page.dart';
import 'about_page.dart';
import '../helpers/bottom_bar.dart';
import '../helpers/settings_list.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Divider(
                height: 2,
              ),
              SettingsList(
                page: AccountPage(),
                title: 'Account',
              ),
              SettingsList(
                  page: PrivacySecurityPage(), title: 'Privacy and Security'),
              SettingsList(page: AppearancePage(), title: 'Appearance'),
              SettingsList(page: HelpPage(), title: 'Help and Support'),
              SettingsList(page: AboutPage(), title: 'About'),
            ],
          )),
      bottomNavigationBar: BottomBar(),
    );
  }
}
