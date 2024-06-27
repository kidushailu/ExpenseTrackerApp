import 'package:flutter/material.dart';

class AppearancePage extends StatefulWidget {
  @override
  _AppearancePageState createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  bool isDarkMode = false;
  Color primaryColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize Appearance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
                // Add logic to apply dark mode
              },
            ),
            SizedBox(height: 16),
            Text(
              'Choose Primary Color',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                ColorOption(
                  color: Colors.blue,
                  selected: primaryColor == Colors.blue,
                  onSelect: () {
                    setState(() {
                      primaryColor = Colors.blue;
                    });
                    // Add logic to apply primary color
                  },
                ),
                ColorOption(
                  color: Colors.red,
                  selected: primaryColor == Colors.red,
                  onSelect: () {
                    setState(() {
                      primaryColor = Colors.red;
                    });
                    // Add logic to apply primary color
                  },
                ),
                ColorOption(
                  color: Colors.green,
                  selected: primaryColor == Colors.green,
                  onSelect: () {
                    setState(() {
                      primaryColor = Colors.green;
                    });
                    // Add logic to apply primary color
                  },
                ),
                // Add more colors as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onSelect;

  ColorOption({required this.color, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selected ? Border.all(color: Colors.black, width: 3.0) : null,
        ),
        width: 40,
        height: 40,
      ),
    );
  }
}
