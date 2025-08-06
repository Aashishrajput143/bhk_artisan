import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/addbrandcontroller.dart';

class AddBrand extends StatelessWidget {
  const AddBrand({super.key});
  @override
  Widget build(BuildContext context) {
    AddBrandController controller = Get.put(AddBrandController());
    return Obx(() => Stack(children: [
          Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 243, 233),
            appBar: commonAppBar("Add Brand"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    const Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(
                          Icons.store,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Add Brand',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                        
                    // Subtitle
                    const Text(
                      'Add a Brand.',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color.fromARGB(255, 140, 136, 136),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Brand Name",
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
                          return '*Required Field! Please Enter Brand Name';
                        }
                        return null;
                      },
                      cursorColor: Colors.grey,
                      cursorWidth: 1.5,
                      style: const TextStyle(height: 1),
                      controller: controller.nameController.value,
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                        RemoveTrailingPeriodsFormatter(),
                        LengthLimitingTextInputFormatter(20),
                        SpecialCharacterValidator(),
                        EmojiInputFormatter()
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Enter Brand Name',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width:
                                  2.0), // Customize border color and width
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(82, 151, 92, 71),
                              width:
                                  2.0), // Customize border color and width when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 3.0),
                    const Text(
                      'Give a Brand Name',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Color.fromARGB(255, 140, 136, 136),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
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
                      inputFormatters: [
                        NoLeadingSpaceFormatter(),
                        RemoveTrailingPeriodsFormatter(),
                        LengthLimitingTextInputFormatter(1000)
                      ],
                      controller: controller.descriptionController.value,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Enter a detailed description here...',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width:
                                  2.0), // Customize border color and width
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(82, 151, 92, 71),
                              width:
                                  2.0), // Customize border color and width when focused
                        ),
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    const Text(
                      'Give a detailed description',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Color.fromARGB(255, 140, 136, 136),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                        
                    // Image Picker Box
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Upload Image",
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
                    SizedBox(height: 5.0),
                    Container(
                      width: double.infinity,
                      height: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.image,
                              size: 50, color: Colors.grey),
                          const SizedBox(height: 8.0),
                          const Text("Upload your image here"),
                          const SizedBox(height: 4.0),
                          ElevatedButton(
                            onPressed: () {
                              controller.openImages(context);
                            },
                            child: const Text(
                              'Click to browse',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                        
                    // Instructions for Image upload
                    Text(
                      "Add a image to your brand. Used to represent your brand during checkout, in email, social sharing, and more.",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.errormessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 8.0),
                        
                    Text("Picked File:"),
                    Divider(),
                    controller.imagefiles.value != null
                        ? Image.file(
                            controller.imagefiles.value!,
                            width: 100,
                            height: 100,
                          )
                        : Text("No image selected"),
                        
                    SizedBox(height: 30),
                        
                    ElevatedButton(
                      onPressed: () {
                        if (controller
                                .nameController.value.text.isNotEmpty &&
                            controller.descriptionController.value.text
                                .isNotEmpty &&
                            controller.imagefiles.value != null) {
                          controller.addBrandApi(context);
                        } else {
                          CommonMethods.showToast(
                              "Please Fill All the Details");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5D2E17),
                        minimumSize: Size(double.infinity, 50),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'Add Brand',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(
              controller.rxRequestStatus.value == Status.LOADING,
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.height)
        ]));
  }
}
