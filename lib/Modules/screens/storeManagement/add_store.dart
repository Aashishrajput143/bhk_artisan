import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../controller/addstorecontroller.dart';

class AddStore extends ParentWidget {
  const AddStore({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddStoreController controller = Get.put(AddStoreController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: AppGradients.customGradient),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text(
                "New Store".toUpperCase(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(195, 247, 243, 233),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [SizedBox(width: 5), Icon(Icons.store, size: 20.0, color: Colors.blue), SizedBox(width: 10.0), Text('Add Store', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))],
                      ),
                      SizedBox(height: 5.0),
                      const Text('Add a new Store.', style: TextStyle(fontSize: 11.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold)),
                      SizedBox(height: 16.0),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Store Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {},
                          inputFormatters: [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(20), EmojiInputFormatter(), SpecialCharacterValidator(), RemoveTrailingPeriodsFormatter()],
                          hint: 'Enter Store Name'),
                      SizedBox(height: 16.0),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("House/Flat Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      commonTextField(controller.addresshouseController.value, controller.addresshouseFocusNode.value, w, (value) {},
                          inputFormatters: [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(20), EmojiInputFormatter(), SpecialCharacterValidator(), RemoveTrailingPeriodsFormatter()],
                          hint: 'Enter House/Flat Number'),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Street", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      commonTextField(controller.addressstreetController.value, controller.addressstreetFocusNode.value, w, (value) {},
                          inputFormatters: [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(20), EmojiInputFormatter(), SpecialCharacterValidator(), RemoveTrailingPeriodsFormatter()],
                          hint: 'Enter your Street'),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: commonLocation(
                          controller.countryValue,
                          controller.stateValue,
                          controller.cityValue,
                          onCountryChanged: (value) => controller.countryValue.value = value,
                          onStateChanged: (value) => controller.stateValue.value = value,
                          onCityChanged: (value) => controller.cityValue.value = value,
                        ),),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Pin Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      commonTextField(controller.pincodeController.value, controller.pincodeFocusNode.value, w, (value) {},
                          hint: 'Enter Pin Code',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly,
                            NoLeadingSpaceFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 6),
                      /*SizedBox(height: 16.0),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Select Store Opening Time",
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
                  TextField(
                    style: TextStyle(height: 0.6),
                    controller: openingTime,
                    decoration: const InputDecoration(
                      hintText: 'Enter Store opening Time',
                      hintStyle: TextStyle(fontSize: 12),
                      prefixIcon: Icon(Icons.timer, size: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0), // Customize border color and width
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(82, 151, 92, 71),
                            width:
                                2.0), // Customize border color and width when focused
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay _selectedTime = TimeOfDay.now();
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null && picked != _selectedTime) {
                        setState(() {
                          _selectedTime = picked;
                          // Format the time to 24-hour format
                          String formattedTime = DateFormat('HH:mm').format(
                              DateTime(0, 0, 0, _selectedTime.hour,
                                  _selectedTime.minute));
                          openingTime.text = formattedTime;
                        });
                      }
                      // Show the time picker
                      // TimeOfDay? pickedTime = await showTimePicker(
                      //   initialTime: TimeOfDay.now(),
                      //   context: context,
                      // );

                      // if (pickedTime != null) {
                      //   // Format the picked time to a 12-hour format string
                      //   String formattedTime12Hour =
                      //       pickedTime.format(context).trim();
                      //   print(
                      //       'Picked time in 12-hour format: $formattedTime12Hour');

                      //   // Parse the time using a 12-hour format
                      //   DateTime parsedTime =
                      //       DateFormat.jm().parse(formattedTime12Hour);
                      //   print('Parsed DateTime: $parsedTime');

                      //   // Format the parsed time to a 24-hour format string
                      //   String formattedTime24Hour =
                      //       DateFormat('HH:mm:ss').format(parsedTime);
                      //   print(
                      //       'Formatted time in 24-hour format: $formattedTime24Hour');

                      //   setState(() {
                      //     openingTime.text = formattedTime24Hour;
                      //   });
                      // } else {
                      //   print("Time is not selected");
                      // }
                    },
                  ),
                  SizedBox(height: 16),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Select Store closing time",
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

                  TextField(
                    style: TextStyle(height: 0.6),
                    controller: closingTime,
                    decoration: const InputDecoration(
                      hintText: 'Enter Store closing Time',
                      hintStyle: TextStyle(fontSize: 12),
                      prefixIcon: Icon(Icons.timer, size: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0), // Customize border color and width
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(82, 151, 92, 71),
                            width:
                                2.0), // Customize border color and width when focused
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay _selectedTime = TimeOfDay.now();
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null && picked != _selectedTime) {
                        setState(() {
                          _selectedTime = picked;
                          // Format the time to 24-hour format
                          String formattedTime = DateFormat('HH:mm').format(
                              DateTime(0, 0, 0, _selectedTime.hour,
                                  _selectedTime.minute));
                          closingTime.text = formattedTime;
                        });
                      }
                    },
                  ),*/
                      SizedBox(height: 16),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Description", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      commonTextField(
                        controller.descriptionController.value,
                        controller.descriptionFocusNode.value,
                        w,
                        (value) {},
                        hint: 'Enter a description here...',
                        maxLines: 3,
                        inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), LengthLimitingTextInputFormatter(1000)],
                      ),
                      SizedBox(height: 16),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Upload Image", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image, size: 50, color: Colors.grey),
                            const SizedBox(height: 8.0),
                            const Text("Upload your image here"),
                            const SizedBox(height: 4.0),
                            ElevatedButton(
                              onPressed: () => controller.openImages(context),
                              child: const Text('Click to browse', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Add a image to your Store. Used to represent your Store during checkout, in email, social sharing, and more.",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 5),
                      Text(controller.errormessage, style: TextStyle(color: Colors.red)),
                      SizedBox(height: 8.0),
                      Text("Picked File:"),
                      Divider(),
                      controller.imagefiles.value != null ? Image.file(controller.imagefiles.value!, width: 100, height: 100) : Text("No image selected"),
                      SizedBox(height: 50),
                      commonButton(w, 50, Color(0xFF5D2E17), hint: 'Add Store', Colors.white, () {
                        if (controller.validate()) {
                          controller.addStoreApi(context);
                        } else {
                          CommonMethods.showToast("Please Fill All the Details");
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w)
        ],
      ),
    );
  }
}
