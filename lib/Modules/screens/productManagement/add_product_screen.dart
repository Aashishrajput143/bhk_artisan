import 'dart:io';

import 'package:bhk_artisan/Modules/controller/addproduct_controller.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/get_image_photo_gallery.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'build_step_circle.dart';

class AddProductPage extends ParentWidget {
  const AddProductPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddProductController controller = Get.put(AddProductController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar(appStrings.addProduct),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      5.kW,
                      Icon(Icons.shopping_cart, size: 20.0, color: Colors.blue),
                      10.kW,
                      Text(appStrings.addProduct, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  5.kH,
                  Text(
                    appStrings.addProductDesc,
                    style: TextStyle(fontSize: 11.0, color: appColors.contentdescBrownColor, fontWeight: FontWeight.bold),
                  ),
                  25.kH,
                  buildCircle(controller.selectedIndex.value, controller.selectedIndex.value, controller),
                  16.kH,
                  if (controller.selectedIndex.value == 0) generalDetails(w, h, controller),
                  if (controller.selectedIndex.value == 1) productDetails(w, h, controller),
                  if (controller.selectedIndex.value == 2) mediaFiles(context, w, h, controller),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.selectedIndex.value > 0 ? commonOutlinedButtonIcon(w * 0.2, 48, Colors.black, () => controller.selectedIndex.value--, hint: appStrings.previousStep, radius: 25, forward: false, icon: Icons.arrow_back) : SizedBox(),
                  controller.selectedIndex.value < 2 ? commonButtonIcon(w * 0.2, 48, appColors.contentWhite, () => controller.selectedIndex.value++, hint: appStrings.nextStep, radius: 25, backgroundColor: appColors.contentButtonBrown) : SizedBox(),
                  if (controller.selectedIndex.value == 2)
                    commonButtonIcon(
                      w * 0.2,
                      48,
                      appColors.contentWhite,
                      () => controller.validateStringForm() == null ? controller.addProductApi() : CommonMethods.showToast(controller.validateStringForm() ?? appStrings.pleaseFillMandatoryFields, icon: Icons.warning_amber_rounded),
                      hint: appStrings.submit,
                      radius: 25,
                      backgroundColor: appColors.contentButtonBrown,
                    ),
                ],
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }
}

Widget generalDetails(double w, double h, AddProductController controller) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonComponent(
            appStrings.category,
            commonDropdownButton(
              controller.getCategoryModel.value.data?.docs?.map((item) {
                return DropdownMenuItem<String>(
                  value: item.categoryId.toString(),
                  child: Text(item.categoryName ?? "", style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              controller.selectedcategoryid.value,
              w,
              h,
              appColors.backgroundColor,
              (String? newValue) {
                controller.selectedcategoryid.value = newValue;
                print(controller.selectedcategoryid.value);
                controller.selectedsubcategoryid.value = null;
                controller.getSubCategoryApi();
              },
              hint: appStrings.selectCategory,
              borderColor: appColors.border,
            ),
          ),
          16.kH,
          commonComponent(
            appStrings.subCategory,
            commonDropdownButton(
              controller.getSubcategoryModel.value.data?.docs?.map((item) {
                return DropdownMenuItem<String>(
                  value: item.categoryId.toString(),
                  child: Text(item.categoryName ?? "", style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              controller.selectedsubcategoryid.value,
              w,
              h,
              appColors.backgroundColor,
              (String? newValue) {
                controller.selectedsubcategoryid.value = newValue;
              },
              hint: appStrings.selectSubCategory,
              borderColor: appColors.border,
            ),
          ),
          16.kH,
          commonComponent(appStrings.productName, commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.enterProductName, maxLines: 3, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
          16.kH,
          commonComponent(appStrings.timeToMake, commonTextField(controller.timeController.value, controller.timeFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.enterTimeToMake, inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 6)),
          16.kH,
          commonComponent(appStrings.description, commonDescriptionTextField(controller.detaileddescriptionController.value, controller.detaileddescriptionFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.enterDescription, maxLines: 8, minLines: 3, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter()])),
        ],
      ),
    ),
  );
}

Widget productDetails(double w, double h, AddProductController controller) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonComponent(appStrings.productPrice, commonTextField(controller.priceController.value, controller.priceFocusNode.value, w, onChange: (value) => controller.calculateTotalPrice(), (value) {}, maxLength: 6, hint: appStrings.enterProductPrice, prefix: '₹ ', inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
          16.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: commonComponent(appStrings.quantity, commonTextField(controller.quantityController.value, controller.quantityFocusNode.value, w, (value) {}, onChange: (value) => controller.calculateTotalPrice(), maxLength: 6, hint: appStrings.enterQuantity, inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
              ),
              8.kW,
              Expanded(
                child: commonComponent(appStrings.totalPrice, commonTextField(controller.totalPriceController.value, controller.totalPriceFocusNode.value, w, (value) {}, readonly: true, prefix: '₹ ', inputFormatters: [FilteringTextInputFormatter.digitsOnly]), mandatory: false),
              ),
            ],
          ),
          16.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: commonComponent(
                  appStrings.finishTexture,
                  commonDropdownButton(
                    controller.textureList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    controller.selectedTexture.value,
                    w * 0.5,
                    h,
                    appColors.backgroundColor,
                    (String? newValue) {
                      controller.selectedTexture.value = newValue;
                    },
                    hint: appStrings.selectTexture,
                    borderColor: appColors.border,
                  ),
                  mandatory: false,
                ),
              ),
              8.kW,
              Expanded(
                child: commonComponent(
                  appStrings.washCare,
                  commonDropdownButton(
                    controller.washCareList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    controller.selectedWashCare.value,
                    w * 0.5,
                    h,
                    appColors.backgroundColor,
                    (String? newValue) {
                      controller.selectedWashCare.value = newValue;
                    },
                    hint: appStrings.selectWashCare,
                    borderColor: appColors.border,
                  ),
                  mandatory: false,
                ),
              ),
            ],
          ),
          16.kH,
          commonComponent(appStrings.material, commonTextField(controller.materialController.value, controller.materialFocusNode.value, w, (value) {}, hint: appStrings.enterMaterial, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)])),
          16.kH,
          commonComponent(
            mandatory: false,
            "${appStrings.netWeight} (${controller.dropdownValues})",
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: commonTextField(controller.netweightController.value, controller.netweightFocusNode.value, w, (value) {}, hint: "${appStrings.enterNetWeight}(in ${controller.dropdownValues})", inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 5),
                ),
                8.kW,
                Expanded(
                  flex: 2,
                  child: commonDropdownButton(
                    controller.weights.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    controller.dropdownValues.value,
                    w * 0.25,
                    h,
                    appColors.backgroundColor,
                    (value) => controller.dropdownValues.value = value ?? "",
                    borderColor: appColors.border,
                  ),
                ),
              ],
            ),
          ),
          16.kH,
          commonComponent(
            mandatory: false,
            "${appStrings.dimension}(in L*B*H) in ${controller.dropdownValue}",
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: commonTextField(controller.lengthController.value, controller.lengthFocusNode.value, w, (value) {}, hint: appStrings.length, inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 5),
                ),
                8.kW,
                Expanded(
                  flex: 2,
                  child: commonTextField(controller.breadthController.value, controller.breadthFocusNode.value, w, (value) {}, hint: appStrings.breadth, inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 5),
                ),
                8.kW,
                Expanded(
                  flex: 2,
                  child: commonTextField(controller.heightController.value, controller.heightFocusNode.value, w, (value) {}, hint: appStrings.height, inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 5),
                ),
                8.kW,
                Expanded(
                  flex: 3,
                  child: commonDropdownButton(
                    controller.measureunits.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    controller.dropdownValue.value,
                    w * 0.25,
                    h,
                    appColors.backgroundColor,
                    (value) => controller.dropdownValue.value = value ?? "",
                    borderColor: appColors.border,
                  ),
                ),
              ],
            ),
          ),
          16.kH,
          commonComponent(appStrings.artUsed, commonTextField(controller.techniqueController.value, controller.techniqueFocusNode.value, w, (value) {}, hint: appStrings.enterArtUsed, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]), mandatory: false),
          16.kH,
          commonComponent(appStrings.patternUsed, commonTextField(controller.patternController.value, controller.patternFocusNode.value, w, (value) {}, hint: appStrings.enterPatternUsed, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)], maxLines: 3), mandatory: false),
        ],
      ),
    ),
  );
}

Widget mediaFiles(BuildContext context, double w, double h, AddProductController controller) {
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
      Text(appStrings.uploadImagesDesc, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      20.kH,
      Text(appStrings.pickedFiles),
      Divider(),
      if (controller.imagefiles.isNotEmpty) Padding(padding: const EdgeInsets.all(8.0), child: pickedfiles(w, h, controller)),
    ],
  );
}

Widget pickedfiles(double w, double h, AddProductController controller) {
  return SizedBox(
    height: h - h * 0.71,
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: controller.imagefiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => controller.imagefiles.removeAt(index),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.brown.shade300, shape: BoxShape.circle),
                  child: Icon(Icons.close, size: 17, color: appColors.contentWhite),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.dialog(
                Dialog(
                  insetPadding: const EdgeInsets.all(16),
                  backgroundColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.brown.shade300, shape: BoxShape.circle),
                            child: Icon(Icons.close, size: 20, color: appColors.contentWhite),
                          ),
                        ),
                      ),
                      InteractiveViewer(
                        child: Center(
                          child: Image.file(File(controller.imagefiles[index]), height: h * 0.6, width: w * 0.9, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Image.file(File(controller.imagefiles[index]), width: w * .2, height: h * .09, fit: BoxFit.fitWidth),
            ),
          ],
        );
      },
    ),
  );
}
