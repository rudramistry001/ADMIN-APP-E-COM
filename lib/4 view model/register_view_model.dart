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
        final accessToken = jsonResponse['accessToken'];
        final refreshToken = jsonResponse['refreshToken'];
        final id = jsonResponse['user']['id'];
        final fullname = jsonResponse['user']['fullname'];
        final role = jsonResponse['user']['role'];

        // Save all credentials if "Remember Me" is checked
        if (rememberMe) {
          await saveAccessToken(accessToken);
          await saveRefreshToken(refreshToken);
          await saveUserId(id);
          await saveFullName(fullname);
          await saveRole(role);
        }

        return;
      } else {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey("error")) {
          snackBarKey.currentState?.showSnackBar(
            customSnackBar(message: jsonResponse["error"]),
          );
        }
        throw Exception("Login failed");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception at Logging in The User : $e");
      }
      snackBarKey.currentState?.showSnackBar(
        customSnackBar(message: "Exception at Logging in The User : $e"),
      );
      throw Exception("Login failed");
    }
  }

  // Updated and new storage functions
  Future<String> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    print("ACCESS TOKEN SAVED: $token");
    return token;
  }

  Future<String> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', token);
    print("REFRESH TOKEN SAVED: $token");
    return token;
  }

  Future<String> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
    print("ROLE SAVED: $role");
    return role;
  }

  Future<String> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    print("ROLE SAVED: $id");
    return id;
  }

  Future<String> saveFullName(String fullname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', fullname);
    print("FULLNAME SAVED: $fullname");
    return fullname;
  }

  // Getter functions for stored values
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fullname');
  }

  // Updated logout function to clear all stored credentials
  Future<void> logoutUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will clear all stored data
    print("ALL STORED CREDENTIALS DELETED");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<bool> verifytoken(BuildContext context, RegisterModel register) async {
    Loading loading = Loading(context);
    try {
      loading.startLoading();
      print('verify token api called');

      final response = await registerRepository.verifytoken(register);
      final jsonResponse = json.decode(response.body);

      // Always clear previous snackbars
      snackBarKey.currentState?.clearSnackBars();

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(
              "Token Verification Successful - Status Code: ${response.statusCode}");
        }

        // Show success message if present
        final message =
            jsonResponse['message'] ?? 'Token verified successfully';
        snackBarKey.currentState?.showSnackBar(
          customSnackBar(message: message),
        );

        notifyListeners();
        return true;
      } else {
        // Handle error responses
        final errorMessage =
            jsonResponse['error'] ?? 'Token verification failed';
        snackBarKey.currentState?.showSnackBar(
          customSnackBar(message: errorMessage),
        );
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception during token verification: $e");
      }

      snackBarKey.currentState?.showSnackBar(
        customSnackBar(message: "Verification failed: ${e.toString()}"),
      );
      return false;
    } finally {
      loading.stopLoading(); // Always stop loading regardless of outcome
    }
  }
}
