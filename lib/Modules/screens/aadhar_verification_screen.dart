import 'package:bhk_artisan/Modules/controller/aadhar_verification_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AadharVerificationScreen extends ParentWidget {
  const AadharVerificationScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AadharVerificationController controller = Get.put(AadharVerificationController());
    return Obx(() =>  Stack(
      children: [
        Scaffold(
          backgroundColor: appColors.backgroundColor,
          appBar: commonAppBar("Aadhar Verification"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(appImages.aadharbanner),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Center(
                        child: const Text(
                          'Aadhaar Verification',
                          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Verify your identity securely with your Aadhaar number. Enter your 12-digit Aadhaar number to receive a One-Time Password (OTP) on your registered mobile number.",
                          style: TextStyle(fontSize: 13.0, color: appColors.contentdescBrownColor, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      30.kH,
                      if(controller.otpComponent.value==false) aadhaarNumber(w, h, controller),
                      if(controller.otpComponent.value)aadhaarOTP(context,w, h, controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
      ],
    ));
  }
}

Widget commonComponent(String title, Widget component, {bool mandatory = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          if (mandatory) ...[
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      8.kH,
      component,
    ],
  );
}

Widget aadhaarNumber(double w, double h, AadharVerificationController controller) {
  return Column(
    children: [
      commonComponent("Aadhaar Number", commonTextField(controller.aadharController.value, controller.aadharFocusNode.value, w, (value) {}, fontSize: 14,maxLength: 16,inputFormatters: [FilteringTextInputFormatter.digitsOnly], hint: 'Enter your 16 Digits Aadhaar Number', maxLines: 1)),
      30.kH,
      commonButton(w, 50, appColors.contentButtonBrown, Colors.white, () =>controller.otpComponent.value=true, hint: "Send OTP"),
    ],
  );
}

Widget aadhaarOTP(BuildContext context, double w, double h, AadharVerificationController controller) {
  return Column(
    children: [
      commonComponent("Aadhaar OTP", otpField(context, controller.otpController.value, 6, (pin) => controller.otp.value = pin.toString(),inputFormatters: [FilteringTextInputFormatter.digitsOnly],backgroundColor: appColors.backgroundColor,fieldHeight: 65,fieldWidth: 55,autoFocus: false)),
      20.kH,
      commonButton(w, 50, appColors.contentButtonBrown, Colors.white, () =>Get.back(), hint: "Verify OTP"),
    ],
  );
}
