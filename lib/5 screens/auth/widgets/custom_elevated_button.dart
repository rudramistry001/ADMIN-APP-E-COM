import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData icon;
  final double height;
  final double width;
  final Color backgroundColor;

  const CustomElevatedButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.height,
    required this.width,
    required this.backgroundColor,
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
          backgroundColor: backgroundColor, // Set the button color to blue
          elevation: 2, // Optionally add some elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // Scale border radius
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
            Icon(
              icon,
              size: 20.sp, // Scale icon size
            ), // Customizable prefix icon
            SizedBox(width: 8.w), // Scale space between icon and text
            Text(
              text,
              style: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 18.sp, // Scale font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
