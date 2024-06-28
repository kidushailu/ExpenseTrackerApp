import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  final Map<String, dynamic>? expenseData;

  AddExpensePage({this.expenseData});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _durationValueController = TextEditingController();
  String? _duration = 'Days';
  final List<String> _durations = ['Days', 'Weeks', 'Months'];

  @override
  void initState() {
    super.initState();
    if (widget.expenseData != null) {
      _nameController.text = widget.expenseData!['name'];
      _amountController.text = widget.expenseData!['amount'].toString();
      _duration = widget.expenseData!['duration'];
      _durationValueController.text = widget.expenseData!['durationValue'].toString();
    }
  }

  void _saveExpense() {
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> expenseData = {
        'name': _nameController.text,
        'amount': double.parse(_amountController.text),
        'duration': _duration,
        'durationValue': int.parse(_durationValueController.text),
      };
      Navigator.pop(context, {'action': 'save', 'data': expenseData});
    }
  }

  void _deleteExpense() {
    Navigator.pop(context, {'action': 'delete'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expenseData == null ? 'Add Expense' : 'Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name of Expense'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the expense';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _duration,
                items: _durations.map((duration) {
                  return DropdownMenuItem(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _duration = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a duration';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _durationValueController,
                decoration: InputDecoration(labelText: 'Duration Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the duration value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveExpense,
                child: Text(widget.expenseData == null ? 'Add Expense' : 'Update Expense'),
              ),
              if (widget.expenseData != null) ...[
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _deleteExpense,
                  child: Text('Delete Expense'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _durationValueController.dispose();
    super.dispose();
  }
}
