import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/checkbox_provider.dart';

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
    final checkboxProvider = Provider.of<CheckboxProvider>(context);
    return DropdownButton(
      icon: const Icon(
          color: Color.fromARGB(255, 245, 26, 64), Icons.arrow_drop_down),
      dropdownColor: Colors.grey[300],
      value: widget.value,
      underline: Container(
        color: Colors.grey,
      ),
      onChanged: widget.onChangedMDB,
      items: [
        const DropdownMenuItem<String>(
          value: 'Start',
          child: Row(
            children: [
              const SizedBox(width: 25),
              Text(
                  style: TextStyle(color: Color.fromARGB(255, 245, 26, 64)),
                  'Wybierz grupę'),
            ],
          ),
        ),
        if (checkboxProvider.isCheckedSuns)
          DropdownMenuItem<String>(
            value: "Suns",
            child: Row(
              children: [
                const SizedBox(width: 42),
                Image.asset('assets/images/sloneczka.png'),
              ],
            ),
          ),
        if (checkboxProvider.isCheckedOwls)
          DropdownMenuItem<String>(
            value: "Owls",
            child: Row(
              children: [
                const SizedBox(width: 60),
                Image.asset('assets/images/sowki.png'),
              ],
            ),
          ),
        if (checkboxProvider.isCheckedFrogs)
          DropdownMenuItem<String>(
            // alignment: Alignment.center,
            value: "Frogs",
            child: Row(
              children: [
                const SizedBox(width: 55),
                Image.asset('assets/images/zabki.png'),
              ],
            ),
          ),
      ],
    );
  }
}
