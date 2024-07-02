import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database_helper.dart';
import 'package:spendwell/helpers/bottom_bar.dart';
import '../helpers/pie_chart.dart';

// InsightPage is a StatefulWidget that displays insights based on the user's expenses.
class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  // DatabaseHelper instance to interact with the expense database.
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Variables to store expenses and financial calculations.
  List<Map<String, dynamic>> expenses = [];
  double _currentMonthTotal = 0.0;
  double _previousMonthTotal = 0.0;
  double _percentChange = 0.0;

  @override
  void initState() {
    super.initState();
    // Fetch monthly expenses and calculate totals when the widget is first created.
    _fetchMonthlyExpenses();
    _calculateMonthlyTotals();
  }

  // Format the given date to 'MM/dd/yyyy' format.
  String getDate(date) {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(date);
  }

  // Fetch expenses for the current and previous month from the database.
  Future<void> _fetchMonthlyExpenses() async {
    List<Map<String, dynamic>> data = await _dbHelper.getMonthlyExpenses();
    setState(() {
      expenses = data;
    });
  }

  // Calculate the total expenses for the current and previous month, and compute the percentage change.
  Future<void> _calculateMonthlyTotals() async {
    DateTime now = DateTime.now();
    // Define the first day of the current and previous months, and the last day of the previous month.
    String firstDayCurrentMonth = getDate(DateTime(now.year, now.month, 1));
    String firstDayPreviousMonth =
        getDate(DateTime(now.year, now.month - 1, 1));
    String lastDayPreviousMonth = getDate(DateTime(now.year, now.month, 0));
    String nowFormatted = getDate(DateTime.now());

    // Fetch expenses between the defined dates.
    List<Map<String, dynamic>> currentMonthExpenses = await _dbHelper
        .getExpensesBetweenDates(firstDayCurrentMonth, nowFormatted);
    List<Map<String, dynamic>> previousMonthExpenses = await _dbHelper
        .getExpensesBetweenDates(firstDayPreviousMonth, lastDayPreviousMonth);

    setState(() {
      // Calculate the total expenses for the current and previous months.
      _currentMonthTotal = _calculateTotalExpenses(currentMonthExpenses);
      _previousMonthTotal = _calculateTotalExpenses(previousMonthExpenses);

      // Compute the percentage change between the current and previous month's expenses.
      if (_previousMonthTotal == 0 && _currentMonthTotal == 0) {
        _percentChange = 0;
      } else if (_previousMonthTotal == 0 && _currentMonthTotal > 0) {
        _percentChange = 100;
      } else {
        _percentChange =
            ((_currentMonthTotal - _previousMonthTotal) / _previousMonthTotal) *
                100;
      }
    });
  }

  // Calculate the total expenses from a list of expense records.
  double _calculateTotalExpenses(List<Map<String, dynamic>> expenses) {
    return expenses.fold<double>(0.0, (sum, item) => sum + (item['amount']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic layout structure for the page.
      appBar: AppBar(
        // Title displayed in the AppBar.
        title: const Text('Insights'),
      ),
      body: Column(
        // Main axis alignment is center to place content in the middle of the page.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // Display the total expenses for the current month.
              Text(
                "Current Month Expenses: \$$_currentMonthTotal",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15), // Space between elements.
              // Display the percentage change and corresponding icon based on whether it is positive or negative.
              _percentChange.isNegative
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.arrow_downward),
                      Text(
                        "${_percentChange.toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(" Down from \$$_previousMonthTotal"),
                    ])
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.arrow_upward),
                      Text(
                        "${_percentChange.toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(" Up from \$$_previousMonthTotal"),
                    ]),
            ],
          ),
          SizedBox(height: 25), // Space between elements.
          CategoryInfo(), // Display a widget that provides information about expense categories.
        ],
      ),
      bottomNavigationBar:
          BottomBar(), // Displays the bottom navigation bar for the app.
    );
  }
}
