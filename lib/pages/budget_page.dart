import 'package:flutter/material.dart';


class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}


class _BudgetPageState extends State<BudgetPage> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _spendingMoneyController = TextEditingController();
  final TextEditingController _savingsController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();
  bool _notifyWhenLimitNear = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Income: \$',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 100, // Adjust the width as needed
                    child: TextField(
                      controller: _incomeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add logic to edit income
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildBudgetItem('Expenses', _expensesController),
              SizedBox(height: 20),
              _buildBudgetItem('Spending Money', _spendingMoneyController),
              SizedBox(height: 20),
              _buildBudgetItem('Savings', _savingsController),
              SizedBox(height: 20),
              Text(
                'Set Spending Limit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('Limit: \$'),
                  SizedBox(
                    width: 100, // Adjust the width as needed
                    child: TextField(
                      controller: _limitController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Notify when limit is near'),
                  Switch(
                    value: _notifyWhenLimitNear,
                    onChanged: (value) {
                      setState(() {
                        _notifyWhenLimitNear = value;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add logic to set limit
                },
                child: Text('Set'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBudgetItem(String title, TextEditingController controller) {
    return Row(
      children: [
        Text(
          '$title: \$',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 100, // Adjust the width as needed
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
