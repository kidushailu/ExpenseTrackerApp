import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

// AppearancePage is a StatefulWidget that allows users to customize the appearance of the app.
class AppearancePage extends StatefulWidget {
  @override
  _AppearancePageState createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the ThemeProvider instance from the context.
    // This provider is used to access and modify the current theme settings.
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Determine if the current theme is dark mode by checking the brightness property.
    bool isDarkMode = themeProvider.getTheme().brightness == Brightness.dark;

    // Get the current primary color used in the theme.
    Color primaryColor = themeProvider.getTheme().primaryColor;

    return Scaffold(
      // The Scaffold widget provides a high-level structure for the page.
      // It includes an AppBar and a body where we define the content of the page.
      appBar: AppBar(
        // The title displayed in the AppBar.
        title: Text('Appearance Settings'),
      ),
      body: Padding(
        // Add padding around the content of the page.
        // EdgeInsets.all(16.0) means 16 pixels of padding on all sides.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Arrange the widgets vertically with space between them.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // Title text for the customization section.
              'Customize Appearance',
              style: TextStyle(
                // Set the font size and weight for the title.
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              // A SwitchListTile widget displays a switch with a label.
              title: Text('Dark Mode'),
              // The value of the switch reflects whether dark mode is enabled.
              value: isDarkMode,
              onChanged: (bool value) {
                // When the switch is toggled, call toggleDarkMode on the themeProvider to change the theme.
                themeProvider.toggleDarkMode(value);
              },
            ),
            SizedBox(height: 16),
            Text(
              // Text to prompt the user to choose a primary color.
              'Choose Primary Color',
              style: TextStyle(
                // Set the font size and weight for the color selection title.
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              // The Wrap widget arranges its children in a horizontal or vertical sequence and wraps them to the next line as needed.
              spacing: 8.0, // Add horizontal space between the color options.
              children: [
                // List of color options that users can select as the primary color.

                ColorOption(
                  // Define a ColorOption widget with the color blue.
                  color: Colors.blue,
                  // Check if this color is currently selected.
                  selected: primaryColor == Colors.blue,
                  // When the color option is selected, change the primary color to blue.
                  onSelect: () {
                    themeProvider.changePrimaryColor(Colors.blue);
                  },
                ),
                ColorOption(
                  // Define a ColorOption widget with the color red.
                  color: Colors.red,
                  // Check if this color is currently selected.
                  selected: primaryColor == Colors.red,
                  // When the color option is selected, change the primary color to red.
                  onSelect: () {
                    themeProvider.changePrimaryColor(Colors.red);
                  },
                ),
                ColorOption(
                  // Define a ColorOption widget with the color green.
                  color: Colors.green,
                  // Check if this color is currently selected.
                  selected: primaryColor == Colors.green,
                  // When the color option is selected, change the primary color to green.
                  onSelect: () {
                    themeProvider.changePrimaryColor(Colors.green);
                  },
                ),
                // Add more ColorOption widgets for additional colors if needed.
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ColorOption is a StatelessWidget that represents a color choice in a circular button.
class ColorOption extends StatelessWidget {
  final Color color; // The color displayed in the option.
  final bool selected; // Indicates if this color is currently selected.
  final VoidCallback
      onSelect; // Callback to handle when this color is selected.

  // Constructor to initialize the ColorOption widget with color, selected state, and onSelect callback.
  ColorOption({
    required this.color,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // The GestureDetector widget detects gestures such as taps.
      onTap: onSelect, // Call the onSelect callback when this option is tapped.
      child: Container(
        // Container to style the appearance of the color option.
        decoration: BoxDecoration(
          color: color, // Set the background color of the option.
          shape: BoxShape.circle, // Make the option circular.
          // Add a border if this color option is selected.
          border: selected ? Border.all(color: Colors.black, width: 3.0) : null,
        ),
        width: 40, // Width of the color option.
        height: 40, // Height of the color option.
      ),
    );
  }
}
