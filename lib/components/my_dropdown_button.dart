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
      dropdownColor: Colors.grey[300],
      value: widget.value.isEmpty
          ? widget.value
          : (checkboxProvider.isCheckedSuns
              ? 'Suns'
              : (checkboxProvider.isCheckedOwls ? 'Owls' : 'Frogs')),
      underline: Container(
        color: Colors.grey,
      ),
      onChanged: widget.onChangedMDB,
      items: [
        if (checkboxProvider.isCheckedSuns)
          DropdownMenuItem<String>(
            alignment: Alignment.bottomCenter,
            value: "Suns",
            child: Image.asset('assets/images/sloneczka.png'),
          ),
        if (checkboxProvider.isCheckedOwls)
          DropdownMenuItem<String>(
            alignment: Alignment.bottomCenter,
            value: "Owls",
            child: Image.asset('assets/images/sowki.png'),
          ),
        if (checkboxProvider.isCheckedFrogs)
          DropdownMenuItem<String>(
            alignment: Alignment.bottomCenter,
            value: "Frogs",
            child: Align(child: Image.asset('assets/images/zabki.png')),
          ),
      ],
    );
  }
}
