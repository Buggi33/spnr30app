import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final String value;
  final void Function(String?)? onChangedMDB;
  const MyDropdownButton({
    super.key,
    required this.onChangedMDB,
    required this.value,
  });

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.grey[300],
      value: widget.value,
      underline: Container(
        color: Colors.grey,
      ),
      onChanged: widget.onChangedMDB,
      items: [
        DropdownMenuItem<String>(
          alignment: Alignment.bottomCenter,
          value: "Słoneczka",
          child: Image.asset('assets/images/sloneczka.png'),
        ),
        DropdownMenuItem<String>(
          alignment: Alignment.bottomCenter,
          value: "Sówki",
          child: Image.asset('assets/images/sowki.png'),
        ),
        DropdownMenuItem<String>(
          alignment: Alignment.bottomCenter,
          value: "Żabki",
          child: Align(child: Image.asset('assets/images/zabki.png')),
        ),
      ],
    );
  }
}
