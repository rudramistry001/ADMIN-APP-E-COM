import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStyledTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Function(bool)? onValidationChanged;
  final String? errorText;

  const CustomStyledTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconSize,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.validator,
    this.onValidationChanged,
    this.errorText,
  });

  @override
  _CustomStyledTextFieldState createState() => _CustomStyledTextFieldState();
}

class _CustomStyledTextFieldState extends State<CustomStyledTextField> {
  late FocusNode _focusNode;
  bool _showError = false; // To control when to show the error message

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      // Show error only when the field loses focus
      if (!_focusNode.hasFocus) {
        setState(() {
          _showError = widget.validator?.call(widget.controller?.text) != null;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.sp,
          width: 360.sp,
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText ?? false,
            onChanged: (value) {
              // Notify the parent about validation status on every change
              if (widget.onValidationChanged != null) {
                widget.onValidationChanged!(
                    widget.validator?.call(value) == null);
              }
              // Optionally, you can hide the error message as the user types
              setState(() {
                _showError = false;
              });
            },
            decoration: InputDecoration(
              fillColor: Colors.grey,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(
                        color: widget.prefixIconColor ?? Colors.grey,
                        size: widget.prefixIconSize ?? 24.sp,
                      ),
                      child: widget.prefixIcon!,
                    )
                  : null,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                fontFamily: "RobotoCondensed",
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w200,
                fontSize: 18.sp,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: "RobotoCondensed",
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w200,
                fontSize: 18.sp,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? IconTheme(
                      data: IconThemeData(
                        color: widget.suffixIconColor ?? Colors.grey,
                        size: widget.suffixIconSize ?? 24.sp,
                      ),
                      child: widget.suffixIcon!,
                    )
                  : null,
            ),
          ),
        ),
        // Display error message if any
        if (_showError &&
            widget.errorText != null &&
            widget.errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.sp),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontFamily: "RobotoCondensed",
              ),
            ),
          ),
      ],
    );
  }
}
