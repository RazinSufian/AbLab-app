import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/image_assets.dart';

class Utils {

  // Utility function to show a flash message with customizable text, icon, and background color
  static void showFlashMessage({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    IconData? icon, // Optional icon parameter
    FlushbarPosition position = FlushbarPosition.BOTTOM, // Optional parameter to set position
    Duration duration = const Duration(seconds: 3), // Optional parameter to set duration
  }) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      message: message,
      duration: duration,
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: position,
      backgroundColor: backgroundColor,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      icon: icon != null ? Icon(icon, size: 28, color: Colors.white) : null,
    ).show(context); // Show the flushbar directly
  }


  // The existing utility functions...

  static Future showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Return false to prevent the dialog from being closed
            return false;
          },
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(child: Image.asset(ImageAssets.loadingGif, width: 245, height: 245)),
          ),
        );
      },
    );
  }

  static void cancelLoading(BuildContext context) {
    Navigator.pop(context);
  }

// Other existing utility functions...
}

Widget spaceHeight({required BuildContext context, required double size}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * size * 0.01,
  );
}

Widget spaceWidth({required BuildContext context, required double size}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * size * 0.01,
  );
}

Widget customDivider({Color? color}) {
  return Divider(
    height: 30,
    thickness: 1,
    indent: 0,
    color: color ?? AppColors.lineColor, // Use the passed color or default to AppColors.lineColor
  );
}
