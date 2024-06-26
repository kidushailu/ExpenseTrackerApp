import 'package:flutter/material.dart';


class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}


class _GoalPageState extends State<GoalPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _completionController = TextEditingController();
  String? _completionUnit = 'Days';
  final List<String> _completionUnits = ['Days', 'Weeks', 'Months'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Goal Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the goal title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Goal Amount (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the goal amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _completionController,
                decoration: InputDecoration(labelText: 'Complete Within'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the completion time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _completionUnit,
                items: _completionUnits.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _completionUnit = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Time Unit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a time unit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<String, dynamic> goalData = {
                      'title': _titleController.text,
                      'amount': double.parse(_amountController.text),
                    };
                    Navigator.pop(context, goalData);
                  }
                },
                child: Text('Set New Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _completionController.dispose();
    super.dispose();
  }
}
