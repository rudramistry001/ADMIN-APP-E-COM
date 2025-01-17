import 'package:admin_app/1%20model/auth_model.dart';
import 'package:admin_app/4%20view%20model/register_view_model.dart';
import 'package:admin_app/5%20screens/auth/login_screen.dart';
import 'package:admin_app/5%20screens/dashboard/home_screen.dart';
import 'package:admin_app/6%20global%20widgets/text_wideget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _verifyTokenAndNavigate();
  }

  Future<void> _verifyTokenAndNavigate() async {
    try {
      // Delay to keep the loading screen visible for at least 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // Get the stored access token
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('accessToken');

      // If no token is found, navigate to the LoginScreen
      if (storedToken == null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
        return;
      }

      // Get the view model instance
      final registerViewModel =
          Provider.of<RegisterViewModel>(context, listen: false);

      // Verify token by calling the API
      final isTokenValid = await registerViewModel.verifytoken(
          context, RegisterModel(accessToken: storedToken));

      // Delay to allow the loading animation to complete
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // If token is valid, navigate to HomeScreen
      if (isTokenValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // If token is invalid, clear stored token and navigate to LoginScreen
        await prefs.remove('accessToken');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during token verification: $e");
      }

      // On any error, navigate to the LoginScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // // Bigger App Logo
              // Image.asset(
              //   'assets/images/logo.png',
              //   width: 250.sp,
              //   height: 250.sp,
              // ),
              SizedBox(height: 70.h),

              LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blueAccent,
                size: 100.sp,
              ),

              const SizedBox(height: 40),

              CustomText(
                text: 'Verifying your Shipping...',
                textType: TextType.title,
                textWeight: TextWeight.semiBold,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
