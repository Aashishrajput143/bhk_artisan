import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/repository/profilerepository.dart';
import 'package:bhk_artisan/Modules/screens/dashboardManagement/home_screen.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/Constants.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/inventorymanagement/inventory.dart';
import '../screens/ordersManagement/order_screen.dart';
import '../screens/productManagement/product_screen.dart';
import '../screens/profileManagement/main_profile.dart';

class CommonScreenController extends GetxController {
  final _api = ProfileRepository();
  var selectedIndex = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    getProfileApi();
    Get.put(LocationController());

  }

  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else {
      return 0;
    }
  }

  final List<Widget> pages = [
    const HomeScreen(), //index=0
    const OrderScreen(), //index=1
    const ProductScreen(), //index=2
    const Inventory(), //index=3
    const MainProfile(), //index=4
  ];

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Orders'),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Products'),
    BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Inventory'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  final profileData = GetProfileModel().obs;
  void setProfileData(GetProfileModel value) => profileData.value = value;
  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxString error = ''.obs;
  void setError(String value) => error.value = value;



  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getprofileApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setProfileData(value);
             Utils.savePreferenceValues(Constants.userId, "${value.data?.id}");
             debugPrint("user_id===>${value.data?.id}");
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(
        error,stackTrace,
        setError: setError,
        setRxRequestStatus: setRxRequestStatus,
      );
    });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}