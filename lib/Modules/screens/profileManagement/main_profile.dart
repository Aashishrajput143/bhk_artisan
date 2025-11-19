import 'package:bhk_artisan/common/my_alert_dialog.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

class MainProfile extends ParentWidget {
  const MainProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ProfileController controller = Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        appBar: commonAppBar(appStrings.profileAndMore),
        backgroundColor: appColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              getProfileImage(h, w, controller.commonController.profileData.value.data?.avatar),
              10.kH,
              Text(
                "${controller.commonController.profileData.value.data?.firstName ?? appStrings.userDefault.toUpperCase()} ${controller.commonController.profileData.value.data?.lastName ?? ""}",
                style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              3.kH,
              Text(
                "${controller.commonController.profileData.value.data?.countryCode ?? ""} ${controller.commonController.profileData.value.data?.phoneNo ?? ""}",
                style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              10.kH,
              commonButton(100, 40, Colors.brown, appColors.contentWhite, () => Get.toNamed(RoutesClass.viewprofile), hint: appStrings.viewProfile, radius: 18, paddingHorizontal: 16, paddingVertical: 8),
              20.kH,
              buildProfileOptionCard(appStrings.myAddress, appStrings.editAddRemoveAddress, Icons.location_city, () => Get.toNamed(RoutesClass.addresses)),
              buildProfileOptionCard(appStrings.privacyPolicyTitle, appStrings.privacyPolicySubtitle, Icons.privacy_tip, () => Get.toNamed(RoutesClass.privacypolicy)),
              buildProfileOptionCard(appStrings.termsConditions, appStrings.termsConditionsSubtitle, Icons.description, () => Get.toNamed(RoutesClass.termscondition)),
              buildProfileOptionCard(
                appStrings.settings,
                appStrings.settingsSubtitle,
                Icons.settings_outlined,
                () => Get.toNamed(RoutesClass.setting)?.then((onValue) {
                  if (controller.isProfileAPI.value) controller.commonController.getProfileApi();
                }),
              ),
              buildProfileOptionCard(appStrings.logout, appStrings.logoutSubtitle, Icons.logout, () => MyAlertDialog.showlogoutDialog(controller.logOutApi)),
            ],
          ),
        ),
      ),
    );
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
}
