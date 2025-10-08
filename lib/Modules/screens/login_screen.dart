import 'dart:math';

import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/my_utils.dart';
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
    return Obx(
      () => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(appImages.bhkbackground), fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    topRoundedAnimatedHeader(w, h, controller),
                    SizedBox(height: h * 0.13),
                    30.kH,
                    Text(
                      appStrings.letsSignIn,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: appColors.contentWhite, decoration: TextDecoration.none),
                    ),
                    8.kH,
                    Text(
                      appStrings.welcomeBack,
                      style: TextStyle(fontSize: 15, color: appColors.contentWhite, decoration: TextDecoration.none),
                    ),
                    30.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: phoneTextField(
                        controller.phoneController.value,
                        controller.phoneNumberFocusNode.value,
                        w,
                        onCountryChanged: (country) {
                          debugPrint('Country changed to: ${country.dialCode}');
                          controller.phoneController.value.text = "";
                          controller.maxlength.value = country.maxLength;
                        },
                        error: controller.errorMessage,
                        onCountryCodeChange: (phone) {
                          controller.errorMessage.value = null;
                          controller.countryCode.value = phone.countryCode;
                        },
                        isWhite: true,
                        radius: 25,
                        borderWidth: 2,
                        hint: appStrings.phone,
                        inputFormatters: [NoLeadingZeroFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(15)],
                      ),
                    ),
                    20.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: commonButton(
                        w,
                        45,
                        appColors.brownbuttonBg,
                        appColors.contentWhite,
                        () =>controller.validateAndLogin(),
                        radius: 30,
                        hint: appStrings.getOTP,
                      ),
                    ),
                    SizedBox(height: h * 0.23),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: bottomText()),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget topRoundedAnimatedHeader(double w, double h, LoginController controller) {
    return Container(
      height: h * 0.2,
      width: w,
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: appColors.contentWhite,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(150), bottomLeft: Radius.circular(150)),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                return Transform.rotate(angle: controller.animationController.value * 2 * pi, child: child);
              },
              child: Image.asset(appImages.loaderouter, height: h * 0.13, fit: BoxFit.contain),
            ),
            Image.asset(appImages.logo, width: 45, height: 45),
          ],
        ),
      ),
    );
  }

  Widget google(LoginController controller) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      //onTap: () async => await controller.signInWithGoogle(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: appColors.contentWhite, borderRadius: BorderRadius.circular(25)),
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
}
