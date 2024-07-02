import 'package:flutter/material.dart';
import '../helpers/expenses_list.dart'; // Importing the ExpensesList widget
import '../database_helper.dart'; // Importing the DatabaseHelper for database operations
import 'package:intl/intl.dart'; // Importing intl package for date formatting
import '../helpers/bottom_bar.dart'; // Importing the BottomBar widget

// AddExpensePage is a StatefulWidget for adding or editing an expense
class AddExpensePage extends StatefulWidget {
  // Optional parameter to pass existing expense data for editing
  final Map<String, dynamic>? expenseData;

  // Constructor with an optional named parameter for expense data
  AddExpensePage({this.expenseData});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

// State class for AddExpensePage
class _AddExpensePageState extends State<AddExpensePage> {
  // Global key for managing the form's state
  final _formKey = GlobalKey<FormState>();
  // TextEditingController for managing the text input for name and amount
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  // Variable to hold the selected category from the dropdown
  String? _selectedCategory;
  // List of categories for the dropdown menu
  final List<String> _categories = [
    'Bills',
    'Gas',
    'Groceries',
    'Restaurant',
    'Shopping',
    'Miscellaneous'
  ];

  // Method to get the current date formatted as MM/dd/yyyy
  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with dynamic title based on whether expenseData is null
      appBar: AppBar(
        title:
            Text(widget.expenseData == null ? 'Add Expense' : 'Edit Expense'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        children: [
          Form(
            key: _formKey, // Attach the form key to the Form widget
            child: Column(
              children: [
                // TextFormField for entering the name of the expense
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name of Expense'),
                  validator: (value) {
                    // Validation for empty name field
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the expense';
                    }
                    return null; // Return null if the field is valid
                  },
                ),
                SizedBox(height: 10), // Spacer with height of 10 pixels
                // TextFormField for entering the amount of the expense
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount (\$)'),
                  keyboardType:
                      TextInputType.number, // Number keyboard for amount input
                  validator: (value) {
                    // Validation for empty amount field
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null; // Return null if the field is valid
                  },
                ),
                SizedBox(height: 10), // Spacer with height of 10 pixels
                // DropdownButtonFormField for selecting the expense category
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: Text(
                      "Select a category"), // Hint text when no category is selected
                  items: _categories.map((category) {
                    // Map each category to a DropdownMenuItem
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // Update the selected category
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    // Validation for empty category field
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null; // Return null if the field is valid
                  },
                ),
                SizedBox(height: 20), // Spacer with height of 20 pixels
                // ElevatedButton for submitting the form
                ElevatedButton(
                    onPressed: () async {
                      // Check if the form fields are valid
                      if (_formKey.currentState?.validate() ?? false) {
                        // Insert the expense into the database
                        await DatabaseHelper().insertExpense({
                          'name': _nameController.text,
                          'category': _selectedCategory,
                          'amount': double.tryParse(_amountController
                              .text), // Convert amount to double
                          'date': getDate(), // Get the current date
                        });

                        // Clear the form fields and reset the selected category
                        setState(() {
                          _selectedCategory = null;
                          _clearAllTextFields();
                        });

                        // Optionally, navigate back to the previous screen
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Add Expense")), // Button text
                ExpensesList() // Widget to display the list of expenses
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(), // Bottom navigation bar widget
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    _nameController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  // Method to clear all text fields
  void _clearAllTextFields() {
    _nameController.clear();
    _categoryController.clear();
    _amountController.clear();
  }
}
