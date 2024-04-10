import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final void Function(String?)? onChangedMDB;
  const MyDropdownButton({super.key, required this.onChangedMDB});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = 'Słoneczka';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.grey[300],
      value: dropdownValue,
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
          child: Image.asset('assets/images/zabki.png'),
        ),
      ],
    );
  }
}
