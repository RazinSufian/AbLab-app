import 'package:flutter/material.dart';
import '../../res/app_colors.dart';

class RoundInputField extends StatefulWidget {
  final String name;
  final bool? isPassword;
  TextInputType? type;
  final bool isReadOnly;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  RoundInputField({
    super.key,
    required this.name,
    this.isPassword = false,
    this.type,
    this.isReadOnly = false,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<RoundInputField> createState() => _RoundInputFieldState();
}

class _RoundInputFieldState extends State<RoundInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Adjust height and width dynamically
      height: screenHeight * 0.06, // 7% of screen height
      width: screenWidth * 0.9, // 90% of screen width
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
        border: Border.all(
          color: AppColors.grayColor, // Set the border color to gray
          width: 0.9,
        ),
        // Add shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25), // Shadow color
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              readOnly: widget.isReadOnly,
              style: TextStyle(fontSize: screenWidth * 0.035), // Adjust font size dynamically
              keyboardType: widget.type,
              obscureText: widget.isPassword! ? _obscureText : false,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.name,
                hintStyle: const TextStyle(color: AppColors.grayColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10.0),
              ),
            ),
          ),
          if (widget.isPassword!)
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                size: screenWidth * 0.06, // Adjust icon size dynamically
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
        ],
      ),
    );
  }
}
