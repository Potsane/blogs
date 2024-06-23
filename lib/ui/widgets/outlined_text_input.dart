import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';

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
        Text(
          hint,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppPallete.mandy,
          ),
        ),
        TextFormField(
          obscureText: isTextMusked,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppPallete.citron),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppPallete.citron),
            ),
            hintText: "Enter $hint",
          ),
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
