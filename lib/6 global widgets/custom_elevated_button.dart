import 'package:admin_app/6%20global%20widgets/text_wideget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon; // Make icon parameter optional
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final double borderWidth;

  const CustomElevatedButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon, // Make icon parameter optional
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h, // Scale height
      width: width.w, // Scale width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // Scale border radius
            side: BorderSide(
              color: borderColor, // Set the border color dynamically
              width: borderWidth, // Set the border width
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w, // Scale horizontal padding
            vertical: 8.h, // Scale vertical padding
          ), // Button padding
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align icon and text in center
          mainAxisSize: MainAxisSize.min, // Ensure the row fits its content
          children: [
            if (icon != null) // Conditionally render the icon if it's provided
              Icon(
                icon,
                color: iconColor,
                size: 30.sp, // Scale icon size
              ), // Customizable prefix icon
            if (icon != null)
              SizedBox(width: 8.w), // Add spacing if there's an icon
            CustomText(
              text: text,
              textType: TextType.bodyLarge,
              textWeight: TextWeight.regular,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
