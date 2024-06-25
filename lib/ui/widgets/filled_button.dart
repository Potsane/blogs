import 'package:flutter/material.dart';

class FilledDefaultButton extends StatelessWidget {
  final void Function() onClick;
  final String text;

  const FilledDefaultButton(
      {super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(onPressed: onClick, child: Text(text)),
    );
  }
}
