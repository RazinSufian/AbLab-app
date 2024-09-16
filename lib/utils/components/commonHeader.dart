import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import '../../res/image_assets.dart';
import '../../utils/utils.dart'; // Import the Utils class

class CommonHeader extends StatelessWidget {
  final String title;
  final bool hideBackButton;
  final VoidCallback? onBackPress;

  CommonHeader({
    required this.title,
    this.hideBackButton = false,
    this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.skyBGColor,
        child: Row(
          children: [
            if (!hideBackButton)
              IconButton(
                icon: Image.asset(
                  ImageAssets.backButton, // Change this to your actual asset path
                  width: 22,
                  height: 22,
                ),
                onPressed: () {
                  // Check if there's a route to pop
                  if (Navigator.of(context).canPop()) {
                    // If onBackPress is provided, call it, otherwise pop the navigator
                    if (onBackPress != null) {
                      onBackPress!(); // Call the onBackPress callback
                    } else {
                      Navigator.of(context).pop();
                    }
                  } else {
                    // If there's no page to go back to, show a flash message
                    Utils.showFlashMessage(
                      context: context,
                      message: 'No page to go back to',
                      backgroundColor: Colors.red,
                      icon: Icons.info_outline,
                    );
                  }
                },
              ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
