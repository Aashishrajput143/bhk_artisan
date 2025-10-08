import 'dart:math';

import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends ParentWidget {
  const OtpScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    OtpController controller = Get.put(OtpController());
    return Obx(
      () => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              alignment: Alignment.center,
              width: w,
              height: h,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(appImages.bhkbackground), fit: BoxFit.cover),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        animatedLogo(controller, h),
                        25.kH,
                        Text(
                          appStrings.phoneVerification,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: appColors.contentWhite),
                        ),
                        10.kH,
                        Text(
                          appStrings.otpDesc,
                          style: TextStyle(fontSize: 16, color: appColors.contentWhite),
                          textAlign: TextAlign.center,
                        ),
                        30.kH,
                        otpField(context, controller.otpController.value, 6, onChanged: (pin) => controller.otp.value = pin.toString(), (pin) => controller.otp.value = pin.toString(), inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                        6.kH,
                        controller.startTime.value > 0
                            ? Text(
                                '${appStrings.reSendCode}${controller.startTime.value} sec',
                                style: TextStyle(fontSize: 14, color: appColors.contentWhite),
                                textAlign: TextAlign.center,
                              )
                            : resendOtp(context, controller),
                        30.kH,
                        commonButton(
                          w,
                          45,
                          appColors.brownbuttonBg,
                          appColors.contentWhite,
                          () {
                            if (!controller.isButtonEnabled.value) return;
                            controller.isButtonEnabled.value = false;
                            if (controller.otp.value.length == 6) {
                              controller.otpVerificationApi();
                            } else {
                              CommonMethods.showToast(appStrings.pleaseEnterOTP);
                            }
                            enableButtonAfterDelay(controller.isButtonEnabled);
                          },
                          hint: appStrings.verifyPhoneNumber,
                          radius: 30,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: () => Get.offNamed(RoutesClass.login),
                            child: Text(appStrings.editNumber, style: TextStyle(color: appColors.contentWhite)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget animatedLogo(OtpController controller, double h) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: appColors.contentWhite.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Transform.rotate(angle: controller.animationController.value * 2 * pi, child: child);
            },
            child: Image.asset(appImages.loaderouter, height: h * 0.15, fit: BoxFit.contain),
          ),
          Image.asset(appImages.logo, width: 50, height: 50),
        ],
      ),
    );
  }

  Widget resendOtp(BuildContext context, OtpController controller) {
    return GestureDetector(
      onTap: () => controller.resendOtp(context),
      child: Text(
        appStrings.reSend,
        style: TextStyle(fontSize: 14, color: appColors.contentWhite),
        textAlign: TextAlign.center,
      ),
    );
  }
}
