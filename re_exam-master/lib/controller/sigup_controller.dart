import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/signup_helper.dart';

class AuthController extends GetxController {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool validateSignUpForm() {
    if (txtEmail.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Email cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (!txtEmail.text.contains('@gmail.com')) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid Gmail address (e.g., user@gmail.com).',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (txtPassword.text.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Password cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> signUpMethod(String email, String password) async {
    if (validateSignUpForm()) {
      try {
        bool emails = await AuthServices.authServices.checkEmail(email);
        if (emails) {
          Get.snackbar(
            'Sign Up Failed',
            'Email already in use. Please use a different email.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          await AuthServices.authServices.createAccount(email, password);
          Get.snackbar(
            'Sign Up',
            'Sign Up Successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Sign Up Failed',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> signInMethod(String email, String password) async {
    User? user = await AuthServices.authServices.signInUser(email, password);
    Get.snackbar(
      'Login Failed',
      'Incorrect email or password.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );

    Get.snackbar(
      'Login Failed',
      toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

Future<void> emailSignOut() async {
  await AuthServices.authServices.signOutUser();
}
