import 'package:flutter/material.dart';
import 'package:spendwell/helpers/bar_chart.dart';
import 'registration_page.dart';
import 'models/add_expense_page.dart';
import 'models/budget_page.dart';
import 'models/insight_page.dart';
import 'models/settings_page.dart';
import 'database_helper.dart';
import 'helpers/dash_buttons.dart';
import 'helpers/bottom_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchMonthlyExpenses();
  }

  Future<void> _fetchMonthlyExpenses() async {
    List<Map<String, dynamic>> data = await dbHelper.getExpensesByCategory();
    setState(() {
      expenses = data;
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
                style: TextStyle(fontSize: 18.0),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(
              height: 20,
            ),
            // expenses.isEmpty
            //     ? const Text("No data.")
            //     : BarChartWidget.withExpenseData(expenses),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
