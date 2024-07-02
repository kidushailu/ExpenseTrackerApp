import 'package:flutter/material.dart';
import 'helpers/bar_chart.dart';
import 'registration_page.dart';
import 'models/add_expense_page.dart';
import 'models/budget_page.dart';
import 'models/insight_page.dart';
import 'models/settings_page.dart';
import 'helpers/dash_buttons.dart';
import 'helpers/bottom_bar.dart';
import 'database_helper.dart';

/// DashboardPage is the main page for displaying summary information and providing navigation options.
class DashboardPage extends StatefulWidget {
  const DashboardPage(
      {super.key}); // Constructor with an optional key parameter

  @override
  _DashboardPageState createState() =>
      _DashboardPageState(); // Creates the state for the DashboardPage
}

class _DashboardPageState extends State<DashboardPage> {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); // Instance of DatabaseHelper for database operations
  double limit = 0.0; // Variable to store the budget spending limit

  @override
  void initState() {
    super.initState();
    _fetchBudgetData(); // Fetch the budget data when the widget is first built
  }

  /// Fetches the budget data from the database and updates the limit state variable.
  Future<void> _fetchBudgetData() async {
    // Get the last budget record from the database
    Map<String, dynamic> budget = (await _dbHelper.getBudget()).last;
    setState(() {
      limit = budget['amount']; // Update the limit with the budget amount
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'), // Title of the app bar
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0), // Padding around the greeting text
            child: Center(
              child: Text(
                'Hello!', // Greeting text displayed on the right side of the app bar
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white), // Text style for the greeting
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout), // Logout icon button
            onPressed: () {
              // Navigate to the RegistrationPage and clear the navigation stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(
            16.0), // Padding around the content of the ListView
        children: [
          const Text(
            'Summary', // Heading text for the summary section
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold), // Text style for the heading
            textAlign: TextAlign.center, // Center align the heading text
          ),
          const SizedBox(
              height:
                  20), // Space between the heading and the budget limit text
          Text(
            'Budget Spending Limit: \$${limit.toStringAsFixed(2)}', // Display the budget limit with 2 decimal places
            style: TextStyle(fontSize: 18), // Text style for the budget limit
            textAlign: TextAlign.center, // Center align the budget limit text
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Distribute buttons evenly within the row
            children: [
              DashBoardButton(
                  page: AddExpensePage(),
                  title: "Add Expense",
                  icon: Icons.add), // Button for adding a new expense
              DashBoardButton(
                  page: InsightPage(),
                  title: "Insights",
                  icon: Icons.pie_chart), // Button for viewing insights
              DashBoardButton(
                  page: BudgetPage(),
                  title: "Budget",
                  icon: Icons.wallet), // Button for managing the budget
              DashBoardButton(
                  page: SettingsPage(),
                  title: "Settings",
                  icon: Icons.settings), // Button for accessing settings
            ],
          ),
          SizedBox(
            height: 40,
          ),
          DailyExpenseChart() // Expenses chart
        ],
      ),
      bottomNavigationBar:
          BottomBar(), // Bottom navigation bar for the dashboard page
    );
  }
}
