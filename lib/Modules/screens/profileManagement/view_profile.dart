import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/common/common_function.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProfile extends ParentWidget {
  const ViewProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CommonScreenController controller = Get.put(CommonScreenController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar(appStrings.viewProfile),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getProfileImage(h, w, controller.profileData.value.data?.avatar),
              20.kH,
              if (controller.profileData.value.data?.introVideo?.isNotEmpty ?? false)
                commonButtonIcon(
                  100,
                  40,
                  backgroundColor: appColors.brownbuttonBg,
                  appColors.contentWhite,
                  () => Get.toNamed(RoutesClass.videoPlayer, arguments: {'path': controller.profileData.value.data?.introVideo ?? ""}),
                  icon: Icons.video_call,
                  hint: appStrings.viewIntro,
                  forward: false,
                  radius: 16,
                ),
              20.kH,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.edit_document, size: 20.0, color: Colors.blue),
                  8.kW,
                  Text(appStrings.personalInformation, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                ],
              ),
              16.kH,
              commonCards(appStrings.firstName, controller.profileData.value.data?.firstName ?? "", Icons.person_outline),
              commonCards(appStrings.lastName, controller.profileData.value.data?.lastName ?? "", Icons.person_outline),
              commonCards(appStrings.phone, "${controller.profileData.value.data?.countryCode ?? ""} ${controller.profileData.value.data?.phoneNo ?? ""}", Icons.phone_outlined),
              if (controller.profileData.value.data?.email != null) commonCards(appStrings.email, controller.profileData.value.data?.email ?? "", Icons.email_outlined),
              commonCards(appStrings.aadhaarNumber, formatAadhaarNumber(controller.profileData.value.data?.aadhaarNumber ?? ""), Icons.badge_outlined),
              Row(
                children: [
                  Expanded(flex: 1, child: commonCards(appStrings.category, "${parseUserCasteCategory(controller.profileData.value.data?.userCasteCategory)?.displayName}", Icons.groups_outlined)),
                  Expanded(flex: 1, child: commonCards(appStrings.caste, controller.profileData.value.data?.subCaste ?? "", Icons.people_outline)),
                ],
              ),
              if (controller.profileData.value.data?.gstNumber != null) commonCards(appStrings.gstNumber, controller.profileData.value.data?.gstNumber ?? "", Icons.business),
              commonChipsCards(appStrings.expertise, controller.profileData.value.data?.expertizeField?.split(',') ?? [], Icons.work_outline),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonChipsCards(String title, List expertiseList, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black),
          ],
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(title, style: TextStyle(color: Colors.grey)),
        ),
        subtitle: Wrap(
          spacing: 6.0,
          runSpacing: 10.0,
          children: expertiseList.map((e) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.brown.shade200),
              ),
              child: Text(
                e,
                style: TextStyle(fontSize: 14, color: Colors.brown.shade700, fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget commonCards(String title, String subtitle, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: TextStyle(color: Colors.grey)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}
