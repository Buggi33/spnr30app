import 'package:flutter/material.dart';

class MyCheckboxSunsButton extends StatelessWidget {
  final bool isSwitchedSuns;
  final bool value;
  final void Function(bool?)? onChanged;
  final Widget? title;
  const MyCheckboxSunsButton({
    super.key,
    required this.onChanged,
    required this.isSwitchedSuns,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return isSwitchedSuns
        ? CheckboxListTile(
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            subtitle: Text(
              'Aktywne',
              style: TextStyle(fontSize: 13, color: Colors.green[400]),
            ),
            activeColor: const Color.fromARGB(255, 245, 26, 64),
            checkColor: Colors.white,
            tileColor: Colors.grey[200],
            controlAffinity: ListTileControlAffinity.leading,
            title: title,
            value: value,
            onChanged: onChanged,
          )
        : CheckboxListTile(
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            subtitle: Text(
              'Nieaktywne',
              style: TextStyle(fontSize: 13, color: Colors.red[400]),
            ),
            activeColor: Colors.grey,
            tileColor: Colors.grey[200],
            controlAffinity: ListTileControlAffinity.leading,
            title: title,
            value: false,
            onChanged: (value) {},
          );
  }
}
