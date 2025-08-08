import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profilecontroller.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: appBarDefault(),
            backgroundColor: const Color.fromARGB(195, 247, 243, 233),
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.profileRefresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.kH,
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(195, 250, 248, 238),
                      backgroundImage: controller.getProfileModel.value.data?.avatar?.isNotEmpty ?? false
                          ? NetworkImage(
                              // Otherwise show the network image
                              controller.getProfileModel.value.data?.avatar ?? "",
                            )
                          : AssetImage(appImages.profile),
                      radius: 70.0,
                    ),
                    20.kH,
                    Text(
                      controller.getProfileModel.value.data?.name?.isNotEmpty ?? true ? controller.getProfileModel.value.data?.name ?? "User".toUpperCase() : "User".toUpperCase(),
                      style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    5.kH,
                    Text(
                      controller.getProfileModel.value.data?.phoneNo?.isEmpty ?? true ? controller.getProfileModel.value.data?.email ?? "User@gmail.com" : controller.getProfileModel.value.data?.phoneNo ?? "XXXXXXXX10",
                      style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    10.kH,
                    commonButton(
                      100,
                      40,
                      Colors.brown,
                      Colors.white,
                      () => Get.toNamed(
                        RoutesClass.viewprofile,
                        arguments: {'name': controller.getProfileModel.value.data?.name ?? "", 'email': controller.getProfileModel.value.data?.email ?? "", 'phone': controller.getProfileModel.value.data?.phoneNo ?? "", 'avatar': controller.getProfileModel.value.data?.avatar ?? "", 'countrycode': controller.getProfileModel.value.data?.countryCode ?? ""},
                      ),
                      hint: "View Profile",
                      radius: 18,
                      paddingHorizontal: 16,
                      paddingVertical: 8,
                    ),
                    20.kH,
                    buildProfileOptionCard('My Addresses', 'Edit, add or remove Address', Icons.location_city, () =>Get.toNamed(RoutesClass.aadharVerification)),
                    buildProfileOptionCard('Privacy & Policy', 'Read how we protect your personal data', Icons.privacy_tip, () =>Get.toNamed(RoutesClass.privacypolicy)),
                    buildProfileOptionCard('Terms & Conditions', 'Review the terms of using our services', Icons.description, () =>Get.toNamed(RoutesClass.termscondition)),
                    buildProfileOptionCard('Settings', 'Edit Profile, Manage your profile', Icons.settings_outlined, () =>Get.toNamed(RoutesClass.setting)),
                    buildProfileOptionCard('Logout', 'Sign out from your account', Icons.logout, () {}),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
        ],
      ),
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
      if (title != "Logout") Divider(height: 0.1, color: Colors.black),
    ],
  );
}

PreferredSizeWidget appBarDefault() {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("Profile & More".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}
