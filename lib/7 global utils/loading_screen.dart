import 'package:admin_app/5%20screens/auth/login_screen.dart';
import 'package:admin_app/5%20screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  InitialLoadingScreenState createState() => InitialLoadingScreenState();
}

class InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final registerViewModel =
        Provider.of<RegisterViewModel>(context, listen: false);
    final isValid = await registerViewModel.verifyTokenAndNavigate(context);

    if (mounted) {
      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
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
      backgroundColor: Colors.white, // Or your app's theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/images/app_logo.png', // Replace with your logo path
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 50),

            // Loading Animation
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blue, // Use your app's primary color
              size: 50,
            ),

            // Optional: You can try other animations like:
            // LoadingAnimationWidget.inkDrop(
            //   color: Colors.blue,
            //   size: 50,
            // ),

            // LoadingAnimationWidget.twistingDots(
            //   leftDotColor: Colors.blue,
            //   rightDotColor: Colors.red,
            //   size: 50,
            // ),

            // LoadingAnimationWidget.fourRotatingDots(
            //   color: Colors.blue,
            //   size: 50,
            // ),

            const SizedBox(height: 20),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// If you want a reusable loading widget:
class CustomLoadingWidget extends StatelessWidget {
  final Color color;
  final double size;
  final String? message;

  const CustomLoadingWidget({
    Key? key,
    this.color = Colors.blue,
    this.size = 50,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoadingAnimationWidget.staggeredDotsWave(
          color: color,
          size: size,
        ),
        if (message != null) ...[
          const SizedBox(height: 20),
          Text(
            message!,
            style: TextStyle(
              fontSize: size * 0.36,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ],
    );
  }
}
