import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart'; // Import main.dart to access HomePage
import 'pages/add_page.dart'; // Import AddPage
import 'pages/insights_page.dart'; // Import InsightsPage
import 'pages/budget_page.dart'; // Import BudgetPage
import 'pages/goals_page.dart'; // Import GoalsPage


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}


class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, String>> _goals = [];


  void _addGoal(Map<String, String> goal) {
    setState(() {
      _goals.add(goal);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
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
              'Total Expense',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionChip(label: Text('Add'), onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPage()),
                    );
                  }),
                  SizedBox(width: 10),
                  ActionChip(label: Text('Insights'), onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InsightsPage()),
                    );
                  }),
                  SizedBox(width: 10),
                  ActionChip(label: Text('Budget'), onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BudgetPage()),
                    );
                  }),
                  SizedBox(width: 10),
                  ActionChip(label: Text('Goals'), onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalsPage(
                          onGoalSet: (goal) {
                            _addGoal(goal);
                          },
                        ),
                      ),
                    );
                  }),
                  SizedBox(width: 10),
                  ActionChip(label: Text('Settings'), onPressed: () {
                    // No action for Settings button
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(1, 1),
                          FlSpot(2, 4),
                          FlSpot(3, 3),
                          FlSpot(4, 2),
                        ],
                        isCurved: true,
                        colors: [Colors.blue],
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (BuildContext context, int index) {
                  final goal = _goals[index];
                  return ListTile(
                    title: Text('${goal['amount']} ${goal['currency']}'),
                    subtitle: Text('Duration: ${goal['duration']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
