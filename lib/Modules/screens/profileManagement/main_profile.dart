import 'package:bhk_artisan/common/MyAlertDialog.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profilecontroller.dart';

class MainProfile extends ParentWidget {
  const MainProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ProfileController controller = Get.put(ProfileController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: commonAppBar("Profile & More"),
            backgroundColor: appColors.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  30.kH,
                  getProfileImage(h, w, controller),
                  10.kH,
                  Text(
                    controller.commonController.profileData.value.data?.name ?? "User".toUpperCase(),
                    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  3.kH,
                  Text(
                    "${controller.commonController.profileData.value.data?.countryCode??""} ${controller.commonController.profileData.value.data?.phoneNo??""}",
                    style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  10.kH,
                  commonButton(100, 40, Colors.brown, Colors.white, () => Get.toNamed(RoutesClass.viewprofile), hint: "View Profile", radius: 18, paddingHorizontal: 16, paddingVertical: 8),
                  20.kH,
                  buildProfileOptionCard('My Addresses', 'Edit, add or remove Address', Icons.location_city, () => Get.toNamed(RoutesClass.addresses)),
                  buildProfileOptionCard('Privacy & Policy', 'Read how we protect your personal data', Icons.privacy_tip, () => Get.toNamed(RoutesClass.privacypolicy)),
                  buildProfileOptionCard('Terms & Conditions', 'Review the terms of using our services', Icons.description, () => Get.toNamed(RoutesClass.termscondition)),
                  buildProfileOptionCard('Settings', 'Edit Profile, Manage your profile', Icons.settings_outlined, () => Get.toNamed(RoutesClass.setting)),
                  buildProfileOptionCard('Logout', 'Sign out from your account', Icons.logout, () =>MyAlertDialog.showlogoutDialog(controller.logOutApi())),
                ],
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
        ],
      ),
    );
  }

  Widget getProfileImage(double h, double w, ProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: controller.commonController.profileData.value.data?.avatar?.isNotEmpty ?? false ? commonProfileNetworkImage(controller.commonController.profileData.value.data?.avatar ?? "") : Image.asset(appImages.profile, width: 150, height: 150, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}

Widget buildProfileOptionCard(String title, String subtitle, IconData icon, void Function()? onTap) {
  return Column(
    children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        leading: Icon(icon, color: Colors.brown[700]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: appColors.greyNew)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
      Divider(height: 0.1, color: Colors.black),
    ],
  );
}
