import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../database_helper.dart';

// Define a StatefulWidget to represent the daily expense chart
class DailyExpenseChart extends StatefulWidget {
  @override
  _DailyExpenseChartState createState() => _DailyExpenseChartState();
}

// Define the state for the DailyExpenseChart widget
class _DailyExpenseChartState extends State<DailyExpenseChart> {
  List<double> dailyExpenses = []; // List to store daily expenses

  @override
  void initState() {
    super.initState();
    _fetchExpenses(); // Fetch expenses when the widget is initialized
  }

  // Asynchronously fetch expenses from the database
  Future<void> _fetchExpenses() async {
    final dbHelper =
        DatabaseHelper(); // Create an instance of the database helper
    final expenses =
        await dbHelper.getExpenses(); // Get expenses from the database
    setState(() {
      dailyExpenses = _calculateDailyExpenses(
          expenses); // Calculate daily expenses and update state
    });
  }

  // Calculate daily expenses from the list of expenses fetched from the database
  List<double> _calculateDailyExpenses(List<Map<String, dynamic>> expenses) {
    List<double> dailyExpenses = List.generate(
        7,
        (_) =>
            0.0); // Initialize a list with 7 zeros (one for each day of the week)
    for (var expense in expenses) {
      DateTime date =
          _parseDate(expense['date']); // Parse the date from the expense record
      double amount =
          expense['amount']; // Get the amount from the expense record
      int dayOfWeek =
          date.weekday - 1; // Convert to 0-based index (Mon=0, Sun=6)
      dailyExpenses[dayOfWeek] +=
          amount; // Add the amount to the corresponding day of the week
    }
    return dailyExpenses;
  }

  // Parse a date string in the format MM/DD/YYYY and return a DateTime object
  DateTime _parseDate(String date) {
    List<String> parts = date.split('/'); // Split the date string into parts
    int month = int.parse(parts[0]); // Parse the month
    int day = int.parse(parts[1]); // Parse the day
    int year = int.parse(parts[2]); // Parse the year
    return DateTime(year, month, day); // Create and return a DateTime object
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Daily Expenses Chart",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          child: dailyExpenses.isEmpty
              ? const Text(
                  "No data.",
                  textAlign: TextAlign.center,
                )
              : _buildBarChart(
                  dailyExpenses, Theme.of(context).primaryColorLight),
        ),
      ],
    );
  }
}

// Function to build a bar chart using the FLChart library
Widget _buildBarChart(List<double> data, Color color) {
  if (data.isEmpty) {
    return Center(child: Text("No data."));
  }

  return BarChart(
    BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: data.isNotEmpty
          ? data.reduce((a, b) => a > b ? a : b) + 5
          : 20, // Set the max Y value for the chart
      barTouchData: BarTouchData(enabled: false), // Disable touch interactions
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: TextStyle(fontSize: 12),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              Widget text;
              switch (value.toInt()) {
                case 0:
                  text = const Text('Mon', style: style);
                  break;
                case 1:
                  text = const Text('Tue', style: style);
                  break;
                case 2:
                  text = const Text('Wed', style: style);
                  break;
                case 3:
                  text = const Text('Thu', style: style);
                  break;
                case 4:
                  text = const Text('Fri', style: style);
                  break;
                case 5:
                  text = const Text('Sat', style: style);
                  break;
                case 6:
                  text = const Text('Sun', style: style);
                  break;
                default:
                  text = const Text('', style: style);
                  break;
              }
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: text,
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: data
          .asMap()
          .entries
          .map((entry) => BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    toY: entry.value,
                    color: color,
                    width: 16,
                  ),
                ],
              ))
          .toList(),
    ),
  );
}
