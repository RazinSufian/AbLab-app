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
      padding: EdgeInsets.only(top: size.height*.02 , left: size.width*.25, right: size.width*.25 ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.activeBGColor, // Use provided color or default
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.5,
            MediaQuery.of(context).size.height * 0.05,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Replace with your desired text color
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
