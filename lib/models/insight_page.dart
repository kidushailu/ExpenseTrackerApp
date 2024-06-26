import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'package:intl/intl.dart';


class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}


class _InsightPageState extends State<InsightPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  double _currentMonthTotal = 0.0;
  double _previousMonthTotal = 0.0;


  @override
  void initState() {
    super.initState();
    _calculateMonthlyTotals();
  }


  Future<void> _calculateMonthlyTotals() async {
    DateTime now = DateTime.now();
    DateTime firstDayCurrentMonth = DateTime(now.year, now.month, 1);
    DateTime firstDayPreviousMonth = DateTime(now.year, now.month - 1, 1);
    DateTime lastDayPreviousMonth = DateTime(now.year, now.month, 0);


    List<Map<String, dynamic>> currentMonthExpenses = await _databaseHelper.getExpensesBetweenDates(firstDayCurrentMonth, now);
    List<Map<String, dynamic>> previousMonthExpenses = await _databaseHelper.getExpensesBetweenDates(firstDayPreviousMonth, lastDayPreviousMonth);


    setState(() {
      _currentMonthTotal = currentMonthExpenses.fold(0.0, (sum, item) => sum + item['amount']);
      _previousMonthTotal = previousMonthExpenses.fold(0.0, (sum, item) => sum + item['amount']);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Insights'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month\'s Total Expenses: \$$_currentMonthTotal',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Previous Month\'s Total Expenses: \$$_previousMonthTotal',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Change: \$${(_currentMonthTotal - _previousMonthTotal).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: (_currentMonthTotal - _previousMonthTotal) >= 0 ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
