import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/Modules/controller/logincontroller.dart';
import 'package:bhk_artisan/Modules/screens/login_screen.dart';
import 'package:bhk_artisan/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getprofilemodel.dart';
import '../model/logoutmodel.dart';
import '../repository/logoutRepository.dart';
import '../repository/profilerepository.dart';

class Appbardrawercontroller extends GetxController {
  final repository = LogoutRepository();
  final profilerepository = ProfileRepository();

  void showlogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.orange, size: 30),
            SizedBox(width: 8),
            Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Text("Are you sure you want to Logout?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog without doing anything
                },
                child: Text("CANCEL", style: TextStyle(color: Colors.pink)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close dialog and stay in the app
                    },
                    child: Text("NO", style: TextStyle(color: Colors.pink)),
                  ),
                  TextButton(
                    onPressed: () {
                      logOutApi();
                    },
                    child: Text("YES", style: TextStyle(color: Colors.pink)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final logoutModel = LogoutModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setLogoutdata(LogoutModel value) => logoutModel.value = value;

  final getProfileModel = GetProfileModel().obs;

  void setGetprofiledata(GetProfileModel value) => getProfileModel.value = value;



  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      profilerepository.getprofileApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetprofiledata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
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

  Future<void> profileRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    //getProfileApi();
    print("items.length");
  }

  Future<void> logOutApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.logoutApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setLogoutdata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        redirect();
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

  redirect() {
    Utils.savePreferenceValues(Constants.accessToken, "");
    Utils.savePreferenceValues(Constants.email, "");
    Utils.clearPreferenceValues();
    Get.delete<LoginController>();
    Get.put(LoginController());
    Get.offAll(() => LoginScreen());
  }
}
