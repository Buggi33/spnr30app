import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  final Color iconColor;
  final Color textColor;

  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
