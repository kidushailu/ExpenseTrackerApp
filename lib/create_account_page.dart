import 'package:flutter/material.dart';
import 'registration_page.dart';
import 'database_helper.dart';

// CreateAccountPage is a StatefulWidget that handles user account creation.
class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text input fields to manage user input
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // DatabaseHelper instance for database operations
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic layout structure for the page
      appBar: AppBar(
        // Title displayed in the AppBar
        title: Text('Create Account'),
      ),
      body: Padding(
        // Padding around the form to ensure proper spacing
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // Form widget to handle form validation
          key: _formKey,
          child: ListView(
            // ListView to allow scrolling if the keyboard covers the input fields
            children: [
              // Text field for first name input
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  // Validator checks if the field is empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10), // Space between form fields

              // Text field for last name input
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  // Validator checks if the field is empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10), // Space between form fields

              // Text field for email address input
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // Validator checks if the field is empty
                  // and ensures it is a valid email address
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10), // Space between form fields

              // Text field for phone number input
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  // Validator checks if the field is empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10), // Space between form fields

              // Text field for username input
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  // Validator checks if the field is empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10), // Space between form fields

              // Text field for password input
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // Hides the text for password input
                validator: (value) {
                  // Validator checks if the field is empty
                  // and ensures the password meets security requirements
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (!RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$')
                      .hasMatch(value)) {
                    return 'Password must be alphanumeric and 8-15 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Space before the submit button

              // ElevatedButton for submitting the form
              ElevatedButton(
                onPressed: () async {
                  // Check if the form is valid before proceeding
                  if (_formKey.currentState?.validate() ?? false) {
                    // Create a user map with form input data
                    Map<String, dynamic> user = {
                      'firstName': _firstNameController.text,
                      'lastName': _lastNameController.text,
                      'email': _emailController.text,
                      'phone': _phoneController.text,
                      'username': _usernameController.text,
                      'password': _passwordController.text,
                    };

                    // Insert the new user into the database
                    await _databaseHelper.insertUser(user);

                    // Show a success message using a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Account created successfully'),
                      ),
                    );

                    // Navigate to the RegistrationPage and remove all previous routes
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of text controllers to free up resources
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
