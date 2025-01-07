// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:admin_app/1%20model/auth_model.dart';
import 'package:admin_app/3%20repository/register_service.dart';
import 'package:admin_app/5%20screens/auth/login_screen.dart';
import 'package:admin_app/7%20global%20utils/global_utils.dart';
import 'package:admin_app/7%20global%20utils/loader.dart';
import 'package:admin_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../7 global utils/loading_screen.dart';

class RegisterViewModel with ChangeNotifier {
  RegisterRepository registerRepository = RegisterRepository();

  Future registerUser(context, RegisterModel register) async {
    Loading loading = Loading(context);
    try {
      loading.startLoading();

      final response = await registerRepository.registerUser(register);

      if (response.statusCode == 200) {
        snackBarKey.currentState?.clearSnackBars();
        print("StatusCode for Register ------------");
        print(response.statusCode);

        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('message')) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(
              message: jsonResponse['message'],
            ),
          );
        }
        snackBarKey.currentState?.showSnackBar(
            customSnackBar(message: 'User Created Successfully.Please login.'));
        loading.stopLoading();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
        loading.stopLoading();
        notifyListeners();
      } else {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey("error")) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(
              message: jsonResponse["error"],
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception at CREATING NEW USER : $e");
      }
      snackBarKey.currentState
          ?.showSnackBar(customSnackBar(message: e.toString()));
      loading.stopLoading();
    }
  }

  Future loginUser(
      BuildContext context, RegisterModel loginUser, bool rememberMe) async {
    try {
      // Create a future representing the login process
      Future<void> loginProcess = _handleLogin(loginUser, rememberMe, context);

      // Navigate to the loading screen and pass the login process to it
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LoadingScreen(loginProcess: loginProcess)),
      );
    } catch (e) {
      // In case of any immediate error, navigate to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  Future<void> _handleLogin(
      RegisterModel loginUser, bool rememberMe, BuildContext context) async {
    try {
      final response = await registerRepository.loginUser(loginUser);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['token'];
        final id = jsonResponse['user']['id'];
        final fullname = jsonResponse['user']['fullname'];

        // Save the token and credentials if "Remember Me" is checked
        if (rememberMe) {
          await saveToken(token);
          await saveUserId(id);
          await saveUserId(fullname);
        }

        // Successful login, return from the method
        return;
      } else {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey("error")) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(message: jsonResponse["error"]),
          );
        }

        // If login fails, throw an exception
        throw Exception("Login failed");
      }
    } catch (e) {
      // Handle login failure (e.g., network error)
      if (kDebugMode) {
        print("Exception at Logging in The User : $e");
      }
      snackBarKey.currentState?.showSnackBar(
        customSnackBar(message: "Exception at Logging in The User : $e"),
      );

      // If an error occurs, throw to indicate failure
      throw Exception("Login failed");
    }
  }

  Future<String> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("TOKEN  SAVED _______");
    print(token);
    return token;
  }

  Future<String> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    print("USER ID SAVED----------");
    print(id);
    return id;
  }

  Future<String?> getUserAccessToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    return token;
  }

  Future<String?> getUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? id = localStorage.getString('id');
    print("USER ID IS GET USING SP");
    print(id);

    return id;
  }

//   Future logoutUser(context) async {
//     try {
//       // // final localStorage = await SharedPreferences.getInstance();
//       // await localStorage.clear();
//       // String? token = localStorage.getString('token');
//       // print("TOKEN _______");
//       // print(token);
//       // String? id = localStorage.getString('id');
//       // print("USER ID----------");
//       // print(id);
//       // Optionally, you can also navigate the user back to the login screen
//       // or perform any other necessary cleanup actions.
//       // For example:
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false);
//     } catch (e) {
//       // Handle any errors that might occur during logout process
//       if (kDebugMode) {
//         print("Exception at logging out the user: $e");
//       }
//       // You might want to notify the user or perform any other actions here
//     }
//   }

  Future<void> logoutUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data
    print("ALL STORED CREDENTIALS DELETED");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
