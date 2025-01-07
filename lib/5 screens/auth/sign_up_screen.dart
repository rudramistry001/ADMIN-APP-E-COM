import 'package:admin_app/1%20model/auth_model.dart';
import 'package:admin_app/4%20view%20model/register_view_model.dart';
import 'package:admin_app/5%20screens/auth/login_screen.dart';
import 'package:admin_app/5%20screens/auth/widgets/custom_textfield.dart';
import 'package:admin_app/5%20screens/auth/widgets/custom_textfield_label.dart';
import 'package:admin_app/6%20global%20widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isFullNameValid = false;
  bool isEmailValid = false;
  bool isContactNumberValid = false;
  bool isPasswordValid = false;
  late RegisterModel register;

  RegisterViewModel registerViewModel = RegisterViewModel();

  // Controllers for text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    register = RegisterModel(); // Initialize the register object here
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactnoController.dispose();
    fullnameController.dispose();
  }

  bool isFormValid() {
    return isFullNameValid &&
        isEmailValid &&
        isContactNumberValid &&
        isPasswordValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.all(24.0.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.sp),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 25.sp,
                        width: 25.sp,
                      ),
                      SizedBox(width: 10.sp),
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
                ),
                SizedBox(height: 20.sp),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "to continue",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Enter your personal details to sign up.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: "RobotoCondensed",
                    ),
                  ),
                ),
                SizedBox(height: 20.sp),
                const CustomTextFieldLabel(
                  labelText: "Full Name*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                CustomStyledTextField(
                  controller: fullnameController,
                  keyboardType: TextInputType.name,
                  hintText: "Ex: John Doe",
                  prefixIcon: const Icon(Icons.person),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Full Name is a required field'; // Validation: must not be empty
                    }
                    return null;
                  },
                  onValidationChanged: (isValid) {
                    setState(() {
                      isFullNameValid = isValid;
                    });
                  },
                  errorText: isFullNameValid
                      ? null
                      : 'Full Name is a required field', // Show error when invalid
                ),

                SizedBox(height: 20.sp),
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
                  errorText:
                      isEmailValid ? null : "Enter a valid email address",
                ),
                SizedBox(height: 20.sp),
                const CustomTextFieldLabel(
                  labelText: "Contact Number*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                // Mobile Number field with validation
                CustomStyledTextField(
                  hintText: "Enter your contact number",
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  controller: contactnoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Contact number is required";
                    } else if (value.length < 10 ||
                        !RegExp(r'^\d+$').hasMatch(value)) {
                      return "Mobile number must be at least 10 digits";
                    } else if (value.length > 10 ||
                        !RegExp(r'^\d+$').hasMatch(value)) {
                      return "Mobile number must be of only 10 digits";
                    }
                    return null;
                  },
                  onValidationChanged: (isValid) {
                    setState(() {
                      isContactNumberValid = isValid;
                    });
                  },
                  errorText: isContactNumberValid
                      ? null
                      : "Mobile number must be at least 10 digits",
                ),

                SizedBox(height: 20.sp),
                const CustomTextFieldLabel(
                  labelText: "Password*",
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                CustomStyledTextField(
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true, // Hides the input text
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
                  onValidationChanged: (isValid) {
                    setState(() {
                      isPasswordValid = isValid;
                    });
                  },
                  errorText: isPasswordValid
                      ? null
                      : "Password must be at least 8 characters",
                ),
                Text(
                  "Choose a stong password of 8 or more characters for security.",
                  style: TextStyle(
                    fontFamily: "RobotoCondensed",
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                30.verticalSpace,
                CustomElevatedButtonWithIcon(
                  borderColor: Colors.black,
                  borderWidth: 1.0,
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  backgroundColor: isFormValid() ? Colors.black : Colors.grey,
                  height: 50.0.sp,
                  width: 350.0.sp,
                  icon: Icons.how_to_reg,
                  text: "Register",
                  onPressed: isFormValid()
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            register.fullname = fullnameController.text.trim();
                            register.email = emailController.text.trim();
                            register.contactNumber =
                                contactnoController.text.trim();
                            register.password = passwordController.text.trim();
                            register.role = "user";
                            registerViewModel
                                .registerUser(context, register)
                                .then((value) {
                              // Handle API response here
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please fill all fields correctly.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      : null, // Explicitly null when the form is invalid
                ),

                30.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "RobotoCondensed",
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
