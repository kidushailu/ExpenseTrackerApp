import 'package:flutter/material.dart';
import '../registration_page.dart'; // Ensure the correct import path for the RegistrationPage

// AccountPage is a StatelessWidget that displays account-related options
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar for the AccountPage with a title
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        // Padding around the body content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Arrange children vertically with start alignment
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main title for the Account Settings page
            Text(
              'Account Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16), // Spacer with height of 16 pixels
            // ListTile to navigate to the AccountDetailsPage
            ListTile(
              leading: Icon(Icons.person), // Icon for viewing account details
              title: Text('View Account Details'), // Title of the ListTile
              onTap: () {
                // Navigate to AccountDetailsPage when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountDetailsPage()),
                );
              },
            ),
            // ListTile to navigate to the UpdateAccountPage
            ListTile(
              leading:
                  Icon(Icons.edit), // Icon for updating account information
              title:
                  Text('Update Account Information'), // Title of the ListTile
              onTap: () {
                // Navigate to UpdateAccountPage when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateAccountPage()),
                );
              },
            ),
            // ListTile for logging out of the account
            ListTile(
              leading: Icon(Icons.logout), // Icon for logging out
              title: Text('Logout'), // Title of the ListTile
              onTap: () {
                // Show a confirmation dialog for logging out
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'), // Dialog title
                      content: Text(
                          'Are you sure you want to logout?'), // Dialog content
                      actions: [
                        // Cancel button for the dialog
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        // Logout button for the dialog
                        TextButton(
                          child: Text('Logout'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            // Navigate to the RegistrationPage and remove all previous routes from the stack
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// AccountDetailsPage is a StatelessWidget that displays account details
class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar for the AccountDetailsPage with a title
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: Center(
        // Centered text indicating where the account details would go
        child: Text('Account details content goes here.'),
      ),
    );
  }
}

// UpdateAccountPage is a StatelessWidget for updating account information
class UpdateAccountPage extends StatelessWidget {
  // FormKey to manage the form state
  final _formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar for the UpdateAccountPage with a title
      appBar: AppBar(
        title: Text('Update Account Information'),
      ),
      body: Padding(
        // Padding around the form content
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associate the form with the form key
          child: Column(
            children: [
              // TextFormField for entering the name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name'; // Validation error message
                  }
                  return null; // Validation passes
                },
              ),
              // TextFormField for entering the email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'; // Validation error message
                  }
                  return null; // Validation passes
                },
              ),
              SizedBox(height: 20), // Spacer with height of 20 pixels
              // Button to save the updated account information
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, show a snackbar message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Account information updated')),
                    );
                    Navigator.pop(context); // Go back to the previous screen
                  }
                },
                child: Text('Save'), // Button text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
