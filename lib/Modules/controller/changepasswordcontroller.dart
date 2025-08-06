import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  var oldPassword = "".obs;
  var newPassword = "".obs;
  var confirmPassword = "".obs;
  var obscurePassword1 = true.obs;
  var obscurePassword2 = true.obs;
  var obscurePassword3 = true.obs; // Track password visibility

  var oldPasswordController = TextEditingController().obs;
  var oldPasswordFocusNode = FocusNode().obs;
  var newPasswordController = TextEditingController().obs;
  var newPasswordFocusNode = FocusNode().obs;
  var confirmPasswordController = TextEditingController().obs;
  var confirmPasswordFocusNode = FocusNode().obs;

}
