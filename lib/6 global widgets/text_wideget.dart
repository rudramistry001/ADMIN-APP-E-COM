import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextType textType;
  final TextWeight textWeight;
  final Color color;

  const CustomText({
    super.key,
    required this.text,
    this.textType = TextType.bodyLarge,
    this.textWeight = TextWeight.regular,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle(textType, textWeight, color);
    return Text(
      text,
      style: textStyle,
    );
  }

  TextStyle _getTextStyle(
      TextType textType, TextWeight textWeight, Color color) {
    double fontSize;
    switch (textType) {
      case TextType.heading:
        fontSize = 29.sp;
        break;
      case TextType.title:
        fontSize = 20.sp;
        break;
      case TextType.bodyLarge:
        fontSize = 16.sp;
        break;
      case TextType.bodySmall:
        fontSize = 14.sp;
        break;
      case TextType.caption:
        fontSize = 12.sp;
        break;
    }

    FontWeight fontWeight;
    switch (textWeight) {
      case TextWeight.bold:
        fontWeight = FontWeight.bold; // Bold
        break;
      case TextWeight.semiBold:
        fontWeight = FontWeight.w400; // Semi-Bold
        break;
      case TextWeight.light:
        fontWeight = FontWeight.w200; // Light
        break;
      case TextWeight.regular:
        fontWeight = FontWeight.w400; // Regular
        break;
    }

    return TextStyle(
      fontFamily: "Lato",
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

enum TextType {
  heading,
  title,
  bodyLarge,
  bodySmall,
  caption,
}

enum TextWeight {
  bold,
  semiBold,
  light,
  regular,
}
