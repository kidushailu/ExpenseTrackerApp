import 'package:flutter/material.dart';
import '../database_helper.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    final expenses = await _dbHelper.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  Future<void> _clearExpenses() async {
    await _dbHelper.deleteAllExpenses();
    _fetchExpenses(); // Refresh data after clearing
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      ElevatedButton(
        onPressed: _clearExpenses,
        child: Text('Delete all expenses'),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Expenses List",
        textAlign: TextAlign.left,
      ),
      //Text("Category       Amount       Name       Date"),
      Container(
        height: 250,
        child: _expenses.isEmpty
            ? Center(child: Text('No expenses found'))
            : ListView.builder(
                itemCount: _expenses.length,
                itemExtent: 35,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "${expense['category']}    \$${expense['amount'].toStringAsFixed(2)}    ${expense['name']}    ${expense['date']}",
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                },
              ),
      ),
    ]);
  }
}
