import 'package:flutter/material.dart';

class MyAdmTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const MyAdmTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ),
    );
  }
}
