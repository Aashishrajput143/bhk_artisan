import 'package:bhk_artisan/Modules/screens/profileManagement/main_profile.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingProfile extends ParentWidget {
  const SettingProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("Settings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            children: [
              buildProfileOptionCard("Edit Profile", 'Edit, or Change your Profile', Icons.edit, () => Get.toNamed(RoutesClass.editprofile)),
              buildProfileOptionCard(
                "Introductory Video",
                'Upload your Intro Video',
                Icons.video_call,
                () =>Get.toNamed(RoutesClass.videoRecorder)
              ),
              buildProfileOptionCard("Delete Account", "Remove your account permanently", Icons.delete, () {}),
              buildProfileOptionCard("Verify Aadhaar", "Securely link your Aadhaar for verification", Icons.verified, () => Get.toNamed(RoutesClass.aadharVerification)),
            ],
          ),
        ),
      ),
    );
  }
}
