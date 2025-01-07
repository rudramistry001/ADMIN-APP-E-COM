import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldLabel extends StatelessWidget {
  final String? labelText;
  final FontWeight? fontWeight;
  final Color? fontColor;

  const CustomTextFieldLabel(
      {super.key, this.labelText, this.fontWeight, this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        labelText!,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
