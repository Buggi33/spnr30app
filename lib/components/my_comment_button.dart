import 'package:flutter/material.dart';

class MyCommentButton extends StatelessWidget {
  final void Function()? onTap;
  const MyCommentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.comment,
        color: Colors.grey[600],
      ),
    );
  }
}
