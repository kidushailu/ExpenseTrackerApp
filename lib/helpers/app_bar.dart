import 'package:flutter/material.dart';
import '../registration_page.dart';

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  final String page;

  HeaderBar({required this.page});

  @override
  _HeaderBarState createState() => _HeaderBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('${widget.page}'),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Hello!',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
