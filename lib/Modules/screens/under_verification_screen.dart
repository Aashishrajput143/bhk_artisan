import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
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
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar(appStrings.underVerification),
      body: Column(
        children: [
          SizedBox(height: h * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: h * 0.07),
            child: emptyScreen(h, appStrings.waitingApproval, appStrings.underVerificationDesc, appImages.accountLens, isThere: false),
          ),
          16.kH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: commonButton(w*0.6, 50, appColors.contentButtonBrown, appColors.contentWhite, () => Get.toNamed(RoutesClass.support,arguments: false), hint: appStrings.needHelp, radius: 30),
          ),
        ],
      ),
    );
  }
}
