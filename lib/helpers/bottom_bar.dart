// Importing necessary packages
import 'package:flutter/material.dart';
// Importing custom page widgets from other files
import '../dashboard_page.dart';
import '../models/budget_page.dart';
import '../models/account_page.dart';

// Defining a stateless widget called BottomBar
class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Building the widget tree for the BottomBar
    return BottomAppBar(
      // Setting the background color of the BottomAppBar
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        // Aligning the icons evenly across the bottom bar
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // IconButton for navigating to the DashboardPage
          IconButton(
            onPressed: () {
              // Navigating to DashboardPage when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                ),
              );
            },
            icon: Icon(
              Icons.home, // Icon representing the home page
            ),
          ),
          // IconButton for navigating to the BudgetPage
          IconButton(
            onPressed: () {
              // Navigating to BudgetPage when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BudgetPage()),
              );
            },
            icon: Icon(
              Icons.wallet, // Icon representing the budget page
            ),
          ),
          // IconButton for navigating to the AccountPage
          IconButton(
            onPressed: () {
              // Navigating to AccountPage when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            },
            icon: Icon(
              Icons
                  .account_circle_outlined, // Icon representing the account page
            ),
          ),
        ],
      ),
    );
  }
}
