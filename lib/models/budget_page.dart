import 'package:flutter/material.dart';
import 'add_expense_page.dart'; // Import your AddExpensePage
import '../helpers/bottom_bar.dart';
import '../database_helper.dart';

class BudgetPage extends StatefulWidget {
  final Map<String, dynamic>? budgetData;

  BudgetPage({this.budgetData});

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final _incomeController = TextEditingController();
  final _expensesController = TextEditingController();
  final _savingsController = TextEditingController();
  double _remainingAmount = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.budgetData != null) {
      _incomeController.text = widget.budgetData!['income'].toString();
      _expensesController.text = widget.budgetData!['expenses'].toString();
      _savingsController.text = widget.budgetData!['savings'].toString();
      _calculateRemainingAmount();
    }
  }

  void _calculateRemainingAmount() {
    double income = double.tryParse(_incomeController.text) ?? 0.0;
    double expenses = double.tryParse(_expensesController.text) ?? 0.0;
    double savings = double.tryParse(_savingsController.text) ?? 0.0;
    setState(() {
      _remainingAmount = income - (expenses + savings);
    });
  }

  void addBudget(budget) async {
    await DatabaseHelper().insertBudget(budget);
  }

  void _saveBudget() {
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> budgetData = {
        'income': double.parse(_incomeController.text),
        'expenses': double.parse(_expensesController.text),
        'savings': double.parse(_savingsController.text),
        'remainingAmount': _remainingAmount,
      };
      Navigator.pop(context, {'action': 'save', 'data': budgetData});
    }
  }

  void _deleteBudget() {
    Navigator.pop(context, {'action': 'delete'});
  }

  void _handleExpenseSave(Map<String, dynamic> expenseData) {
    double currentExpenses = double.tryParse(_expensesController.text) ?? 0.0;
    double expenseAmount = expenseData['amount'];

    // Update expenses and recalculate remaining amount
    setState(() {
      _expensesController.text = (currentExpenses + expenseAmount).toString();
      _calculateRemainingAmount(); // Recalculate remaining amount after adding expense
    });
  }

  Future<void> _navigateToAddExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpensePage()),
    );

    if (result != null && result['action'] == 'save') {
      _handleExpenseSave(result['data']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Budget'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddExpense,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _incomeController,
                decoration: InputDecoration(labelText: 'Income (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your income';
                  }
                  return null;
                },
                onChanged: (value) => _calculateRemainingAmount(),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _expensesController,
                decoration: InputDecoration(labelText: 'Expenses (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your expenses';
                  }
                  return null;
                },
                onChanged: (value) => _calculateRemainingAmount(),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _savingsController,
                decoration: InputDecoration(labelText: 'Savings (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your savings';
                  }
                  return null;
                },
                onChanged: (value) => _calculateRemainingAmount(),
              ),
              SizedBox(height: 20),
              Text(
                'Remaining Amount: \$$_remainingAmount',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addBudget({'amount': _remainingAmount});
                  _clearAllTextFields();
                },
                child: Text('Set Budget'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _expensesController.dispose();
    _savingsController.dispose();
    super.dispose();
  }

  void _clearAllTextFields() {
    _incomeController.clear();
    _expensesController.clear();
    _savingsController.clear();
  }
}
