import 'package:flutter/material.dart';

class UntitledOutlinedTextInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const UntitledOutlinedTextInput({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return "Value is missing!";
        }
        return null;
      },
    );
  }
}
