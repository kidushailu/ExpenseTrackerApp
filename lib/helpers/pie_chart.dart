import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryInfo extends StatefulWidget {
  @override
  _CategortInfoState createState() => _CategortInfoState();
}

class _CategortInfoState extends State<CategoryInfo> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _expensesByCategory = [];
  double _totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchExpensesByCategory();
    _fetchTotalExpenses();
  }

  // Fetches the expenses data by category
  Future<void> _fetchExpensesByCategory() async {
    final expenses = await _dbHelper.getExpensesByCategory();
    setState(() {
      _expensesByCategory = expenses;
    });
  }

  // Fetches the total expenses
  Future<void> _fetchTotalExpenses() async {
    final totalExpenses = await _dbHelper.getTotalExpenses();
    setState(() {
      _totalExpenses = totalExpenses;
    });
  }

  // Builds overall widget with pie chart and
  // title, and a list of the top categories.
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "Spending Analyzer",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Container(
          height: 320,
          width: 320,
          child: Padding(
              padding: const EdgeInsets.all(1.0), child: _buildPieChart())),
      Text(
        "Top Categories",
        textAlign: TextAlign.left,
      )
    ]);
  }

  // Widget method to create the pie chart
  Widget _buildPieChart() {
    if (_expensesByCategory.isEmpty) {
      return Center(child: Text("No Expense Data."));
    }

    // A list of colors to use in the pie chart
    List<Color> colorList = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ];

    // Create pie slices
    List<PieChartSectionData> sections =
        _expensesByCategory.asMap().entries.map((entry) {
      int idx = entry.key;
      Map<String, dynamic> expense = entry.value;
      final category = expense['category'];
      final total = expense['total'];
      final percent = (total / _totalExpenses) * 100;
      return PieChartSectionData(
        title: "$category ${percent.toStringAsFixed(2)}%",
        value: total,
        radius: 150,
        color: colorList[idx % colorList.length],
        titleStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    // Returns the pie chart
    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 0,
        sectionsSpace: 1,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {},
        ),
      ),
    );
  }
}
