import 'package:flutter/material.dart'; // Import necessary packages and files
import 'registration_page.dart';

// Define a StatefulWidget for the SplashScreen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Define the State class for SplashScreen
class _SplashScreenState extends State<SplashScreen> {
  // Override the initState method to perform initial setup
  @override
  void initState() {
    super
        .initState(); // Call the superclass method to ensure proper initialization
    _navigateToRegistration(); // Call the method to navigate to the RegistrationPage
  }

  // Define an asynchronous method to navigate to the RegistrationPage
  _navigateToRegistration() async {
    // Wait for 3 seconds before proceeding
    await Future.delayed(Duration(seconds: 3), () {});
    // Replace the current route with the RegistrationPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set the background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          children: [
            // Display the logo image in the center of the screen
            Image.asset(
              'assets/logo.png', // Path to the logo image asset (ensure this path is correct)
              width: 200, // Set the width of the logo
              height: 200, // Set the height of the logo
            ),
          ],
        ),
      ),
    );
  }
}
