import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import '../../res/image_assets.dart';
import 'customText.dart';

class CustomPicker extends StatefulWidget {
  final String title;
  final String initialText;
  final String? selectedDateText;
  final VoidCallback selectDateFunction;
  final bool isRequired;

  const CustomPicker({
    super.key,
    required this.title,
    required this.initialText,
    this.selectedDateText,
    required this.selectDateFunction,
    this.isRequired = false,
  });

  @override
  State<CustomPicker> createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  @override
  Widget build(BuildContext context) {
    // Move MediaQuery inside the build method
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
      children: [
        Padding( // Padding around the Row
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust this padding as needed
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Center elements vertically
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: widget.selectDateFunction,
                  child: Padding(
                    padding:  EdgeInsets.only(top: screenHeight * 0.008),
                    child: Row(
                      children: [

                        // Add padding to the text
                        Text(
                          widget.selectedDateText ?? widget.initialText,
                          style: TextStyle(fontSize: 14, color: AppColors.blackColor, fontWeight: FontWeight.w400),
                        ),

                        SizedBox(width: screenWidth * 0.05),
                        Image.asset(
                          ImageAssets.calendarIcons,
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Add custom divider with padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding to align with text
          child: Container(
            margin:  EdgeInsets.only(top: screenWidth * 0.015), // Space above the line
            width: double.infinity, // Takes the full width of the parent
            height: .4, // Thickness of the divider
            color: AppColors.grayColor, // Color of the divider
          ),
        ),
      ],
    );
  }
}
