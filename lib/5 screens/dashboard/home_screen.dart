import 'package:admin_app/4%20view%20model/register_view_model.dart';
import 'package:admin_app/6%20global%20widgets/custom_app_bar.dart';
import 'package:admin_app/6%20global%20widgets/text_wideget.dart';
import 'package:flutter/material.dart';


RegisterViewModel registerViewModel = RegisterViewModel();

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbartext: "HOME SCREEN"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CustomText(
              text: "Welcome to the HomeScreen",
              color: Colors.black,
              textType: TextType.title,
              textWeight: TextWeight.bold,
            ),
            ElevatedButton(
              onPressed: () {
              registerViewModel.logoutUser(context);
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
