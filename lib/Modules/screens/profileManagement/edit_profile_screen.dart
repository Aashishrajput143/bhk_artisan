import 'dart:io';

import 'package:bhk_artisan/Modules/screens/productManagement/add_product_screen.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/get_image_photo_gallery.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/updateprofilecontroller.dart';

class EditProfile extends ParentWidget {
  const EditProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    UpdateProfileController controller = Get.put(UpdateProfileController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar("Update Profile",automaticallyImplyLeading:controller.isNewUser.value?false:true),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.kH,
                    profile(context, h, w, controller),
                    20.kH,
                    Row(
                      children: [
                        Icon(Icons.edit_document, size: 20.0, color: Colors.blue),
                        10.kW,
                        Text('Personal Information', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    20.kH,
                    content(w, h, controller),
                    35.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonButton(w * 0.3, 45, appColors.contentButtonBrown, Colors.white, () => Get.back(), hint: "Cancel", radius: 30),
                          commonButton(w * 0.3, 45, appColors.contentButtonBrown, Colors.white, (){
                            if(controller.validateForm()){
                              controller.updateProfileApi();
                            }else{
                              CommonMethods.showToast("please fill all the mandatory fields");
                            }
                          }, hint: "Save", radius: 30),
                        ],
                      ),
                    ),
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
}

Widget profile(BuildContext context, double h, double w, UpdateProfileController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100), // Half of container size
              child: controller.selectedImage.value != null
                  ? Image.file(File(controller.selectedImage.value ?? ""), width: 150, height: 150, fit: BoxFit.cover)
                  : (controller.commonController.profileData.value.data?.avatar?.isNotEmpty??false)
                  ? commonProfileNetworkImage(controller.commonController.profileData.value.data?.avatar ?? "")
                  : Image.asset(appImages.profile, width: 150, height: 150, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CircleAvatar(
                backgroundColor: appColors.brownbuttonBg,
                radius: 20.0,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () => bottomDrawer(
                    context,
                    h * 0.3,
                    w,
                    controller.selectedImage,
                    () {
                      Get.back();
                      pickImageFromGallery(controller.selectedImage, true);
                    },
                    () {
                      Get.back();
                      pickImageFromGallery(controller.selectedImage, false);
                    },
                    isDeleteButton: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      16.kH,
      Text("Maximum file size : 5 MB*", style: TextStyle(color: appColors.contentdescBrownColor)),
      Text("Accepted file types : jpg, png, jpeg", style: TextStyle(color: appColors.contentdescBrownColor)),
    ],
  );
}

Widget content(double w, double h, UpdateProfileController controller) {
  return Column(
    children: [
      commonComponent("First Name", commonTextField(controller.firstNameController.value, controller.firstNameFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your First name', maxLines: 1)),
      16.kH,
      commonComponent("Last Name", commonTextField(controller.lastNameController.value, controller.lastNameFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Last name', maxLines: 1)),
      16.kH,
      commonComponent("Email", commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Email', maxLines: 1),mandatory: false),
      16.kH,
      commonComponent(
        "Expertise",
        commonDropdownButton(
          controller.expertise.map((item) {
            return DropdownMenuItem<String>(
              value: item.name.toString(),
              child: Text(item.name, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          controller.selectedExpertise.value,
          w,
          h,
          appColors.backgroundColor,
          (String? newValue) {
            controller.selectedExpertise.value = newValue;
          },
          hint: 'Select Expertise',
          borderColor: appColors.border,
        ),
      ),
    ],
  );
}
