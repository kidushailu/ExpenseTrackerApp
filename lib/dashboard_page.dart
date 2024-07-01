import 'package:flutter/material.dart';
import 'helpers/bar_chart.dart';
import 'registration_page.dart';
import 'models/add_expense_page.dart';
import 'models/budget_page.dart';
import 'models/insight_page.dart';
import 'models/settings_page.dart';
import 'helpers/dash_buttons.dart';
import 'helpers/bottom_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          ),

          // Insert info here
          const SizedBox(height: 150),

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
