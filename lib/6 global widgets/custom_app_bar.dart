
import 'package:admin_app/6%20global%20widgets/text_wideget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appbartext;

  const CustomAppBar({
    super.key,
    required this.appbartext,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        text: appbartext,
        color: Colors.white,
        textType: TextType.title,
        textWeight: TextWeight.regular,
      ),
      backgroundColor: Colors.blue, // Set the background color to blue
      iconTheme: const IconThemeData(
          color: Colors.white), // Set the back arrow color to white
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
