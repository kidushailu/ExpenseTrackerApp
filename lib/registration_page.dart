import 'package:flutter/material.dart';
import 'create_account_page.dart';
import 'dashboard_page.dart';
import 'database_helper.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}


class _RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpendWell'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Sign in to your account',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Or register for an account here',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  Map<String, dynamic>? user = await _databaseHelper.getUser(username, password);
                  
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(username: username),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid username and password'),
                      ),
                    );
                  }
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountPage()),
                  );
                },
                child: Text('Create an Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
