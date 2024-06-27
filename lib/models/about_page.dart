import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About SpendWell'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About SpendWell',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'SpendWell is a comprehensive expense tracking application designed to help you manage your finances effectively. '
                'With SpendWell, you can effortlessly record your expenses, set budgets, and create financial goals to ensure you stay on top of your financial health.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Key Features:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Add and categorize expenses with ease.\n'
                '• Set and monitor budgets to control your spending.\n'
                '• Create financial goals and track your progress.\n'
                '• Gain insights into your spending habits with detailed summaries.\n'
                '• Customize your profile and app settings to suit your preferences.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Importance of SpendWell:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Managing finances is crucial for achieving financial stability and achieving your long-term goals. SpendWell empowers you to take control of your money by providing a clear and organized view of your financial activities. '
                'By using SpendWell, you can identify areas where you can save money, avoid unnecessary expenses, and make informed financial decisions.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Start using SpendWell today and take the first step towards financial freedom!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
