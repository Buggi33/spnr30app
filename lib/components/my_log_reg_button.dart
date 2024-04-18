import 'package:flutter/material.dart';

class MyLogRegButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyLogRegButton({required this.onTap, required this.text, super.key});

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
