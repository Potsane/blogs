import 'package:flutter/material.dart';

class OutlinedTextInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isTextMusked;

  const OutlinedTextInput({
    super.key,
    required this.hint,
    required this.controller,
    this.isTextMusked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: Theme.of(context).textTheme.labelMedium),
        TextFormField(
          obscureText: isTextMusked,
          decoration: InputDecoration(hintText: "Enter $hint"),
          validator: (value) {
            if (value!.isEmpty) {
              return "Value is missing!";
            }
            return null;
          },
        )
      ],
    );
  }
}
