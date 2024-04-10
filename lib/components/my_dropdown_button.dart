import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = 'suns';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.grey[300],
      value: dropdownValue,
      underline: Container(
        color: Colors.grey,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: [
        DropdownMenuItem<String>(
          alignment: Alignment.bottomCenter,
          value: "suns",
          child: Image.asset('assets/images/sloneczka.png'),
        ),
        DropdownMenuItem<String>(
          alignment: Alignment.bottomCenter,
          value: "owls",
          child: Image.asset('assets/images/sowki.png'),
        ),
        DropdownMenuItem<String>(
          alignment: Alignment.bottomCenter,
          value: "frogs",
          child: Image.asset('assets/images/zabki.png'),
        ),
      ],
    );
  }
}
