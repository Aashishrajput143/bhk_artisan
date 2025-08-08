import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AadharVerificationController extends GetxController {
  var otpComponent = false.obs;

  var aadharController = TextEditingController().obs;
  var aadharFocusNode = FocusNode().obs;

    var otpController = TextEditingController().obs;
  var otpFocusNode = FocusNode().obs;

  var otp = "".obs;
}
