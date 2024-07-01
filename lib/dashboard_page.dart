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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  double limit = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchBudgetData();
  }

  Future<void> _fetchBudgetData() async {
    Map<String, dynamic> budget = (await _dbHelper.getBudget()).last;
    setState(() {
      limit = budget['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Hello!',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          // Insert info here
          const SizedBox(height: 20),
          // if (_budget != null)
          Text(
            'Budget Spending Limit: \$${limit.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            DashBoardButton(
                page: AddExpensePage(), title: "Add Expense", icon: Icons.add),
            DashBoardButton(
                page: InsightPage(), title: "Insights", icon: Icons.pie_chart),
            DashBoardButton(
                page: BudgetPage(), title: "Budget", icon: Icons.wallet),
            DashBoardButton(
                page: SettingsPage(), title: "Settings", icon: Icons.settings),
          ]),
          SizedBox(
            height: 40,
          ),
          DailyExpenseChart()
          // expenses.isEmpty
          //     ? const Text("No data.")
          //     : BarChartWidget.withExpenseData(expenses),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
