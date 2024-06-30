import 'package:flutter/material.dart';
import '../dashboard_page.dart';
import '../models/budget_page.dart';
import '../models/account_page.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              icon: Icon(
                Icons.home,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetPage()),
                );
              },
              icon: Icon(
                Icons.wallet,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.green,
              ))
        ],
      ),
    );
  }
}
