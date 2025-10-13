import 'dart:io';
import 'package:path/path.dart' as path;

class Validator {
  static bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{1,}$').hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^[6-9]').hasMatch(phoneNumber);
  }

  static bool isGSTNumberValid(String gstNumber) {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$').hasMatch(gstNumber);
  }

  static bool isAadharNumberValid(String aadharNumber) {
    return RegExp(r'^[2-9]{1}[0-9]{11}$').hasMatch(aadharNumber);
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
