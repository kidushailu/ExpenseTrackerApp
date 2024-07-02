import 'package:flutter/material.dart';

// Define a stateless widget to display a settings list item
class SettingsList extends StatelessWidget {
  final dynamic page; // The page to navigate to when the list item is tapped
  final String title; // The title text displayed in the list item

  // Constructor to initialize the page and title
  SettingsList({super.key, required this.page, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, // Center the container's content
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the column's content
        children: [
          ListTile(
            trailing: Icon(
                Icons.arrow_right), // Add an arrow icon to the trailing end
            title: Text(title), // Display the title text
            onTap: () {
              // Navigate to the specified page when the list item is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          ),
          Divider(
            height: 2, // Add a divider below the list item
          ),
        ],
      ),
    );
  }
}
