import 'package:flutter/material.dart';

import '../../res/app_colors.dart';


class CustomText extends StatelessWidget {
  final String text;
  final bool isBold;
  final double fontSize;
  final Color textColor;
  final TextStyle? customStyle;

  const CustomText({
    Key? key,
    required this.text,
    this.isBold = false,
    this.fontSize = 20.0, // Default font size
    this.textColor = AppColors.blackColor, // Default text color
    this.customStyle, // Custom text style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: customStyle ?? TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
