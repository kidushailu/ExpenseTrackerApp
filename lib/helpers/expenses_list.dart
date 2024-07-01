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
      SizedBox(
        height: 30,
      ),
      Text(
        "Expenses List",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Container(
        height: 250,
        child: _expenses.isEmpty
            ? Center(child: Text('No expenses found'))
            : ListView.separated(
                itemCount: _expenses.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    leading: Text('•',
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).dividerColor)),
                    title: Text(
                      "${expense['category']}  |  \$${expense['amount'].toStringAsFixed(2)}  |  ${expense['name']}  |  ${expense['date']}",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
      ),
      ElevatedButton(
        onPressed: _clearExpenses,
        child: Text('Delete all expenses'),
      ),
    ]);
  }
}
