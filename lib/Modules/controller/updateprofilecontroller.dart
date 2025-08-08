import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getprofilemodel.dart';
import '../model/updateprofilemodel.dart';
import '../repository/profilerepository.dart';
import '../repository/updateprofilerepository.dart';

class UpdateProfileController extends GetxController {
  final repository = UpdateProfileRepository();
  final repositoryProfile = ProfileRepository();

  var imageFiles = Rxn<File>();

  openImages(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      imageFiles.value = imageTemp;
      isprofileimage = true;
      print("profile $isprofileimage");
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  bool status = true;
  bool isprofileimage = false;
  bool? isLogin;
  var myFocusNode = FocusNode();
  final otpFormKey = GlobalKey<FormState>();

  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var countryCode = "".obs;

  final List<TextEditingController> otpemailControllers =
      List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> otpphoneControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  // int _selectedScreenIndex = 1;
  // late List _screens;
  // SingleValueDropDownController _cnt = SingleValueDropDownController();
  // String radioButtonItem = 'M';

  // Group Value for Radio Button.
  int id = 1;
  List<dynamic> object = [];

  bool isEmailVerified = false;
  bool isPhoneVerified = false;

  @override
  Future<void> onInit() async {
    super.onInit();

    //getProfileApi();
  }

  void verifyOtp(String title, context) {
    if (otpFormKey.currentState!.validate()) {
      title == "Email" ? isEmailVerified = true : isPhoneVerified = true;

      String otp = title == "Email"
          ? otpemailControllers.map((controller) => controller.text).join()
          : otpphoneControllers.map((controller) => controller.text).join();

      // Simulate OTP verification success
      Navigator.of(context).pop(); // Close dialog on successful verification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title Otp Verified: $otp')),
      );
    }
  }

  Widget showOtpDialog(String title, context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'OTP Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We have sent verification code to.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  width: 50,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: title == "Email"
                          ? otpemailControllers[index]
                          : otpphoneControllers[index],
                      autofocus: index == 5, // Focus on the last text field
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context).requestFocus(
                                focusNodes[index + 1]); // Move to next box
                          } else {
                            FocusScope.of(context)
                                .unfocus(); // Dismiss the keyboard after last box
                          }
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1)
                      ], // Limit to 1 digit
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Resend Code ',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  '(55)',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                verifyOtp(title, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'VERIFY OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Group Value for Radio Button.

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final updateProfileModel = UpdateProfileModel().obs;
  final getProfileModel = GetProfileModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setupdateProfileModeldata(UpdateProfileModel value) =>
      updateProfileModel.value = value;

  void setGetprofiledata(GetProfileModel value) =>
      getProfileModel.value = value;

  Future<File?> downloadImage(String url) async {
    try {
      // Get the application's documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Create a file path in the documents directory
      final filePath = '${directory.path}/profile-image.png';

      // Make a GET request to fetch the image data
      final response = await http.get(Uri.parse(url));

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Write the image bytes to a file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return file; // Return the File object
      } else {
        print('Failed to download image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  Future<void> updateProfileApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {
      if (nameController.value.text.isNotEmpty)
        "name": nameController.value.text,
      if (emailController.value.text.isNotEmpty)
        "email": emailController.value.text,
      if (phoneController.value.text.isNotEmpty)
        "phoneNo": phoneController.value.text,
      if (countryCode.value.isNotEmpty) "countryCode": countryCode.value,
    };
    if (imageFiles.value == null) {
      if (getProfileModel.value.data!.avatar!.isNotEmpty) {
        isprofileimage = true;
        print("profile image.... $isprofileimage");
        imageFiles.value =
            await downloadImage(getProfileModel.value.data?.avatar ?? "");
      }
    }

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      Utils.printLog("Profile image===> ${imageFiles.value}");

      repository
          .updateProfileApi(data, imageFiles.value?.path.toString())
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setupdateProfileModeldata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        //Get.offAllNamed(RoutesClass.gotoProfileScreen());
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
        Utils.printLog("Error===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repositoryProfile.getprofileApi().then((value) async {
        setRxRequestStatus(Status.COMPLETED);
        setGetprofiledata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        nameController.value.text = getProfileModel.value.data?.name ?? "";
        emailController.value.text = getProfileModel.value.data?.email ?? "";
        phoneController.value.text = getProfileModel.value.data?.phoneNo ?? "";
        countryCode.value = getProfileModel.value.data?.countryCode ?? "";
        if (imageFiles.value == null) {
          if (getProfileModel.value.data!.avatar!.isNotEmpty) {
            isprofileimage = true;
            print("profile image.... $isprofileimage");
            imageFiles.value =
                await downloadImage(getProfileModel.value.data?.avatar ?? "");
          }
        }
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  @override
  void dispose() {
    for (var controller in otpphoneControllers) {
      controller.dispose();
    }
    for (var controller in otpemailControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
