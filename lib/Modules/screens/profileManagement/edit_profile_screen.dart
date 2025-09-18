import 'dart:io';

import 'package:bhk_artisan/common/MyAlertDialog.dart';
import 'package:bhk_artisan/common/common_back.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/get_image_photo_gallery.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/updateprofilecontroller.dart';

class EditProfile extends ParentWidget {
  const EditProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    UpdateProfileController controller = Get.put(UpdateProfileController());
    return Obx(
      () => onBack(
        Stack(
          children: [
            Scaffold(
              backgroundColor: appColors.backgroundColor,
              appBar: commonAppBar("Update Profile", automaticallyImplyLeading: false),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                      content(context, w, h, controller),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.fromLTRB(16, 6, 16, h * 0.04),
                child: controller.isNewUser.value
                    ? commonButton(
                        w,
                        45,
                        appColors.contentButtonBrown,
                        appColors.contentWhite,
                        () {
                          if (controller.validateStringForm() == null) {
                            controller.updateProfileApi();
                          } else {
                            CommonMethods.showToast(controller.validateStringForm() ?? "Please fill all the mandatory fields");
                          }
                        },
                        hint: "Save",
                        radius: 30,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonButton(w * 0.3, 45, appColors.contentButtonBrown, appColors.contentWhite, () => MyAlertDialog.showAlertDialog(), hint: "Cancel", radius: 30),
                          commonButton(
                            w * 0.3,
                            45,
                            appColors.contentButtonBrown,
                            appColors.contentWhite,
                            () {
                              if (controller.validateStringForm() == null) {
                                controller.updateProfileApi();
                              } else {
                                CommonMethods.showToast(controller.validateStringForm() ?? "Please fill all the mandatory fields");
                              }
                            },
                            hint: "Save",
                            radius: 30,
                          ),
                        ],
                      ),
              ),
            ),
            progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
          ],
        ),
        canPop: false,
        (didPop, result) async {
          if (!didPop) {
            MyAlertDialog.showAlertDialog();
          }
        },
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
                  : (controller.commonController.profileData.value.data?.avatar?.isNotEmpty ?? false)
                  ? commonProfileNetworkImage(controller.commonController.profileData.value.data?.avatar ?? "")
                  : Image.asset(appImages.profile, width: 150, height: 150, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CircleAvatar(
                backgroundColor: appColors.contentButtonBrown,
                radius: 20.0,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: appColors.contentWhite,
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
      10.kH,
      commonButtonIcon(
        100,
        40,
        backgroundColor: appColors.brownbuttonBg,
        appColors.contentWhite,
        () {
          if (controller.havingIntro.value) {
            Get.toNamed(RoutesClass.videoPlayer, arguments: {'path': controller.introUploaded.value});
          } else if (controller.introUploaded.value?.isEmpty ?? true) {
            bottomDrawer(
              context,
              h * 0.22,
              w,
              controller.selectedIntroVideo,
              () {
                Get.back();
                pickVideoFromGallery(controller.selectedIntroVideo, true, onVideoPicked: () => controller.getPreSignedIntroUrlApi());
              },
              () {
                Get.back();
                pickVideoFromGallery(controller.selectedIntroVideo, false, onVideoPicked: () => controller.getPreSignedIntroUrlApi());
              },
              isVideo: true,
            );
          }
        },
        icon: Icons.video_call,
        hint: controller.havingIntro.value
            ? "View Intro"
            : controller.introUploaded.value?.isNotEmpty ?? false
            ? "Uploaded ✓"
            : 'Upload Intro',
        forward: false,
        radius: 25,
      ),
    ],
  );
}

Widget content(BuildContext context, double w, double h, UpdateProfileController controller) {
  return Column(
    children: [
      commonComponent("First Name", commonTextField(controller.firstNameController.value, controller.firstNameFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your First name', maxLines: 1,inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
      16.kH,
      commonComponent("Last Name", commonTextField(controller.lastNameController.value, controller.lastNameFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Last name', maxLines: 1,inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
      16.kH,
      commonComponent("Email", commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Email', maxLines: 1,inputFormatters: [NoLeadingSpaceFormatter(),LengthLimitingTextInputFormatter(50)]), mandatory: false),
      16.kH,
      if (controller.isNewUser.value) ...[
        commonComponent("GST Number", commonTextField(controller.gstController.value, controller.gstFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter GST Number (if Organisation)', maxLines: 1,inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]), mandatory: false),
        16.kH,
        Row(
          children: [
            Expanded(
              flex: 3,
              child: commonComponent(
                "Category",
                commonDropdownButton(
                  controller.casteCategories.map((item) {
                    return DropdownMenuItem<String>(
                      value: item.categoryValue.toString(),
                      child: Text(item.displayName, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  controller.selectedCategory.value?.categoryValue,
                  w * 0.5,
                  h,
                  appColors.backgroundColor,
                  (String? newValue) {
                    if (newValue != null) {
                      controller.selectedCategory.value = UserCasteCategory.values.firstWhere((e) => e.categoryValue == newValue);
                    }
                  },
                  hint: 'Select Category',
                  borderColor: appColors.border,
                ),
              ),
            ),
            10.kW,
            Expanded(flex: 3, child: commonComponent("Caste", commonTextField(controller.communityController.value, controller.communityFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Caste', maxLines: 1,inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]))),
          ],
        ),
        16.kH,
      ],
      commonComponent(
        "Expertise",
        commonMultiDropdownButton(
          controller.getCategoryModel.value.data?.docs?.map((item) {
            return DropdownMenuItem<String>(
              value: item.categoryName,
              child:StatefulBuilder( builder: (context, setState) { final isSelected = controller.selectedMultiExpertise.contains(item.categoryName); return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (isSelected) {
                    controller.selectedMultiExpertise.remove(item.categoryName);
                  } else {
                    controller.selectedMultiExpertise.add(item.categoryName ?? "");
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      checkColor: appColors.contentWhite,
                      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.selected)) {
                          return appColors.brownDarkText;
                        }
                        return appColors.contentWhite;
                      }),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (value) {
                        if (value == true) {
                          controller.selectedMultiExpertise.add(item.categoryName ?? "");
                        } else {
                          controller.selectedMultiExpertise.remove(item.categoryName);
                        }
                        setState(() {});
                      },
                    ),
                    Text(item.categoryName ?? "", style: const TextStyle(fontSize: 14)),
                  ],
                ),
              );}
            ));
          }).toList(),
          controller.selectedMultiExpertise,
          w,
          h,
          appColors.backgroundColor,
          hint: 'Select Expertise',
          borderColor: appColors.border,
        ),
      ),
      6.kH,
    ],
  );
}

Widget introVideoContent(BuildContext context, double w, double h, UpdateProfileController controller) {
  return Column(
    children: [
      ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.all(0),
        title: Text('Introductory Video', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
        trailing: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (controller.havingIntro.value) {
              Get.toNamed(RoutesClass.videoPlayer, arguments: {'path': controller.introUploaded.value});
            } else if (controller.introUploaded.value?.isEmpty ?? true) {
              bottomDrawer(
                context,
                h * 0.22,
                w,
                controller.selectedIntroVideo,
                () {
                  Get.back();
                  pickVideoFromGallery(controller.selectedIntroVideo, true, onVideoPicked: () => controller.getPreSignedIntroUrlApi());
                },
                () {
                  Get.back();
                  pickVideoFromGallery(controller.selectedIntroVideo, false, onVideoPicked: () => controller.getPreSignedIntroUrlApi());
                },
                isVideo: true,
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.video_call, size: 25, color: appColors.brownDarkText),
                5.kW,
                Text(
                  controller.havingIntro.value
                      ? "View"
                      : controller.introUploaded.value?.isNotEmpty ?? false
                      ? "Uploaded ✓"
                      : 'Upload',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: appColors.brownDarkText),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
