import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  final dynamic page;
  final String title;

  SettingsList({super.key, required this.page, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              trailing: Icon(Icons.arrow_right),
              title: Text(title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            ),
            Divider(
              height: 2,
            )
          ],
        ));
  }
}
