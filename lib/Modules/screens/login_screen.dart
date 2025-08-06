import 'dart:math';

import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../controller/logincontroller.dart';

class LoginScreen extends ParentWidget {
  const LoginScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    LoginController controller = Get.put(LoginController());
    return Obx(() => Stack(
          children: [
            Container(
                width: w,
                height: h,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(appImages.bhkbackground), fit: BoxFit.cover)),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    topRoundedAnimatedHeader(w, h, controller),
                    SizedBox(height: h*0.13),
                    if (controller.errorMessage.value != "") errorToggle(controller),
                    30.kH,
                    Text(
                      appStrings.letsSignIn,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    8.kH,
                    Text(
                      appStrings.welcomeBack,
                      style: const TextStyle(fontSize: 15, color: Colors.white, decoration: TextDecoration.none),
                    ),
                    30.kH,
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {
                    //     if (value.isNotEmpty) {
                    //       controller.errorMessage.value = "";
                    //       controller.phoneController.value.text = "";
                    //       controller.countryCode.value = "";
                    //     }
                    //   }, onChange: (value) {
                    //     if (value.isNotEmpty) {
                    //       controller.errorMessage.value = "";
                    //       controller.phoneController.value.text = "";
                    //       controller.countryCode.value = "";
                    //     }
                    //   }, inputFormatters: [
                    //     EmailInputFormatter(),
                    //     NoLeadingSpaceFormatter(),
                    //     EmojiInputFormatter(),
                    //     LengthLimitingTextInputFormatter(50),
                    //   ], hint: appStrings.email, isWhite: true),
                    // ),
                    // const SizedBox(height: 15),
                    // Text(
                    //   appStrings.or,
                    //   style: const TextStyle(fontSize: 12, color: Colors.white),
                    // ),
                    // const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: phoneTextField(controller.phoneController.value, controller.phoneNumberFocusNode.value, w, 40, onCountryChanged: (country) {
                        print('Country changed to: ${country.dialCode}');
                        controller.phoneController.value.text = "";
                      }, onCountryCodeChange: (phone) {
                        controller.errorMessage.value = "";
                        controller.countryCode.value = phone.countryCode;
                        if (phone.number.isNotEmpty) {
                          controller.emailController.value.text = "";
                        }
                      }, hint: appStrings.phone, inputFormatters: [NoLeadingZeroFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]),
                    ),
                    20.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: commonButton(w, 45, appColors.brownbuttonBg, Colors.white, () {
                        if (controller.emailController.value.text.isEmpty && controller.phoneController.value.text.isEmpty) {
                          controller.errorMessage.value = appStrings.loginerrormessage;
                        } else {
                          controller.errorMessage.value = "";
                          FocusScope.of(context).unfocus();
                          controller.logInAndRegister(context);
                        }
                      }, radius: 30, hint: appStrings.getOTP),
                    ),
                    SizedBox(height: controller.errorMessage.value == "" ? h * 0.23 : h * 0.18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: bottomText(),
                    ),
                  ],
                ))),
            progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w)
          ],
        ));
  }
}

Widget topRoundedAnimatedHeader(double w, double h, LoginController controller) {
  return Container(
    height: h * 0.2,
    width: w,
    padding: EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomRight: Radius.circular(150), bottomLeft: Radius.circular(150))),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.animationController.value * 2 * pi,
                child: child,
              );
            },
            child: Image.asset(
              appImages.loaderouter,
              height: h * 0.13,
              fit: BoxFit.contain,
            ),
          ),
          Image.asset(
            appImages.logo,
            width: 45,
            height: 45,
          ),
        ],
      ),
    ),
  );
}

Widget errorToggle(LoginController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red[100],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error, color: Colors.red),
        8.kW,
        Expanded(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}

Widget google(LoginController controller) {
  return InkWell(
    //onTap: () async => await controller.signInWithGoogle(),
    // onTap: () => Get.toNamed(RoutesClass.gotoVerifyScreen(), arguments: {'referenceId': 23, "identity": "52353462", "countryCode": "+91"}),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(appImages.googleIcon, width: 30, height: 30),
          10.kW,
          Text("Continue with Google", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}
