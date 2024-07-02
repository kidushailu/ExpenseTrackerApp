import 'package:flutter/material.dart';
import '../database_helper.dart';

// Define a stateful widget to display a list of expenses
class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

// Define the state for the ExpensesList widget
class _ExpensesListState extends State<ExpensesList> {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); // Create an instance of the database helper
  List<Map<String, dynamic>> _expenses = []; // List to store the expenses

  @override
  void initState() {
    super.initState();
    _fetchExpenses(); // Fetch expenses when the widget is initialized
  }

  // Asynchronously fetch expenses from the database
  Future<void> _fetchExpenses() async {
    final expenses =
        await _dbHelper.getExpenses(); // Get expenses from the database
    setState(() {
      _expenses = expenses; // Update the state with the fetched expenses
    });
  }

  // Asynchronously delete all expenses from the database
  Future<void> _clearExpenses() async {
    await _dbHelper
        .deleteAllExpenses(); // Delete all expenses from the database
    _fetchExpenses(); // Refresh data after clearing
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30), // Add a space at the top
        Text(
          "Expenses List",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // Title text
        ),
        Container(
          height: 250, // Set the height of the container for the list
          child: _expenses.isEmpty
              ? Center(
                  child: Text(
                      'No expenses found')) // Display message if no expenses are found
              : ListView.separated(
                  itemCount: _expenses.length, // Number of items in the list
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Colors.grey,
                  ), // Divider between list items
                  itemBuilder: (context, index) {
                    final expense = _expenses[
                        index]; // Get the expense at the current index
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 8), // Padding for list item
                      leading: Text(
                        '•',
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).dividerColor,
                        ),
                      ), // Leading bullet point
                      title: Text(
                        "${expense['category']}  |  \$${expense['amount'].toStringAsFixed(2)}  |  ${expense['name']}  |  ${expense['date']}",
                        style: TextStyle(fontSize: 14),
                      ), // Expense details
                    );
                  },
                ),
        ),
        ElevatedButton(
          onPressed:
              _clearExpenses, // Clear all expenses when the button is pressed
          child: Text('Delete all expenses'),
        ),
      ],
    );
  }
}
