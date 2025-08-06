import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/getprofilemodel.dart';
import '../repository/profilerepository.dart';
import 'common_screen_controller.dart';

class ProfileController extends GetxController {
  CommonScreenController commonDashController = Get.put(CommonScreenController());
  profile(int index) {
    print(index);
    switch (index) {
      case 1: //MyOrders
        //commonDashController.selectedScreenIndex.value = 1;

        break;
      case 2: //Mystores
        Get.toNamed(RoutesClass.gotoStoreScreen());

        break;

      case 3: //Notifications
        Get.toNamed(RoutesClass.gotoNotificationScreen());

        break;
      case 4:
        Get.toNamed(RoutesClass.gotoSettingScreen())?.then((onValue) {
          //getProfileApi();
        });

        break;
    }
  }

  bool? isLogin;

  final repository = ProfileRepository();

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final getProfileModel = GetProfileModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setGetprofiledata(GetProfileModel value) =>
      getProfileModel.value = value;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //getProfileApi();
  }

  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getprofileApi().then((value) {
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

  Widget buildProfileOptionCard(
      String title, String subtitle, IconData icon, int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () {
            profile(index);
          },
        ),
        const Divider(
          height: 3,
          thickness: 0.25,
          endIndent: 0,
          color: Colors.black,
        ),
      ],
    );
  }
}
