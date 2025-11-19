import 'package:bhk_artisan/Modules/controller/verification_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderVerificationScreen extends ParentWidget {
  const UnderVerificationScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    VerificationController controller = Get.put(VerificationController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar(appStrings.underVerification),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                emptyScreen(h, appStrings.waitingApproval, appStrings.underVerificationDesc, appImages.accountLens, isThere: false, imageSize: 200, fontSizeTitle: 20, fontSizeDesc: 14),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: commonButton(w * 0.6, 50, appColors.contentButtonBrown, appColors.contentWhite, () => Get.toNamed(RoutesClass.support, arguments: false), hint: appStrings.needHelp, radius: 30),
                    ),
                    10.kH,
                    GestureDetector(
                      onTap: () => controller.getProfileApi(),
                      child: Text(
                        appStrings.refresh,
                        style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.robotsRegular, fontSize: 16, decoration: TextDecoration.underline, decorationThickness: 2),
                      ),
                    ),
                  ],
                ),
                6.kH,
                controller.rxRequestStatus.value == Status.LOADING
                    ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: appColors.brownDarkText))
                    : GestureDetector(
                        onTap: () => controller.logOutApi(),
                        child: Text(
                          appStrings.backtoLogin,
                          style: TextStyle(fontWeight: FontWeight.bold, color: appColors.brownDarkText, fontSize: 16, decoration: TextDecoration.underline, decorationThickness: 1.5),
                        ),
                      ),
              ],
            ),
          ),
          progressBarTransparent(controller.rxRequestRefreshStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }
}
