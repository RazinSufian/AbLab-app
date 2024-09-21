import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final bool isDisabled;
  final double? borderRadius; // Optional parameter for button radius
  final double? width; // Optional parameter for button width
  final double borderWidth; // New parameter for border width
  final FontWeight textWeight; // New parameter for text weight

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent, // Default to transparent
    this.isDisabled = false,
    this.borderRadius, // Accepting borderRadius as an optional argument
    this.width, // Accepting width as an optional argument
    this.borderWidth = 1.0, // Default border width
    this.textWeight = FontWeight.normal, // Default text weight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.03,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth), // Use borderWidth
        borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
        color: backgroundColor,
      ),
      child: TextButton(
        onPressed: isDisabled ? null : () => onPressed(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 2),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 13.0,
            fontFamily: "Roboto Slab",
            fontWeight: textWeight, // Use textWeight
          ),
        ),
      ),
    );
  }
}
