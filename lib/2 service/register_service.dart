// ignore_for_file: avoid_print

import 'dart:async';

import 'package:admin_app/1%20model/auth_model.dart';
import 'package:admin_app/2%20service/base%20service/base_service.dart';
import 'package:admin_app/7%20constants/urls.dart';

class RegisterServices extends BaseApiProvider {
  Future<dynamic> registerUser(RegisterModel registerModel) async {
    var body = registerModel.toJson();

    try {
      final response = await postRequest(
          Uri.parse(UrlConstant.uatUrl + UrlConstant.register), body);
      // You can handle the response here according to your requirements
      return response;
    } catch (e) {
      // Handle errors such as network issues or server errors
      print('Error in registering the user: $e');
      rethrow; // Rethrow the error to be handled at the caller level if needed
    }
  }

  Future<dynamic> loginUser(RegisterModel loginUser) async {
    var body = loginUser.toJson();

    try {
      final response = await postRequest(
          Uri.parse(UrlConstant.baseUrl + UrlConstant.login), body);
      // You can handle the response here according to your requirements
      return response;
    } catch (e) {
      // Handle errors such as network issues or server errors
      print('Error in Logging in the user: $e');
      rethrow; // Rethrow the error to be handled at the caller level if needed
    }
  }

  Future<dynamic> verifytoken(RegisterModel verifytoken) async {
    var body = verifytoken.toJson();

    try {
      final response = await postRequest(
          Uri.parse(UrlConstant.baseUrl + UrlConstant.verifytoken), body);
      // You can handle the response here according to your requirements
      return response;
    } catch (e) {
      // Handle errors such as network issues or server errors
      print('Error in verifying  the user: $e');
      rethrow; // Rethrow the error to be handled at the caller level if needed
    }
  }
}
