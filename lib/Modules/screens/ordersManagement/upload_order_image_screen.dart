import 'dart:io';

import 'package:bhk_artisan/Modules/controller/upload_order_image_controller.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/get_media_phone_gallery.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/enums/address_type_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadOrderImageScreen extends ParentWidget {
  const UploadOrderImageScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    UploadOrderImageController controller = Get.put(UploadOrderImageController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar(appStrings.uploadCompletion),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      5.kW,
                      Icon(Icons.inventory_2, size: 20.0, color: Colors.blue),
                      10.kW,
                      Text(appStrings.finishedProduct, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  5.kH,
                  Text(
                    appStrings.addPicturesCompletedOrder,
                    style: TextStyle(fontSize: 11.0, color: appColors.contentdescBrownColor, fontWeight: FontWeight.bold),
                  ),
                  25.kH,
                  Expanded(child: mediaFiles(context, w, h, controller)),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.04),
              child: commonButton(
                w * 0.2,
                50,
                appColors.contentButtonBrown,
                appColors.contentWhite,
                () {
                  if (!controller.isButtonEnabled.value) return;
                  controller.isButtonEnabled.value = false;
                  controller.validateStringForm() == null ? bottomDrawerSelectAddress(context, h, w, controller.addressController, controller) : CommonMethods.showToast(controller.validateStringForm() ?? appStrings.pleaseUploadImages, icon: Icons.warning_amber_rounded);
                  enableButtonAfterDelay(controller.isButtonEnabled);
                },
                hint: appStrings.markAsCompleted,
                radius: 12,
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget mediaFiles(BuildContext context, double w, double h, UploadOrderImageController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonComponent(
          appStrings.uploadImages,
          Container(
            width: w,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image, size: 50, color: Colors.grey),
                8.kH,
                Text(appStrings.uploadImagesHere),
                5.kH,
                ElevatedButton(
                  onPressed: () => bottomDrawerMultiFile(
                    context,
                    h * 0.25,
                    w,
                    controller.imagefiles,
                    () {
                      Get.back();
                      pickMultipleImagesFromGallery(controller.imagefiles, true, isValidate: true);
                    },
                    () {
                      Get.back();
                      pickMultipleImagesFromGallery(controller.imagefiles, false);
                    },
                  ),
                  child: Text(appStrings.clickToBrowse, style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
        8.kH,
        Text(appStrings.uploadImagesOrderDesc, style: TextStyle(color: Colors.grey[600])),
        20.kH,
        Text(appStrings.pickedFiles),
        Divider(),
        if (controller.imagefiles.isNotEmpty) pickedfiles(w, h, controller),
      ],
    );
  }

  Widget pickedfiles(double w, double h, UploadOrderImageController controller) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: controller.imagefiles.asMap().entries.map((entry) {
              int index = entry.key;
              String imgPath = entry.value;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => Get.dialog(
                      Dialog(
                        insetPadding: EdgeInsets.all(16),
                        backgroundColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: appColors.contentButtonBrown, shape: BoxShape.circle),
                                  child: Icon(Icons.close, size: 20, color: appColors.contentWhite),
                                ),
                              ),
                            ),
                            InteractiveViewer(
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(File(imgPath), height: h * 0.6, width: w * 0.9, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(imgPath), height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: GestureDetector(
                      onTap: () => controller.imagefiles.removeAt(index),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future bottomDrawerSelectAddress(BuildContext context, double h, double w, AddressController addresscontroller, UploadOrderImageController controller) {
    final addresses = addresscontroller.getAddressModel.value.data ?? [];
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return addresses.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            appStrings.selectAddress,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.toNamed(RoutesClass.addresses)?.then((onValue) {
                            Get.back();
                            addresscontroller.getAddressApi();
                            if (context.mounted) {
                              bottomDrawerSelectAddress(context, h, w, addresscontroller, controller);
                            }
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              appStrings.manage,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: appFonts.NunitoBold, color: appColors.brownDarkText),
                            ),
                          ),
                        ),
                      ],
                    ),
                    2.kH,
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(appImages.emptyMap, color: appColors.brownbuttonBg),
                          Text(appStrings.yourAddressEmpty, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          4.kH,
                          Text(
                            appStrings.emptyAddressDescription,
                            style: TextStyle(fontSize: 14, color: appColors.contentSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    20.kH,
                    commonButton(
                      w,
                      50,
                      appColors.brownDarkText,
                      appColors.contentWhite,
                      () => Get.toNamed(RoutesClass.addresses)?.then((onValue) {
                        Get.back();
                        addresscontroller.getAddressApi();
                        if (context.mounted) {
                          bottomDrawerSelectAddress(context, h, w, addresscontroller, controller);
                        }
                      }),
                      hint: appStrings.addAddress,
                    ),
                    16.kH,
                  ],
                ),
              )
            : Obx(
                () => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              appStrings.selectAddress,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => Get.toNamed(RoutesClass.addresses)?.then((onValue) {
                              Get.back();
                              addresscontroller.getAddressApi();
                              if (context.mounted) {
                                bottomDrawerSelectAddress(context, h, w, addresscontroller, controller);
                              }
                            }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                appStrings.manage,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: appFonts.NunitoBold, color: appColors.brownDarkText),
                              ),
                            ),
                          ),
                        ],
                      ),
                      2.kH,
                      addressContent(h, w, addresscontroller, controller),
                      commonButton(w, 50, appColors.brownDarkText, appColors.contentWhite, () {
                        if (controller.addressId.value != "0") {
                          Get.back(closeOverlays: true);
                          controller.uploadOrderImageApi();
                        } else {
                          CommonMethods.showToast(appStrings.selectAddress, icon: Icons.error, bgColor: appColors.declineColor);
                        }
                      }, hint: appStrings.confirmAddress),
                      16.kH,
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget addressContent(double h, double w, AddressController addresscontroller, UploadOrderImageController controller) {
    final addresses = addresscontroller.getAddressModel.value.data ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  radioTheme: RadioThemeData(
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return appColors.brownDarkText;
                      }
                      return appColors.contentPrimary;
                    }),
                  ),
                ),
                child: RadioMenuButton<int>(
                  groupValue: addresses[index].id,
                  style: ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.transparent), backgroundColor: WidgetStateProperty.all(Colors.transparent), shadowColor: WidgetStateProperty.all(Colors.transparent), surfaceTintColor: WidgetStateProperty.all(Colors.transparent)),
                  value: int.parse(controller.addressId.value),
                  onChanged: (value) {
                    controller.addressId.value = (addresses[index].id ?? 0).toString();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon((address.addressType ?? "").toAddressType().icon, size: 25, color: appColors.brownDarkText),
                            10.kW,
                            Text(
                              (address.addressType ?? "").toAddressType().displayName,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.contentPending),
                            ),
                            if (address.isDefault ?? false) ...[10.kW, commonContainer(appStrings.defaultTag, appColors.brownDarkText, isBrown: true, pH: 14, borderWidth: 1.5)],
                          ],
                        ),
                        4.kH,
                        SizedBox(
                          width: w * 0.75,
                          child: Text(
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            controller.getFullAddress(index),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (index != addresses.length - 1) Divider(height: 1, thickness: 1),
            ],
          ),
        );
      },
    );
  }
}
