import 'package:flutter/material.dart';


class GoalsPage extends StatefulWidget {
  final Function(Map<String, String>) onGoalSet;


  GoalsPage({required this.onGoalSet});


  @override
  _GoalsPageState createState() => _GoalsPageState();
}


class _GoalsPageState extends State<GoalsPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();


  String? _selectedCurrency;
  final List<String> _currencies = [
    'USD', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD', 'CHF', 'CNY', 'SEK', 'NZD'
    // Add more currencies as needed
  ];


  void _showSetGoalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Currency',
                ),
                value: _selectedCurrency,
                items: _currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCurrency = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duration (days/weeks/months)',
                ),
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
                if (_amountController.text.isNotEmpty && _selectedCurrency != null && _durationController.text.isNotEmpty) {
                  widget.onGoalSet({
                    'currency': _selectedCurrency!,
                    'amount': _amountController.text,
                    'duration': _durationController.text
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Set Goal'),
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
        title: Text('Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _showSetGoalDialog,
              child: Text('Set Goal'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 100, // Adjust the width as needed
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Currency',
                    ),
                    value: _selectedCurrency,
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCurrency = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter amount',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Duration: '),
                Expanded(
                  child: TextField(
                    controller: _durationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter duration (days/weeks/months)',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
