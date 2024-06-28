import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: SpendWellApp(),
    ),
  );
}

class SpendWellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.getTheme(),
      home: SplashScreen(),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _primaryColor = Colors.blue;

  ThemeData getTheme() {
    return ThemeData(
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      primarySwatch: createMaterialColor(_primaryColor),
    );
  }

  void toggleDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  void changePrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
