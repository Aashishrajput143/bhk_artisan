import 'dart:io';

import 'package:bhk_artisan/Modules/controller/addproduct_controller.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/get_image_photo_gallery.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'buildstepcircle.dart';

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
            appBar: commonAppBar("Add Product"),
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
                      Text('Add Product', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  5.kH,
                  Text(
                    'Add a new product to your store.',
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
                  controller.selectedIndex.value > 0 ? commonOutlinedButtonIcon(w * 0.2, 48, Colors.black, () => controller.selectedIndex.value--, hint: "Previous step", radius: 25, forward: false, icon: Icons.arrow_back) : SizedBox(),
                  controller.selectedIndex.value < 2 ? commonButtonIcon(w * 0.2, 48, Colors.white, () => controller.selectedIndex.value++, hint: "Next step", radius: 25, backgroundColor: appColors.contentButtonBrown) : SizedBox(),
                  if (controller.selectedIndex.value == 2)
                    commonButtonIcon(
                      w * 0.2,
                      48,
                      Colors.white,
                      () {
                        if (controller.validateForm()) {
                          controller.addProductApi();
                        } else {
                          CommonMethods.showToast("Please fill all the mandatory fields!", icon: Icons.warning_amber_rounded, bgColor: appColors.contentButtonBrown);
                        }
                      },
                      hint: "Submit",
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

Widget commonComponent(String title, Widget component, {bool mandatory = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          if (mandatory) ...[
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      5.kH,
      component,
    ],
  );
}

Widget generalDetails(double w, double h, AddProductController controller) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonComponent(
            "Category",
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
              hint: 'Select Category',
              borderColor: appColors.border,
            ),
          ),
          16.kH,
          commonComponent(
            "SubCategory",
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
              hint: 'Select SubCategory',
              borderColor: appColors.border,
            ),
          ),
          16.kH,
          commonComponent("Product Name", commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Product name', maxLines: 3)),
          16.kH,
          commonComponent("Time to Make", commonTextField(controller.timeController.value, controller.timeFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter how long it took to make (e.g. 2 days)')),
          16.kH,
          commonComponent("Description", commonDescriptionTextField(controller.detaileddescriptionController.value, controller.detaileddescriptionFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter a detailed description\neg. product history, culture, uniqueness...', maxLines: 8, minLines: 3)),
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
          commonComponent("Product Price per Piece", commonTextField(controller.priceController.value, controller.priceFocusNode.value, w, onChange: (value) => controller.calculateTotalPrice(), (value) {}, hint: 'Enter Product Price per Piece', prefix: '₹ ')),
          16.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: commonComponent("Quantity", commonTextField(controller.quantityController.value, controller.quantityFocusNode.value, w, (value) {}, onChange: (value) => controller.calculateTotalPrice(), hint: 'Enter Quantity')),
              ),
              8.kW,
              Expanded(child: commonComponent("Total Price", commonTextField(controller.totalPriceController.value, controller.totalPriceFocusNode.value, w, (value) {}, readonly: true), mandatory: false)),
            ],
          ),
          16.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: commonComponent(
                  "Finish/Texture",
                  commonDropdownButton(
                    controller.textureList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    controller.selectedTexture.value,
                    w*0.5,
                    h,
                    appColors.backgroundColor,
                    (String? newValue) {
                      controller.selectedTexture.value = newValue;
                    },
                    hint: 'Select Texture',
                    borderColor: appColors.border,
                  ),
                  mandatory: false,
                ),
              ),
              8.kW,
              Expanded(
                child: commonComponent(
                  "Wash Care",
                  commonDropdownButton(
                    controller.washCareList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    controller.selectedWashCare.value,
                    w*0.5,
                    h,
                    appColors.backgroundColor,
                    (String? newValue) {
                      controller.selectedWashCare.value = newValue;
                    },
                    hint: 'Select Wash Care',
                    borderColor: appColors.border,
                  ),
                  mandatory: false,
                ),
              ),
            ],
          ),
          16.kH,
          commonComponent("Material", commonTextField(controller.materialController.value, controller.materialFocusNode.value, w, (value) {}, hint: 'Enter Material Used', maxLines: 1)),
          16.kH,
          commonComponent(
            mandatory: false,
            "Net Weight (${controller.dropdownValues})",
            Row(
              children: [
                Expanded(flex: 6, child: commonTextField(controller.netweightController.value, controller.netweightFocusNode.value, w, (value) {}, hint: 'Enter Net Weight(in ${controller.dropdownValues})')),
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
            "Dimension(in L*B*H) in ${controller.dropdownValue}",
            Row(
              children: [
                Expanded(flex: 2, child: commonTextField(controller.lengthController.value, controller.lengthFocusNode.value, w, (value) {}, hint: 'Length')),
                8.kW,
                Expanded(flex: 2, child: commonTextField(controller.breadthController.value, controller.breadthFocusNode.value, w, (value) {}, hint: 'Breadth')),
                8.kW,
                Expanded(flex: 2, child: commonTextField(controller.heightController.value, controller.heightFocusNode.value, w, (value) {}, hint: 'Height')),
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
          commonComponent("Technique Used", commonTextField(controller.techniqueController.value, controller.techniqueFocusNode.value, w, (value) {}, hint: 'Enter Crafting Technique'), mandatory: false),
          16.kH,
          commonComponent("Pattern Used", commonTextField(controller.patternController.value, controller.patternFocusNode.value, w, (value) {}, hint: 'Enter Pattern Used', maxLines: 3), mandatory: false),
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
        "Upload Images",
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
              const Text("Upload your images here"),
              5.kH,
              ElevatedButton(
                onPressed: () => bottomDrawerMultiFile(
                  context,
                  h * 0.25,
                  w,
                  controller.imagefiles,
                  () {
                    Get.back();
                    pickMultipleImagesFromGallery(controller.imagefiles, true);
                  },
                  () {
                    Get.back();
                    pickMultipleImagesFromGallery(controller.imagefiles, false);
                  },
                ),
                child: const Text('Click to browse', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
      8.kH,
      Text("Add up to 10 images to your product. Used to represent your product during checkout, in email, social sharing, and more.", style: TextStyle(color: Colors.grey[600])),
      20.kH,
      Text("Picked Files:"),
      Divider(),
      if (controller.imagefiles.isNotEmpty) Padding(padding: const EdgeInsets.all(8.0), child: pickedfiles(w, h, controller)),
    ],
  );
}

Widget pickedfiles(double w, double h, AddProductController controller) {
  return SizedBox(
    height: h * 0.3,
    child: GridView.builder(
      itemCount: controller.imagefiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 20),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => controller.imagefiles.removeAt(index),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(color: Colors.brown.shade300, shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.close, size: 17, color: Colors.white),
                  ),
                ),
              ),
            ),
            Image.file(File(controller.imagefiles[index]), width: w * .25, height: h * .09),
          ],
        );
      },
    ),
  );
}
