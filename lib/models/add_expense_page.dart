import 'package:flutter/material.dart';
import '../helpers/expenses_list.dart';
import '../database_helper.dart';
import 'package:intl/intl.dart';

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
  final _categoryController = TextEditingController();
  String? _selectedCategory;
  final List<String> _categories = [
    'Bills',
    'Gas',
    'Groceries',
    'Restaurant',
    'Shopping',
    'Miscellaneous'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.expenseData != null) {
      _nameController.text = widget.expenseData!['name'];
      _amountController.text = widget.expenseData!['amount'].toString();
      _categoryController.text = widget.expenseData!['category'];
    }
  }

  // void _saveExpense() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     Map<String, dynamic> expenseData = {
  //       'name': _nameController.text,
  //       'amount': double.parse(_amountController.text),
  //       'category': _categoryController.text,
  //     };
  //     Navigator.pop(context, {'action': 'save', 'data': expenseData});
  //   }
  // }

  // void _deleteExpense() {
  //   Navigator.pop(context, {'action': 'delete'});
  // }

  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.expenseData == null ? 'Add Expense' : 'Edit Expense'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Form(
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
                  value: _selectedCategory,
                  hint: Text("Select a category"),
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isNotEmpty &&
                          double.parse(_amountController.text) > 0) {
                        await DatabaseHelper().insertExpense({
                          'name': _nameController.text,
                          'category': _selectedCategory,
                          'amount': double.tryParse(_amountController.text),
                          'date': getDate(),
                        }); //Navigator.pop(context);
                      }
                      setState(() {
                        _selectedCategory = null;
                        _clearAllTextFields();
                      });
                    },
                    child: Text("Add Expense")),
                // ElevatedButton(
                //   onPressed: _saveExpense,
                //   child: Text(widget.expenseData == null
                //       ? 'Add Expense'
                //       : 'Update Expense'),
                // ),
                // if (widget.expenseData != null) ...[
                //   SizedBox(height: 10),
                //   ElevatedButton(
                //     onPressed: _deleteExpense,
                //     child: Text('Delete Expense'),
                //     style:
                //         ElevatedButton.styleFrom(backgroundColor: Colors.red),
                //   ),
                // ],
                ExpensesList()
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _clearAllTextFields() {
    _nameController.clear();
    _categoryController.clear();
    _amountController.clear();
  }
}
