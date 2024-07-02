import 'package:flutter/material.dart';

// Define a stateless widget for a dashboard button
class DashBoardButton extends StatelessWidget {
  final dynamic page; // The page to navigate to when the button is pressed
  final String title; // The title text displayed below the button
  final dynamic icon; // The icon displayed on the button

  // Constructor to initialize the page, title, and icon
  const DashBoardButton(
      {super.key, required this.page, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            // Navigate to the specified page when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Icon(
            icon, // Display the specified icon on the button
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(50, 50), // Set the minimum size of the button
            shape: CircleBorder(), // Make the button circular
            backgroundColor:
                Colors.white, // Set the background color of the button
          ),
        ),
        Text(
          title, // Display the specified title below the button
          style: TextStyle(fontSize: 10), // Set the font size of the title
        ),
      ],
    );
  }
}
