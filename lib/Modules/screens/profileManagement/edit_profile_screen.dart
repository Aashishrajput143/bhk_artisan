import 'dart:io';

import 'package:bhk_artisan/common/my_alert_dialog.dart';
import 'package:bhk_artisan/common/common_back.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/get_image_photo_gallery.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/strings.dart';
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
              appBar: commonAppBar(appStrings.updateProfile, automaticallyImplyLeading: false),
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
                          Text(appStrings.personalInformation, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
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
                            CommonMethods.showToast(controller.validateStringForm() ?? appStrings.mandatoryFields);
                          }
                        },
                        hint: appStrings.save,
                        radius: 12,
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
                                CommonMethods.showToast(controller.validateStringForm() ?? appStrings.mandatoryFields);
                              }
                            },
                            hint: appStrings.save,
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
              borderRadius: BorderRadius.circular(100),
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
      Text(appStrings.fiveMBValidation, style: TextStyle(color: appColors.contentdescBrownColor)),
      Text(appStrings.jpgPngAccpted, style: TextStyle(color: appColors.contentdescBrownColor)),
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
            ? appStrings.viewIntro
            : controller.introUploaded.value?.isNotEmpty ?? false
            ? appStrings.uploadedtick
            : appStrings.uploadIntro,
        forward: false,
        radius: 25,
      ),
    ],
  );
}

Widget content(BuildContext context, double w, double h, UpdateProfileController controller) {
  return Column(
    children: [
      commonComponent(appStrings.firstName, commonTextField(controller.firstNameController.value, controller.firstNameFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.firstNameHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
      16.kH,
      commonComponent(appStrings.lastName, commonTextField(controller.lastNameController.value, controller.lastNameFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.lastNameHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
      16.kH,
      commonComponent(appStrings.email, commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.emailHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(50)]), mandatory: false),
      16.kH,
      if (controller.isNewUser.value) ...[
        commonComponent(appStrings.gstNumber, commonTextField(controller.gstController.value, controller.gstFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.gstNumberHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]), mandatory: false),
        16.kH,
        Row(
          children: [
            Expanded(
              flex: 3,
              child: commonComponent(
                appStrings.category,
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
                  hint: appStrings.selectCategory,
                  borderColor: appColors.border,
                ),
              ),
            ),
            10.kW,
            Expanded(
              flex: 3,
              child: commonComponent(appStrings.caste, commonTextField(controller.communityController.value, controller.communityFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.enterCaste, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
            ),
          ],
        ),
        16.kH,
      ],
      commonComponent(
        appStrings.expertise,
        commonMultiDropdownButton(
          controller.getCategoryModel.value.data?.docs?.map((item) {
            return DropdownMenuItem<String>(
              value: item.categoryName,
              child: StatefulBuilder(
                builder: (context, setState) {
                  final isSelected = controller.selectedMultiExpertise.contains(item.categoryName);
                  return GestureDetector(
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
                  );
                },
              ),
            );
          }).toList(),
          controller.selectedMultiExpertise,
          w,
          h,
          appColors.backgroundColor,
          hint: appStrings.selectExpertise,
          borderColor: appColors.border,
        ),
      ),
      6.kH,
    ],
  );
}
