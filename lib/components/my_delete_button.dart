import 'package:flutter/material.dart';

class MyDeleteButton extends StatelessWidget {
  final void Function()? onTap;
  final double size;
  const MyDeleteButton({
    super.key,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.delete,
        size: size,
        color: Colors.grey,
      ),
    );
  }
}
