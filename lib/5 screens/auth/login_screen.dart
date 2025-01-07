import 'package:admin_app/1%20model/auth_model.dart';
import 'package:admin_app/4%20view%20model/register_view_model.dart';
import 'package:admin_app/5%20screens/auth/sign_up_screen.dart';
import 'package:admin_app/5%20screens/auth/widgets/custom_textfield.dart';
import 'package:admin_app/5%20screens/auth/widgets/custom_textfield_label.dart';
import 'package:admin_app/6%20global%20widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  RegisterViewModel registerViewModel = RegisterViewModel();
  late final RegisterModel register;

  @override
  void initState() {
    super.initState();
    register = RegisterModel();
  }

  bool _isChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),

                  // Logo and App Name
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 30.sp,
                        width: 30.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "D Commerce",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  // Welcome Text
                  Text(
                    "Sign in to your\nAccount",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    "Enter your email and password to log in.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Email Field
                  const CustomTextFieldLabel(
                    labelText: "Email*",
                    fontColor: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomStyledTextField(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!isValidEmail(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    onValidationChanged: (isValid) {
                      setState(() {
                        isEmailValid = isValid;
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Password Field
                  const CustomTextFieldLabel(
                    labelText: "Password*",
                    fontColor: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomStyledTextField(
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Remember Me and Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement forgot password logic
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  // Login Button
                  Center(
                    child: CustomElevatedButtonWithIcon(
                      borderColor: Colors.black,
                      borderWidth: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.black,
                      height: 50.h,
                      width: 350.w,
                      icon: Icons.login,
                      iconColor: Colors.white,
                      text: "Login",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register.email = emailController.text;
                          register.password = passwordController.text;

                          // Implement login logic
                          registerViewModel.loginUser(
                              context, register, _isChecked);
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Sign Up Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
