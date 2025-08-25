import 'dart:io';

import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class Validator {
  static bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{1,}$').hasMatch(password);
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return null;
    } else if (!isEmailValid(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? password, String? confirmPassword, bool? validate) {
    if (password == null || password.isEmpty) {
      return null;
    }
    if (password.length < 8 && (confirmPassword?.length ?? 0) < 8) {
      return 'Password must be 8 character long';
    } else if (!isPasswordValid(password)) {
      return 'Password must contain at least 1 uppercase, 1 lowercase, and 1 number';
    } else if (password.isNotEmpty && confirmPassword != "" && confirmPassword != null && validate == true) {
      if (password.isEmpty && confirmPassword.isEmpty) {
        return null;
      }
      if (password != confirmPassword) {
        return "Password and Confirm password do not match";
      }
    }
    return null;
  }

  static String? validateAge(String dateString, requiredAge) {
    print("$dateString ${DateTime.now().toString()}");
    if (dateString == DateTime.now().toString() || dateString.isEmpty) {
      return 'Date of Birth is required';
    }
    try {
      DateTime birthDate = DateTime.parse(dateString);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;

      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      // Validate age
      if (age < requiredAge) {
        return "Age Restriction -  Must be $requiredAge or older to sign up.";
      } else {
        return null;
      }
    } catch (e) {
      return "Invalid date format.";
    }
  }

  static String? validateInput(String input) {
    if (input.trim().isEmpty) {
      return "Input cannot be only whitespace!";
    }
    return null;
  }

  static bool validateImagesPath(File file) {
    final extension = path.extension(file.path).toLowerCase();
    if (extension == ".jpg" || extension == ".jpeg" || extension == ".png") {
      return true;
    }
    return false;
  }

  static bool validateImagesSize(File file, int validatemb) {
    final int fileSize = file.lengthSync(); // in bytes
      double mb = fileSize / (1024 * 1024);
      return mb < validatemb;
  }
}
