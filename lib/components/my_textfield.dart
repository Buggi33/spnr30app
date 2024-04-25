import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final keybordType;
  final textInputAction;
  final maxLines;
  final onChanged;
  final focusNode;
  final TextStyle style;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.style,
    this.keybordType,
    this.textInputAction,
    this.maxLines,
    this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(context) {
    return TextField(
      style: style,
      cursorColor: const Color.fromARGB(255, 0, 39, 73),
      focusNode: focusNode,
      keyboardType: keybordType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 14,
        ),
      ),
    );
  }
}
