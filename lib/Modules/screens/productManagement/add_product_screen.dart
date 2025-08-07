import 'package:bhk_artisan/Modules/controller/addproduct_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            body: SingleChildScrollView(
              child: Padding(
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
                    buildCircle(controller.selectedIndex.value, controller.selectedIndex.value),
                    16.kH,
                    if (controller.selectedIndex.value == 0) generalDetails(w, h, controller),
                    if (controller.selectedIndex.value == 1) productDetails(w, h, controller),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(16.0,16,16,40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.selectedIndex.value > 0 ? commonOutlinedButtonIcon(w * 0.2, 45, Colors.black, () => controller.selectedIndex.value--, hint: "Previous step", radius: 25, forward: false, icon: Icons.arrow_back) : SizedBox(),
                  controller.selectedIndex.value < 2 ? commonButtonIcon(w * 0.2, 45, Colors.white, () => controller.selectedIndex.value++, hint: "Next step", radius: 25, backgroundColor: appColors.contentButtonBrown) : SizedBox(),
                  if (controller.selectedIndex.value == 2) commonButtonIcon(w * 0.2, 45, Colors.white, () {}, hint: "Submit", radius: 25, backgroundColor: appColors.contentButtonBrown),
                ],
              ),
            ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
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
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      commonComponent(
        "Category",
        commonDropdownButton(
          controller.productCategories.map((item) {
            return DropdownMenuItem<String>(
              value: item.categoryId.toString(),
              child: Text(item.categoryName, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          controller.selectedcategory,
          w,
          h,
          appColors.backgroundColor,
          (String? newValue) {
            controller.selectedcategory.value = newValue;
          },
          hint: 'Select Category',
        ),
      ),
      16.kH,
      commonComponent(
        "SubCategory",
        commonDropdownButton(
          controller.productCategories.map((item) {
            return DropdownMenuItem<String>(
              value: item.categoryId.toString(),
              child: Text(item.categoryName, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          controller.selectedcategory,
          w,
          h,
          appColors.backgroundColor,
          (String? newValue) {
            controller.selectedcategory.value = newValue;
          },
          hint: 'Select SubCategory',
        ),
      ),
      16.kH,
      commonComponent("Product Name", commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, hint: 'Enter your  Product name')),
      16.kH,
      commonComponent("Maximum Retail Price (MRP)", commonTextField(controller.mrpController.value, controller.mrpFocusNode.value, w, (value) {}, hint: 'Enter Maximum Retail Price', prefix: '₹ ')),
      16.kH,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: commonComponent("Discount(%)", commonTextField(controller.discountController.value, controller.discountFocusNode.value, w, (value) {},onChange: (value)=>controller.calculateSellingPrice(), hint: 'Enter discount', suffix: '%'),mandatory: false),
          ),
          8.kW,
          Expanded(
            child: commonComponent("Selling Price", commonTextField(controller.sellingController.value, controller.sellingFocusNode.value, w, (value) {}, readonly: true)),
          ),
        ],
      ),
      16.kH,
      commonComponent("Description", commonDescriptionTextField(controller.detaileddescriptionController.value, controller.detaileddescriptionFocusNode.value, w, (value) {}, hint: 'Enter a detailed description here...', maxLines: 5, minLines: 3)),
    ],
  );
}

Widget productDetails(double w, double h, AddProductController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      commonComponent(
        "Category",
        commonDropdownButton(
          controller.productCategories.map((item) {
            return DropdownMenuItem<String>(
              value: item.categoryId.toString(),
              child: Text(item.categoryName, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          controller.selectedcategory,
          w,
          h,
          appColors.backgroundColor,
          (String? newValue) {
            controller.selectedcategory.value = newValue;
          },
          hint: 'Select Category',
        ),
      ),
      16.kH,
      commonComponent(
        "SubCategory",
        commonDropdownButton(
          controller.productCategories.map((item) {
            return DropdownMenuItem<String>(
              value: item.categoryId.toString(),
              child: Text(item.categoryName, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          controller.selectedcategory,
          w,
          h,
          appColors.backgroundColor,
          (String? newValue) {
            controller.selectedcategory.value = newValue;
          },
          hint: 'Select SubCategory',
        ),
      ),
      16.kH,
      commonComponent("Product Name", commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, hint: 'Enter your  Product name')),
      16.kH,
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Description", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(
            " *",
            style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 5.0),
      TextFormField(
        cursorColor: Colors.grey,
        cursorWidth: 1.5,
        validator: (value) {
          if (value == '') {
            return '*Required Field! Please enter description';
          }
          return null;
        },
        controller: controller.detaileddescriptionController.value,
        maxLines: 3,
        inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), LengthLimitingTextInputFormatter(1000)],
        decoration: const InputDecoration(
          hintText: 'Enter a detailed description here...',
          hintStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
        ),
      ),
    ],
  );
}
