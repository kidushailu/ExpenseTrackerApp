import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    // Wrap the entire app in a ChangeNotifierProvider to provide the ThemeProvider to the widget tree
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Instantiate the ThemeProvider
      child:
          SpendWellApp(), // Start the app with SpendWellApp as the root widget
    ),
  );
}

// SpendWellApp is the root widget of the application
class SpendWellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtain the ThemeProvider instance from the context
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Build the MaterialApp widget with the theme provided by ThemeProvider
    return MaterialApp(
      theme: themeProvider.getTheme(), // Apply the current theme
      home: SplashScreen(), // Set the initial screen of the app to SplashScreen
    );
  }
}

// ThemeProvider manages the application's theme settings
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false; // Flag to track if dark mode is enabled
  Color _primaryColor = Colors.blue; // Primary color for the app

  // Method to get the current theme based on dark mode and primary color
  ThemeData getTheme() {
    return ThemeData(
      brightness: _isDarkMode
          ? Brightness.dark
          : Brightness.light, // Set brightness based on _isDarkMode
      primarySwatch: createMaterialColor(
          _primaryColor), // Generate a MaterialColor from _primaryColor
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(createMaterialColor(
                  _primaryColor)) // Set icon color for ElevatedButton
              )),
      appBarTheme: AppBarTheme(
          color: createMaterialColor(
              _primaryColor), // Set AppBar color based on _primaryColor
          iconTheme: IconThemeData(
              color: createMaterialColor(
                  Colors.white)), // Set icon color in AppBar
          titleTextStyle: TextStyle(
              color: createMaterialColor(
                  Colors.white), // Set title text color in AppBar
              fontSize: 25 // Set font size for AppBar title
              )),
    );
  }

  // Method to toggle dark mode and notify listeners of the change
  void toggleDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners(); // Notify listeners to rebuild widgets using the theme
  }

  // Method to change the primary color and notify listeners of the change
  void changePrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners(); // Notify listeners to rebuild widgets using the theme
  }
}

// Function to create a MaterialColor from a given Color
MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[
    .05
  ]; // Strength levels for the MaterialColor swatch
  Map<int, Color> swatch = {}; // Map to store the generated colors
  final int r = color.red,
      g = color.green,
      b = color.blue; // Extract RGB components from the base color

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i); // Generate strength levels for the swatch
  }

  // Generate colors for each strength level
  strengths.forEach((strength) {
    final double ds = 0.5 - strength; // Calculate the strength difference
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r +
          ((ds < 0 ? r : (255 - r)) * ds)
              .round(), // Calculate new red component
      g +
          ((ds < 0 ? g : (255 - g)) * ds)
              .round(), // Calculate new green component
      b +
          ((ds < 0 ? b : (255 - b)) * ds)
              .round(), // Calculate new blue component
      1, // Alpha value (fully opaque)
    );
  });

  // Return a MaterialColor with the base color value and the generated swatch
  return MaterialColor(color.value, swatch);
}
