import 'package:flutter/material.dart';

class DashBoardButton extends StatelessWidget {
  final dynamic page;
  final String title;
  final dynamic icon;

  const DashBoardButton(
      {super.key, required this.page, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Icon(
          icon,
          color: Colors.green,
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(50, 50),
            shape: CircleBorder(),
            backgroundColor: Colors.white),
      ),
      Text(
        title,
        style: TextStyle(fontSize: 10),
      ),
    ]);
  }
}
