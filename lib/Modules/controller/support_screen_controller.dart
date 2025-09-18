import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var messageController = TextEditingController().obs;

  var emailFocusNode = FocusNode().obs;
  var nameFocusNode = FocusNode().obs;
  var phoneFocusNode = FocusNode().obs;
  var messageFocusNode = FocusNode().obs;


}