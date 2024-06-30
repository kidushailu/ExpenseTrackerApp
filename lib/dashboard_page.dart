import 'package:flutter/material.dart';
import 'registration_page.dart';
import 'models/add_expense_page.dart';
import 'models/budget_page.dart';
import 'models/insight_page.dart';
import 'models/settings_page.dart';
//import 'database_helper.dart';
import 'helpers/dash_buttons.dart';
import 'helpers/bottom_bar.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //final DatabaseHelper _databaseHelper = DatabaseHelper();
  double? _budgetLimit;
  String? _goalTitle;
  double? _goalAmount;
  List<Map<String, dynamic>> _expenses = [];

  void _addExpense(Map<String, dynamic> expenseData) {
    setState(() {
      _expenses.add(expenseData);
    });
  }

  void _addGoal(Map<String, dynamic> goalData) {
    setState(() {
      _goalTitle = goalData['title'];
      _goalAmount = goalData['amount'];
    });
  }

  void _addBudget(Map<String, dynamic> budgetData) {
    setState(() {
      _budgetLimit = budgetData['limit'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Hello!',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (_budgetLimit != null)
              Text(
                'Budget Spending Limit: \$$_budgetLimit',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 10),
            if (_goalTitle != null && _goalAmount != null)
              Text(
                'Goal: $_goalTitle (\$$_goalAmount)',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 10),
            if (_expenses.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _expenses.map((expense) {
                  return Text(
                    '${expense['name']}: \$${expense['amount']} (${expense['durationValue']} ${expense['duration']})',
                    style: TextStyle(fontSize: 18),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DashBoardButton(
                  page: AddExpensePage(),
                  title: "Add Expense",
                  icon: Icons.add),
              DashBoardButton(
                  page: InsightPage(),
                  title: "Insights",
                  icon: Icons.pie_chart),
              DashBoardButton(
                  page: BudgetPage(), title: "Budget", icon: Icons.wallet),
              DashBoardButton(
                  page: SettingsPage(),
                  title: "Settings",
                  icon: Icons.settings),
            ]),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
