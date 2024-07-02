import 'package:flutter/material.dart';
import 'create_account_page.dart';
import 'dashboard_page.dart';
import 'database_helper.dart';

// RegistrationPage is the widget for user sign-in and account creation
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() =>
      _RegistrationPageState(); // Creates the state for RegistrationPage
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Controllers for the text fields to get user input
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instance of DatabaseHelper for database operations
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpendWell'), // Title of the app bar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Padding around the content of the page
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center align the column content
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Stretch the column to fill the available width
            children: [
              Text(
                'Sign in to your account', // Heading text for the sign-in section
                style: TextStyle(fontSize: 24.0), // Style for the heading text
                textAlign: TextAlign.center, // Center align the heading text
              ),
              SizedBox(
                  height:
                      10), // Space between the heading text and the secondary text
              Text(
                'Or register for an account here', // Secondary text for registration prompt
                style:
                    TextStyle(fontSize: 16.0), // Style for the secondary text
                textAlign: TextAlign.center, // Center align the secondary text
              ),
              SizedBox(
                  height:
                      20), // Space between the secondary text and the username field
              TextField(
                controller:
                    _usernameController, // Controller for the username text field
                decoration: InputDecoration(
                  labelText: 'Username', // Label text for the username field
                  border: OutlineInputBorder(), // Border for the username field
                ),
              ),
              SizedBox(
                  height:
                      20), // Space between the username field and the password field
              TextField(
                controller:
                    _passwordController, // Controller for the password text field
                decoration: InputDecoration(
                  labelText: 'Password', // Label text for the password field
                  border: OutlineInputBorder(), // Border for the password field
                ),
                obscureText:
                    true, // Hides the text entered in the password field
              ),
              SizedBox(
                  height:
                      20), // Space between the password field and the sign-in button
              ElevatedButton(
                onPressed: () async {
                  // Retrieve the text from the username and password fields
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  // Check if the username and password match a user in the database
                  Map<String, dynamic>? user =
                      await _databaseHelper.getUser(username, password);

                  if (user != null) {
                    // Navigate to the DashboardPage if the user exists
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    );
                  } else {
                    // Show an error message if the user does not exist
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please enter a valid username and password'),
                      ),
                    );
                  }
                },
                child: Text('Sign In'), // Text displayed on the sign-in button
              ),
              SizedBox(
                  height:
                      10), // Space between the sign-in button and the create account link
              TextButton(
                onPressed: () {
                  // Navigate to the CreateAccountPage when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccountPage()),
                  );
                },
                child: Text(
                    'Create an Account'), // Text displayed on the create account link
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
