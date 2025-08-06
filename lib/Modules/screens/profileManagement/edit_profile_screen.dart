import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/updateprofilecontroller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateProfileController controller = Get.put(UpdateProfileController());
    return Obx(() => Stack(children: [
          Container(
            color: const Color.fromARGB(195, 247, 243, 233),
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 247, 243, 233),
              appBar: commonAppBar("Edit Profile"),
              body: Container(
                color: const Color.fromARGB(195, 250, 248, 242),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                controller.imageFiles.value == null
                                    ? Container(
                                        alignment: const Alignment(0.0, 2.5),
                                        child: CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              195, 250, 248, 242),
                                          backgroundImage: controller
                                                      .getProfileModel
                                                      .value
                                                      .data
                                                      ?.avatar
                                                      ?.isNotEmpty ??
                                                  false
                                              ? NetworkImage(controller
                                                      .getProfileModel
                                                      .value
                                                      .data
                                                      ?.avatar ??
                                                  "")
                                              : AssetImage(
                                                  appImages.profile,
                                                ),
                                          radius: 70.0,
                                        ),
                                      )
                                    : Container(
                                        alignment: const Alignment(0.0, 2.5),
                                        child: CircleAvatar(
                                          backgroundImage: FileImage(
                                              controller.imageFiles.value!),
                                          radius: 70.0,
                                        ),
                                      ),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 100.0, left: 90.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 20.0,
                                      child: IconButton(
                                        icon: const Icon(Icons.camera_alt),
                                        color: Colors.white,
                                        onPressed: () {
                                          controller.openImages(context);
                                        },
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "Maximum file size : 5 MB*",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          221, 100, 97, 97)),
                                ),
                                Text(
                                  "Accepted file types : jpg,png,jpeg",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          221, 100, 97, 97)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        const Row(
                          children: [
                            SizedBox(width: 5),
                            Icon(
                              Icons.edit_document,
                              size: 20.0,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Name Field
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
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
                              return '*Required Field! Please Enter Your Name';
                            }
                            return null;
                          },
                          cursorColor: Colors.grey,
                          cursorWidth: 1.5,
                          style: const TextStyle(height: 1),
                          controller: controller.nameController.value,
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            EmojiInputFormatter(),
                            RemoveTrailingPeriodsFormatter(),
                            NoDigitInputFormatter(),
                            SpecialCharacterValidator(),
                            LengthLimitingTextInputFormatter(20)
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter your Name',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(82, 151, 92, 71),
                                  width: 2.0), // Customize focused border
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Enter Email",
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
                              return '*Required Field! Please Enter Email';
                            }
                            return null;
                          },
                          cursorColor: Colors.grey,
                          cursorWidth: 1.5,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            EmailInputFormatter(),
                            EmojiInputFormatter(),
                            RemoveTrailingPeriodsFormatter(),
                            NoLeadingSpaceFormatter(),
                            LengthLimitingTextInputFormatter(
                                50), // Optional: Limit email length
                          ],
                          style: const TextStyle(height: 1),
                          controller: controller.emailController.value,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email',
                            hintStyle: const TextStyle(fontSize: 12),
                            // suffixIcon: controller.isEmailVerified
                            //     ? Icon(Icons.verified, color: Colors.green)
                            //     : TextButton(
                            //         child: Text('Verify'),
                            //         onPressed: () {
                            //           controller.showOtpDialog(
                            //               "Email", context);
                            //         },
                            //       ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(82, 151, 92, 71),
                                  width: 2.0), // Customize focused border
                            ),
                          ),
                        ),

                        const SizedBox(height: 20.0),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Enter Phone",
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
                        // TextFormField(
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please Enter your phone number';
                        //     }
                        //     // Simple phone validation
                        //     if (value.length != 10) {
                        //       return 'Enter a valid phone number';
                        //     }
                        //     return null;
                        //   },
                        //   cursorColor: Colors.grey,
                        //   keyboardType: TextInputType.phone,
                        //   cursorWidth: 1.5,
                        //   readOnly: true,
                        //   style: const TextStyle(height: 1),
                        //   controller: _phoneController,
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter your Phone Number',
                        //     hintStyle: const TextStyle(fontSize: 12),
                        //     suffixIcon: _isPhoneVerified
                        //         ? Icon(Icons.verified, color: Colors.green)
                        //         : TextButton(
                        //             child: Text('Verify'),
                        //             onPressed: () {
                        //               showOtpDialog("Phone");
                        //             },
                        //           ),
                        //     border: const OutlineInputBorder(
                        //       borderSide: BorderSide(width: 2.0),
                        //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //     ),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Color.fromARGB(82, 151, 92, 71),
                        //           width: 2.0), // Customize focused border
                        //     ),
                        //   ),
                        // ),
                        IntlPhoneField(
                          controller: controller.phoneController.value,
                          inputFormatters: [
                            NoLeadingZeroFormatter(), // Custom formatter to prevent leading zero
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter your Phone Number',
                            hintStyle: const TextStyle(fontSize: 12),
                            // suffixIcon: controller.isPhoneVerified
                            //     ? Icon(Icons.verified, color: Colors.green)
                            //     : TextButton(
                            //         child: Text('Verify'),
                            //         onPressed: () {
                            //           controller.showOtpDialog(
                            //               "Phone", context);
                            //         },
                            //       ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(82, 151, 92, 71),
                                  width: 2.0), // Customize focused border
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 5.0,
                            ),
                          ),
                          initialCountryCode: 'IN',
                          languageCode: "en",
                          onCountryChanged: (country) {
                            print('Country changed to: ${country.dialCode}');
                          },
                        ),

                        //const SizedBox(height: 16.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text("Set as default Address"),
                        //     FlutterSwitch(
                        //       width: 40.0,
                        //       height: 18.0,
                        //       valueFontSize: 12.0,
                        //       toggleSize: 18.0,
                        //       padding: 1,
                        //       value: status4,
                        //       onToggle: (val) {
                        //         setState(() {
                        //           status4 = val;
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 35.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                          const Color(0xFF5D2E17),
                                        ),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    // BorderRadius.zero,
                                                    BorderRadius.circular(
                                                        30)))),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),

                                    onPressed: () {
                                      controller.status = true;
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Navigator.of(context).pop();
                                    },
                                    // ignore: unnecessary_new
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                          const Color(0xFF5D2E17),
                                        ),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    // BorderRadius.zero,
                                                    BorderRadius.circular(
                                                        30)))),
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (controller.isprofileimage == true) {
                                        controller
                                            .setRxRequestStatus(Status.LOADING);
                                        controller.updateProfileApi(context);
                                      } else {
                                        CommonMethods.showToast(
                                            "Please upload profile image");
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
