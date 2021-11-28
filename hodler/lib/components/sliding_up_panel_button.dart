import 'package:flutter/material.dart';
import 'package:workshop_advanced/themes/colors.dart';

class SlidingUpPanelButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const SlidingUpPanelButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ThemeColors.accentColor,
        ),
        foregroundColor: MaterialStateProperty.all(
          Colors.black,
        ),
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 60),
        ),
      ),
      child: Text(text),
    );
  }
}
