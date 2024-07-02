import 'package:flutter/material.dart';
import 'account_page.dart'; // Import the AccountPage widget
import 'appearance_page.dart'; // Import the AppearancePage widget
import 'privacy_security_page.dart'; // Import the PrivacySecurityPage widget
import 'help_page.dart'; // Import the HelpPage widget
import 'about_page.dart'; // Import the AboutPage widget
import '../helpers/bottom_bar.dart'; // Import the BottomBar widget for the bottom navigation
import '../helpers/settings_list.dart'; // Import the SettingsList widget for displaying options

// SettingsPage is a StatelessWidget that represents the settings screen of the app
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides a high-level structure for the page layout
      appBar: AppBar(
        // AppBar displays a header for the page with a title
        title: Text('Settings'), // Title of the AppBar
      ),
      body: Container(
        // Container widget provides alignment and contains child widgets
        alignment: Alignment.center, // Centers the content within the container
        child: Column(
          // Column widget arranges children widgets vertically
          children: [
            Divider(
              height: 2,
            ),
            // Each SettingsList item represents a setting option that navigates to a different page
            SettingsList(
              page: AccountPage(), // Page to navigate to for account settings
              title: 'Account', // Title of the list item
            ),
            SettingsList(
              page: PrivacySecurityPage(),
              title: 'Privacy and Security',
            ),
            SettingsList(
              page: AppearancePage(),
              title: 'Appearance',
            ),
            SettingsList(
              page: HelpPage(),
              title: 'Help and Support',
            ),
            SettingsList(
              page: AboutPage(),
              title: 'About',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(), // Displays the bottom navigation bar
    );
  }
}
