import 'package:flutter/material.dart';
import 'registration_page.dart';
import 'models/add_expense_page.dart';
import 'models/budget_page.dart';
import 'models/goal_page.dart';
import 'models/insight_page.dart';
import 'models/settings_page.dart';
import 'database_helper.dart';


class DashboardPage extends StatefulWidget {
  final String username;


  DashboardPage({required this.username});


  @override
  _DashboardPageState createState() => _DashboardPageState();
}


class _DashboardPageState extends State<DashboardPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
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
                'Hello ${widget.username}',
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
            ElevatedButton(
              onPressed: () async {
                final expenseData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpensePage()),
                );
                if (expenseData != null) {
                  _addExpense(expenseData);
                }
              },
              child: Text('Add Expense'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsightPage()),
                );
              },
              child: Text('Insights'),
            ),
            ElevatedButton(
              onPressed: () async {
                final budgetData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetPage()),
                );
                if (budgetData != null) {
                  _addBudget(budgetData);
                }
              },
              child: Text('Budget'),
            ),
            ElevatedButton(
              onPressed: () async {
                final goalData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoalPage()),
                );
                if (goalData != null) {
                  _addGoal(goalData);
                }
              },
              child: Text('Goal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
