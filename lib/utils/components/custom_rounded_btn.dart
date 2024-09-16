import 'package:flutter/material.dart';


import '../../res/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;


  const CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor, // Optional parameter for background color

  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height*.03 , left: size.width*.10, right: size.width*.10 ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.skyBGColor, // Use provided color or default
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.55,
            MediaQuery.of(context).size.height * 0.05,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, // Use the same font size as in _buildTabItem
            fontWeight: FontWeight.w500, // Use the same font weight as in _buildTabItem
            color: Colors.white, // Keep the text color as white or customize it
          ),
        ),
      ),
    );
  }
}
