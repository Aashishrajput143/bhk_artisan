import 'package:bhk_artisan/Modules/screens/profileManagement/main_profile.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingProfile extends ParentWidget {
  const SettingProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar(appStrings.settings),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            children: [
              buildProfileOptionCard(appStrings.editProfile, appStrings.editProfileSubtitle, Icons.edit, () => Get.toNamed(RoutesClass.editprofile)),
              buildProfileOptionCard(appStrings.deleteAccount, appStrings.deleteAccountSubtitle, Icons.delete, () {}),
              buildProfileOptionCard(appStrings.verifyAadhaar, appStrings.verifyAadhaarSubtitle, Icons.verified, () => Get.toNamed(RoutesClass.aadharVerification)),
              buildProfileOptionCard(appStrings.needAssistance, appStrings.needAssistanceSubtitle, Icons.message, () => Get.toNamed(RoutesClass.support)),
            ],
          ),
        ),
      ),
    );
  }
}
