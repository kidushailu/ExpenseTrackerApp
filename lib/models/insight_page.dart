import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'package:spendwell/helpers/bottom_bar.dart';
import '../helpers/app_bar.dart';
import '../helpers/pie_chart.dart';

class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> expenses = [];
  double _currentMonthTotal = 0.0;
  double _previousMonthTotal = 0.0;
  double _percentChange = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchMonthlyExpenses();
    _calculateMonthlyTotals();
  }

  Future<void> _fetchMonthlyExpenses() async {
    List<Map<String, dynamic>> data = await _dbHelper.getMonthlyExpenses();
    setState(() {
      expenses = data;
    });
  }

  Future<void> _calculateMonthlyTotals() async {
    DateTime now = DateTime.now();
    DateTime firstDayCurrentMonth = DateTime(now.year, now.month, 1);
    DateTime firstDayPreviousMonth = DateTime(now.year, now.month - 1, 1);
    DateTime lastDayPreviousMonth = DateTime(now.year, now.month, 0);

    List<Map<String, dynamic>> currentMonthExpenses =
        await _dbHelper.getExpensesBetweenDates(firstDayCurrentMonth, now);
    List<Map<String, dynamic>> previousMonthExpenses = await _dbHelper
        .getExpensesBetweenDates(firstDayPreviousMonth, lastDayPreviousMonth);

    setState(() {
      _currentMonthTotal = _calculateTotalExpenses(currentMonthExpenses);
      _previousMonthTotal = _calculateTotalExpenses(previousMonthExpenses);
      _percentChange =
          ((_previousMonthTotal - _currentMonthTotal) / _currentMonthTotal) *
              100;
    });
  }

  double _calculateTotalExpenses(List<Map<String, dynamic>> expenses) {
    return expenses.fold<double>(
        0.0, (sum, item) => sum + (item['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(page: "Insights"),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("Current Month Expenses: \$$_currentMonthTotal"),
          ),
          SizedBox(height: 15),
          _percentChange.isNegative
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.arrow_upward),
                  Text(
                    "${_percentChange.toStringAsFixed(2)}%",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(" Up from \$$_previousMonthTotal"),
                ])
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.arrow_downward),
                  Text(
                    "${_percentChange.toStringAsFixed(2)}%",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(" Down from \$$_previousMonthTotal"),
                ]),
          SizedBox(
            height: 25,
          ),
          CategoryInfo(),
          // Text(
          //   'This Month\'s Total Expenses: \$$_currentMonthTotal',
          //   style: TextStyle(fontSize: 18),
          // ),
          // SizedBox(height: 10),
          // Text(
          //   'Previous Month\'s Total Expenses: \$$_previousMonthTotal',
          //   style: TextStyle(fontSize: 18),
          // ),
          // SizedBox(height: 20),
          // Text(
          //   'Change: \$${(_currentMonthTotal - _previousMonthTotal).toStringAsFixed(2)}',
          //   style: TextStyle(
          //     fontSize: 18,
          //     color: (_currentMonthTotal - _previousMonthTotal) >= 0
          //         ? Colors.red
          //         : Colors.green,
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
