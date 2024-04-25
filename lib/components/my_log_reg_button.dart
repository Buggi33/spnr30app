import 'package:flutter/material.dart';

class MyLogRegButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color textColor;

  const MyLogRegButton({
    required this.textColor,
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 39, 73),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
