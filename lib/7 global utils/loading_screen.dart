import 'package:admin_app/5%20screens/auth/login_screen.dart';
import 'package:admin_app/5%20screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  final Future<void> loginProcess;
  const LoadingScreen({super.key, required this.loginProcess});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _startLoginProcess();
  }

  // This function starts the login process and waits for it to complete
  void _startLoginProcess() async {
    try {
      // Wait for the login process to complete
      await widget.loginProcess;

      // Delay to allow the loading animation to complete
      await Future.delayed(const Duration(seconds: 3));

      // If the login process was successful, navigate to the HomeScreen
      if (!mounted) {
        return; // Check if the widget is still mounted before navigating
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3));

      // If there's an error (e.g., failed login), navigate back to the LoginScreen
      if (!mounted) {
        return; // Check if the widget is still mounted before navigating
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the screen
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.grey.shade800, // The color of the inkdrop animation
          size: 100.sp, // Use ScreenUtil to make the size responsive
        ),
      ),
    );
  }
}
