import 'package:flutter/material.dart';


class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}


class _BudgetPageState extends State<BudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final _incomeController = TextEditingController();
  final _expensesController = TextEditingController();
  final _savingsController = TextEditingController();
  double _remainingAmount = 0.0;


  void _calculateRemainingAmount() {
    double income = double.tryParse(_incomeController.text) ?? 0.0;
    double expenses = double.tryParse(_expensesController.text) ?? 0.0;
    double savings = double.tryParse(_savingsController.text) ?? 0.0;
    setState(() {
      _remainingAmount = income - (expenses + savings);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Budget'),
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
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<String, dynamic> budgetData = {
                      'limit': _remainingAmount,
                    };
                    Navigator.pop(context, budgetData);
                  }
                },
                child: Text('Set Budget'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _incomeController.dispose();
    _expensesController.dispose();
    _savingsController.dispose();
    super.dispose();
  }
}
