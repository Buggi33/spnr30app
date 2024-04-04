import 'package:flutter/material.dart';

class MyComment extends StatelessWidget {
  final String text;
  final String username;
  final String time;
  const MyComment({
    super.key,
    required this.text,
    required this.time,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//comment text
          Text(text),
          const SizedBox(height: 5),
//comment sector of username and time
          Row(
            children: [
//comment username
              Text(
                username,
                style: const TextStyle(color: Colors.grey),
              ),
//cosmetic space between
              const Text("  "),
//comment time
              Text(
                time,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
