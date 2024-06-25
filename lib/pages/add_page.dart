import 'package:flutter/material.dart';


class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
  String? _selectedCategory;
  final List<String> _categories = [
    'Grocery',
    'Utilities',
    'Insurance',
    'Mortgage',
    'Miscellaneous'
  ];


  final TextEditingController _expenseNameController = TextEditingController();
  final List<Map<String, String>> _expenses = [];


  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _expenseNameController,
                decoration: InputDecoration(
                  labelText: 'Expense Name',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
                value: _selectedCategory,
                items: _categories.map((String category) {
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
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_expenseNameController.text.isNotEmpty && _selectedCategory != null) {
                  setState(() {
                    _expenses.add({
                      'name': _expenseNameController.text,
                      'category': _selectedCategory!,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }


  void _showEditDeleteExpenseDialog(Map<String, String> expense) {
    _expenseNameController.text = expense['name']!;
    _selectedCategory = expense['category'];


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit/Delete Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _expenseNameController,
                decoration: InputDecoration(
                  labelText: 'Expense Name',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
                value: _selectedCategory,
                items: _categories.map((String category) {
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
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _expenses.remove(expense);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_expenseNameController.text.isNotEmpty && _selectedCategory != null) {
                  setState(() {
                    expense['name'] = _expenseNameController.text;
                    expense['category'] = _selectedCategory!;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }


  void _showExpenseListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final filteredExpenses = _expenses.where((expense) => expense['category'] == _selectedCategory).toList();
        return AlertDialog(
          title: Text('Edit/Delete Expense'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredExpenses.length,
              itemBuilder: (BuildContext context, int index) {
                final expense = filteredExpenses[index];
                return ListTile(
                  title: Text(expense['name']!),
                  subtitle: Text(expense['category']!),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showEditDeleteExpenseDialog(expense);
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showAddExpenseDialog,
              child: Text('Add Expense'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category',
              ),
              value: _selectedCategory,
              items: _categories.map((String category) {
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showExpenseListDialog,
              child: Text('Edit / Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
