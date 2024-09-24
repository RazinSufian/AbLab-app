import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import '../../res/image_assets.dart';
import '../../utils/utils.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final bool hideBackButton;
  final VoidCallback? onBackPress;
  final VoidCallback? resetReportListView;

  CommonHeader({
    required this.title,
    this.hideBackButton = false,
    this.onBackPress,
    this.resetReportListView,
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
                  ImageAssets.backButton,
                  width: 22,
                  height: 22,
                ),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    if (resetReportListView != null) {
                      resetReportListView!(); // Reset the report list
                    }
                    if (onBackPress != null) {
                      onBackPress!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  } else {
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
