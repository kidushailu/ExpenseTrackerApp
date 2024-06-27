import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help and Support',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to SpendWell Help and Support. Here you can find answers to common questions and get assistance with using the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Frequently Asked Questions:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Q: How do I add an expense?\n'
                'A: To add an expense, go to the dashboard and tap on the "Add Expense" button. Fill in the details and save your expense.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Q: How do I set a budget?\n'
                'A: To set a budget, go to the dashboard and tap on the "Budget" button. Enter your income, expenses, and savings, then set your spending limit.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Q: How do I create a financial goal?\n'
                'A: To create a goal, go to the dashboard and tap on the "Goal" button. Fill in the required fields and set your goal.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Need more help?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you need further assistance, feel free to reach out to our support team:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Email: support@spendwellapp.com\nPhone: +1 800 123 4567\nWebsite: www.spendwellapp.com/support',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'We are here to help you make the most out of SpendWell. Thank you for using our app!',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
