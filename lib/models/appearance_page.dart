import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class AppearancePage extends StatefulWidget {
  @override
  _AppearancePageState createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme().brightness == Brightness.dark;
    Color primaryColor = themeProvider.getTheme().primaryColor;

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
                themeProvider.toggleDarkMode(value);
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
                    themeProvider.changePrimaryColor(Colors.blue);
                  },
                ),
                ColorOption(
                  color: Colors.red,
                  selected: primaryColor == Colors.red,
                  onSelect: () {
                    themeProvider.changePrimaryColor(Colors.red);
                  },
                ),
                ColorOption(
                  color: Colors.green,
                  selected: primaryColor == Colors.green,
                  onSelect: () {
                    themeProvider.changePrimaryColor(Colors.green);
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
