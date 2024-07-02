import 'package:flutter/material.dart';
import 'add_expense_page.dart'; // Import the AddExpensePage to navigate to it
import '../helpers/bottom_bar.dart'; // Import BottomBar for the bottom navigation bar
import '../database_helper.dart'; // Import DatabaseHelper to interact with the database

// Define a stateful widget for the budget management page
class BudgetPage extends StatefulWidget {
  final Map<String, dynamic>?
      budgetData; // Optional parameter for initializing the budget data

  BudgetPage({this.budgetData}); // Constructor to accept optional budget data

  @override
  _BudgetPageState createState() =>
      _BudgetPageState(); // Create the state for BudgetPage
}

// Define the state for the BudgetPage widget
class _BudgetPageState extends State<BudgetPage> {
  final _formKey =
      GlobalKey<FormState>(); // Key to identify the form and validate it
  final _incomeController =
      TextEditingController(); // Controller for the income text field
  final _expensesController =
      TextEditingController(); // Controller for the expenses text field
  final _savingsController =
      TextEditingController(); // Controller for the savings text field
  double _remainingAmount =
      0.0; // Variable to store the remaining amount after expenses and savings

  @override
  void initState() {
    super.initState();
    // Initialize text fields with provided budget data if available
    if (widget.budgetData != null) {
      _incomeController.text = widget.budgetData!['income'].toString();
      _expensesController.text = widget.budgetData!['expenses'].toString();
      _savingsController.text = widget.budgetData!['savings'].toString();
      _calculateRemainingAmount(); // Recalculate remaining amount with provided data
    }
  }

  // Method to calculate the remaining amount
  void _calculateRemainingAmount() {
    double income = double.tryParse(_incomeController.text) ?? 0.0;
    double expenses = double.tryParse(_expensesController.text) ?? 0.0;
    double savings = double.tryParse(_savingsController.text) ?? 0.0;
    setState(() {
      _remainingAmount =
          income - (expenses + savings); // Update the remaining amount
    });
  }

  // Method to add the budget to the database
  void addBudget(budget) async {
    await DatabaseHelper().insertBudget(budget);
  }

  // Method to handle saving the budget data
  void _saveBudget() {
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> budgetData = {
        'income': double.parse(_incomeController.text),
        'expenses': double.parse(_expensesController.text),
        'savings': double.parse(_savingsController.text),
        'remainingAmount': _remainingAmount,
      };
      // Pass the budget data back to the previous screen and indicate the save action
      Navigator.pop(context, {'action': 'save', 'data': budgetData});
    }
  }

  // Method to handle deleting the budget data
  void _deleteBudget() {
    // Pass a delete action back to the previous screen
    Navigator.pop(context, {'action': 'delete'});
  }

  // Method to handle saving an expense
  void _handleExpenseSave(Map<String, dynamic> expenseData) {
    double currentExpenses = double.tryParse(_expensesController.text) ?? 0.0;
    double expenseAmount = expenseData['amount'];

    // Update expenses and recalculate remaining amount
    setState(() {
      _expensesController.text = (currentExpenses + expenseAmount).toString();
      _calculateRemainingAmount(); // Recalculate the remaining amount after adding the expense
    });
  }

  // Method to navigate to the AddExpensePage and handle the result
  Future<void> _navigateToAddExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpensePage()),
    );

    if (result != null && result['action'] == 'save') {
      _handleExpenseSave(result['data']); // Handle the saved expense data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Budget'), // Title of the app bar
        actions: [
          IconButton(
            icon: Icon(
                Icons.add), // Add icon button to navigate to AddExpensePage
            onPressed:
                _navigateToAddExpense, // Call the method to navigate to AddExpensePage
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the body
        child: Form(
          key: _formKey, // Set the form key for validation
          child: Column(
            children: [
              TextFormField(
                controller: _incomeController,
                decoration: InputDecoration(
                    labelText: 'Income (\$)'), // Input field for income
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your income'; // Validation message if income is not entered
                  }
                  return null;
                },
                onChanged: (value) =>
                    _calculateRemainingAmount(), // Recalculate remaining amount on change
              ),
              SizedBox(height: 10), // Add vertical space
              TextFormField(
                controller: _expensesController,
                decoration: InputDecoration(
                    labelText: 'Expenses (\$)'), // Input field for expenses
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your expenses'; // Validation message if expenses are not entered
                  }
                  return null;
                },
                onChanged: (value) =>
                    _calculateRemainingAmount(), // Recalculate remaining amount on change
              ),
              SizedBox(height: 10), // Add vertical space
              TextFormField(
                controller: _savingsController,
                decoration: InputDecoration(
                    labelText: 'Savings (\$)'), // Input field for savings
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your savings'; // Validation message if savings are not entered
                  }
                  return null;
                },
                onChanged: (value) =>
                    _calculateRemainingAmount(), // Recalculate remaining amount on change
              ),
              SizedBox(height: 20), // Add vertical space
              Text(
                'Remaining Amount: \$$_remainingAmount', // Display the remaining amount
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20), // Add vertical space
              ElevatedButton(
                onPressed: () {
                  addBudget({
                    'amount': _remainingAmount
                  }); // Add the budget to the database
                  _clearAllTextFields(); // Clear text fields after setting the budget
                },
                child: Text('Set Budget'), // Button text
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(), // Bottom navigation bar
    );
  }

  @override
  void dispose() {
    _incomeController.dispose(); // Dispose of the income text field controller
    _expensesController
        .dispose(); // Dispose of the expenses text field controller
    _savingsController
        .dispose(); // Dispose of the savings text field controller
    super.dispose(); // Call the superclass's dispose method
  }

  // Method to clear all text fields
  void _clearAllTextFields() {
    _incomeController.clear();
    _expensesController.clear();
    _savingsController.clear();
  }
}
