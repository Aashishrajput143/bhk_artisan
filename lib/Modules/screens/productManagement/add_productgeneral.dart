import 'package:bhk_artisan/Modules/controller/addproductgeneralcontroller.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddProductGeneral extends ParentWidget {
  const AddProductGeneral({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddProductGeneralController controller =
        Get.put(AddProductGeneralController());
    return Obx(() => Stack(children: [
          Scaffold(
            backgroundColor: const Color.fromARGB(195, 247, 243, 233),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: AppGradients.customGradient,
                ),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(
                controller.producteditId == true
                    ? "Edit Product".toUpperCase()
                    : "Add Product".toUpperCase(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.producteditId == true
                        ? const Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.edit,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Edit Product',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : const Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.shopping_cart,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Add Product',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                    SizedBox(height: 5.0),

                    controller.producteditId == true
                        ? const Text(
                            'Edit and manage your product.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color.fromARGB(255, 140, 136, 136),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Add a new product to your store.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color.fromARGB(255, 140, 136, 136),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    SizedBox(height: 25.0),
                    //buildCircle(0,0),
                    SizedBox(height: 16.0),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          " *",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(197, 113, 113, 113),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton2<String>(
                        hint: Text(controller.getProductDetailsModel.value.data
                                ?.category?.categoryName ??
                            "Select Category"),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        value: controller.selectedcategory.value?.isNotEmpty ??
                                false
                            ? controller.selectedcategory.value
                            : null,
                        items: controller.getCategoryModel.value.data?.docs
                            ?.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.categoryId.toString(),
                            child: Text(
                              item.categoryName ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.selectedsubcategory.value = null;
                          controller.selectedcategory.value = newValue ?? "";
                          controller.categoryid.value = newValue!;
                          controller
                              .getSubCategoryApi(controller.categoryid.value);
                          controller.categorybool = true;
                          print(controller.categoryid.value);
                        },
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .918,
                          offset: const Offset(-9, -3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),

                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "SubCategory",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " *",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Brand",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  " *",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(197, 113, 113, 113),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton2<String>(
                                hint: Text(controller.getProductDetailsModel
                                        .value.data?.category?.categoryName ??
                                    "Select SubCategory"),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                value: controller.selectedsubcategory.value
                                            ?.isNotEmpty ??
                                        false
                                    ? controller.selectedsubcategory.value
                                    : null,
                                items: controller
                                    .getSubCategoryModel.value.data?.docs
                                    ?.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.categoryId.toString(),
                                    child: Text(
                                      item.categoryName.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.selectedsubcategory.value =
                                      newValue ?? "";
                                  controller.subcategoryid.value = newValue!;
                                  controller.subcategorybool = true;
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * .25,
                                  width:
                                      MediaQuery.of(context).size.width * .438,
                                  offset: const Offset(-8, -2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                ),
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(197, 113, 113, 113),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton2<String>(
                                hint: Text(controller.getProductDetailsModel
                                        .value.data?.brand?.brandName ??
                                    "Select Brand"),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                value: controller
                                            .selectedbrand.value?.isNotEmpty ??
                                        false
                                    ? controller.selectedbrand.value
                                    : null,
                                items: controller.getBrandModel.value.data?.docs
                                    ?.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.brandId.toString(),
                                    child: Text(
                                      item.brandName.toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.selectedbrand.value =
                                      newValue ?? "";
                                  controller.brandid.value = newValue!;
                                  controller.brandbool = true;
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * .25,
                                  width:
                                      MediaQuery.of(context).size.width * .438,
                                  offset: const Offset(-8, -2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                ),
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),

                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          " *",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return '*Required Field! Please enter Product name';
                        }
                        return null;
                      },
                      cursorColor: Colors.grey,
                      cursorWidth: 1.5,
                      style: const TextStyle(height: 1),
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                        RemoveTrailingPeriodsFormatter(),
                        EmojiInputFormatter(),
                        SpecialCharacterValidator(),
                        LengthLimitingTextInputFormatter(50)
                      ],
                      controller: controller.nameController.value,
                      decoration: const InputDecoration(
                        hintText: 'Enter your  Product name',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(82, 151, 92, 71),
                              width: 2.0),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Store",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          " *",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(197, 113, 113, 113),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton2<String>(
                        hint: Text(controller.getProductDetailsModel.value.data
                                ?.store?.storeName ??
                            "Select a Store"),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        value:
                            controller.selectedstore.value?.isNotEmpty ?? false
                                ? controller.selectedstore.value
                                : null,
                        items: controller.getStoreModel.value.data?.docs
                            ?.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.storeId.toString(),
                            child: Text(
                              item.storeName.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.storebool = true;
                          controller.selectedstore.value = newValue ?? "";
                          controller.storeid.value = newValue!;
                        },
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .915,
                          offset: const Offset(-8, -2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                    SizedBox(height: 5.0),

                    controller.getStoreModel.value.data?.docs?.isEmpty ?? true
                        ? Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Please Add Store to Add Product...!',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Color.fromARGB(255, 144, 58, 58),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 16.0),

                    // Description Field
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          " *",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
                      controller:
                          controller.detaileddescriptionController.value,
                      maxLines: 3,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                        RemoveTrailingPeriodsFormatter(),
                        LengthLimitingTextInputFormatter(1000)
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Enter a detailed description here...',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(82, 151, 92, 71),
                              width: 2.0),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            if (controller.producteditId == false) {
                              if (controller
                                      .nameController.value.text.isNotEmpty &&
                                  controller.detaileddescriptionController.value
                                      .text.isNotEmpty &&
                                  controller.categoryid.value.isNotEmpty &&
                                  controller.subcategoryid.value.isNotEmpty &&
                                  controller.brandid.value.isNotEmpty &&
                                  controller.storeid.value.isNotEmpty) {
                                controller.clickNext.value = false;
                                controller.addProductApi(context);

                                print(controller.clickNext.value);
                              } else {
                                CommonMethods.showToast(
                                    "Please Fill All the Details");
                              }
                            } else {
                              controller.clickNext.value = false;
                              controller.addProductApi(context);

                              print(controller.clickNext.value);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: Text(
                              controller.productId == 0
                                  ? 'Save as draft'
                                  : "Save",
                              style: TextStyle(color: Colors.black)),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(RoutesClass.addproductdetails,arguments: {
            'productid': 0,
            'producteditid': false,
          },);
                            // if (controller.producteditId == false) {
                            //   if (controller
                            //           .nameController.value.text.isNotEmpty &&
                            //       controller.detaileddescriptionController.value
                            //           .text.isNotEmpty &&
                            //       controller.categoryid.value.isNotEmpty &&
                            //       controller.subcategoryid.value.isNotEmpty &&
                            //       controller.brandid.value.isNotEmpty &&
                            //       controller.storeid.value.isNotEmpty) {
                            //     controller.clickNext.value = true;
                            //     controller.addProductApi(context);

                            //     print(controller.clickNext.value);
                            //   } else {
                            //     CommonMethods.showToast(
                            //         "Please Fill All the Details");
                            //   }
                            // } else {
                            //   controller.clickNext.value = true;
                            //   controller.addProductApi(context);

                            //   print(controller.clickNext.value);
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5D2E17),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Next step',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(
            controller.rxRequestStatus.value == Status.LOADING,
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
        ]));
  }
}

Widget buildStepCircle(String title, int stepNumber, bool isActive) {
  return Row(
    children: [
      CircleAvatar(
        radius: 12,
        backgroundColor:
        isActive ? const Color(0xFF5D2E17) : Colors.grey[300],
        foregroundColor: isActive
            ? Colors.white
            : const Color.fromARGB(255, 140, 136, 136),
        child: Text(
          "0$stepNumber",
          style: TextStyle(fontSize: 12),
        ),
      ),
      SizedBox(width: 4),
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: isActive
              ? Colors.black
              : const Color.fromARGB(255, 140, 136, 136),
        ),
      ),
    ],
  );
}

Widget buildStepDivider() {
  return Container(
    margin: const EdgeInsets.fromLTRB(5, 0, 3, 0),
    child: Row(
      children: [
        Container(
          height: 2,
          color: Colors.grey[300],
          width: 10,
        ),
        Icon(
          Icons.arrow_forward_ios, // Right arrow icon
          size: 10, // Size of the arrow
          color: Colors.grey[500], // Light grey color
        ),
      ],
    ),
  );
}
