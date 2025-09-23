import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
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
              getProfileImage(h, w, controller),
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
              if (controller.profileData.value.data?.userCasteCategory != null) commonCards(appStrings.category, "${parseUserCasteCategory(controller.profileData.value.data?.userCasteCategory)?.displayName}  ( ${controller.profileData.value.data?.subCaste} )", Icons.people_outline),
              commonCards(appStrings.expertise, controller.profileData.value.data?.expertizeField ?? appStrings.pleaseSetExpertise, Icons.work_outline),
            ],
          ),
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

  Widget getProfileImage(double h, double w, CommonScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: controller.profileData.value.data?.avatar?.isNotEmpty ?? false ? commonProfileNetworkImage(controller.profileData.value.data?.avatar ?? "", width: 150, height: 150) : Image.asset(appImages.profile, width: 150, height: 150, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
