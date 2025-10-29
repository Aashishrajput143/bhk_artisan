import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';

class UnderVerificationScreen extends ParentWidget {
  const UnderVerificationScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar(appStrings.underVerification),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.13,horizontal: 16),
        child: emptyScreen(h, appStrings.waitingApproval, appStrings.underVerificationDesc, appImages.accountLens,isThere: false),
      ),
    );
  }
}
