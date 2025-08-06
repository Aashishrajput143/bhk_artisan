import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/appBardrawercontroller.dart';
import '../controller/common_screen_controller.dart';

Widget appDrawer(BuildContext context, double h, double w) {
  Appbardrawercontroller controller = Get.put(Appbardrawercontroller());
  CommonScreenController commonController = Get.put(CommonScreenController());
  return Obx(
    () => Stack(
      children: [
        RefreshIndicator(
          color: Colors.brown,
          onRefresh: controller.profileRefresh,
          child: Drawer(
            //width: w * 0.65,
            child: Container(
              color: const Color.fromARGB(195, 247, 243, 233),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  profileImage(h, commonController, controller),
                  title("NAVIGATION"),
                  commonListTile(Icons.home, 'Home', () {
                    Get.back();
                    //commonController.selectedScreenIndex.value = 0;
                  }),
                  Divider(),
                  title("My Business"),
                  commonListTile(Icons.store, 'My Product', () {
                    Get.back();
                    //commonController.selectedScreenIndex.value = 2;
                  }),
                  commonListTile(Icons.store, 'My Stores', () {
                    Get.back();
                    Get.toNamed(RoutesClass.gotoStoreScreen());
                  }),
                  commonListTile(Icons.branding_watermark_outlined, 'Explore Brands', () {
                    Get.back();
                    Get.toNamed(RoutesClass.gotoBrandScreen());
                  }),
                  Divider(),
                  title("My ACCOUNT"),
                  avatar(controller, () {
                    Get.back();
                    //commonController.selectedScreenIndex.value = 4;
                  }),
                  Divider(),
                  title("AUTHENTICATION"),
                  commonListTile(Icons.logout, "Log Out", () {
                    Get.back();
                    controller.showlogoutDialog();
                  }),
                  Divider(),
                  commonListTileWithOutIcon('Terms & Conditions', () {
                    Get.back();
                    Get.toNamed(RoutesClass.gotoTermsConditionScreen());
                  }),
                  commonListTileWithOutIcon('Privacy Policy', () {
                    Get.back();
                    Get.toNamed(RoutesClass.gotoPrivacyPolicyScreen());
                  }),
                  commonListTileWithOutIcon('FAQ', () {
                    Get.back();
                    Get.toNamed(RoutesClass.gotoFAQScreen());
                  }),
                  SizedBox(height: 30),
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

Widget profileImage(double h, CommonScreenController commonController, Appbardrawercontroller controller) {
  return SizedBox(
    height: h * 0.18,
    child: InkWell(
        onTap: () {
          Get.back();
          //commonController.selectedScreenIndex.value = 4;
        },
        child: UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromARGB(255, 96, 77, 46), Color.fromARGB(255, 143, 90, 78), Color.fromARGB(255, 181, 157, 148)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            accountName: Text(controller.getProfileModel.value.data?.name?.isNotEmpty ?? true ? controller.getProfileModel.value.data?.name ?? "User".toUpperCase() : "User".toUpperCase(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            accountEmail: Text(
                controller.getProfileModel.value.data?.phoneNo?.isEmpty ?? true ? controller.getProfileModel.value.data?.email ?? "User@gmail.com" : controller.getProfileModel.value.data?.phoneNo ?? "XXXXXXXX10",
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)))),
  );
}

Widget avatar(Appbardrawercontroller controller, void Function()? onTap) {
  return ListTile(
      minTileHeight: 7,
      leading: CircleAvatar(
          backgroundColor: Color.fromARGB(195, 250, 248, 238),
          backgroundImage: controller.getProfileModel.value.data?.avatar?.isNotEmpty ?? false ? NetworkImage(controller.getProfileModel.value.data?.avatar ?? "") : AssetImage(appImages.profile),
          radius: 14.0),
      title: Text('Account Info', style: TextStyle(color: Colors.black, fontSize: 15)),
      onTap: onTap);
}

Widget title(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
    child: Text(
      text,
      style: TextStyle(color: const Color.fromARGB(255, 139, 136, 136), fontSize: 12.0, fontWeight: FontWeight.bold),
    ),
  );
}

Widget commonListTile(IconData icon, String text, void Function()? onTap) {
  return ListTile(minTileHeight: 7, leading: Icon(icon, color: Colors.black), title: Text(text, style: TextStyle(color: Colors.black, fontSize: 15)), onTap: onTap);
}

Widget commonListTileWithOutIcon(String text, void Function()? onTap) {
  return ListTile(minTileHeight: 7, title: Text(text, style: TextStyle(color: const Color.fromARGB(255, 76, 72, 72), fontSize: 14)), onTap: onTap);
}
