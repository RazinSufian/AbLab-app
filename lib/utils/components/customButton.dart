import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isDisabled;
  final double? borderRadius; // Optional parameter for button radius

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.isDisabled = false,
    this.borderRadius, // Accepting borderRadius as an optional argument
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0, // Default height for all buttons
      child: TextButton(
        onPressed: isDisabled ? null : () => onPressed(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16), // Horizontal padding only
          backgroundColor: isDisabled ? Colors.grey : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0), // Use provided radius or default to 8.0
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
