import 'package:bhk_artisan/Modules/controller/order_screen_controller.dart';
import 'package:bhk_artisan/Modules/controller/product_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/repository/profile_repository.dart';
import 'package:bhk_artisan/Modules/screens/home_screen.dart';
import 'package:bhk_artisan/Modules/screens/logisticsManagement/logistics_screen.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/ordersManagement/order_screen.dart';
import '../screens/productManagement/product_screen.dart';
import '../screens/profileManagement/main_profile.dart';

class CommonScreenController extends GetxController {
  final _api = ProfileRepository();
  var selectedIndex = 0.obs;
  var isDialog = false.obs;

  ProductController? productController;
  OrderController? orderController;

  @override
  void onInit() {
    super.onInit();
    isDialog.value = Get.arguments?['isDialog'] ?? false;
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

  void onTap(index) {
    if (index == 0) {
      orderController?.changeTab(0);
      productController?.changeTab(0);
      update();
    }
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    const HomeScreen(), //index=0
    const OrderScreen(), //index=1
    const ProductScreen(), //index=2
    const LogisticsScreen(), //index=3
    const MainProfile(), //index=4
  ];

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Orders'),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Products'),
    BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Logistics'),
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
            if (value.data?.verifyStatus == false) {
              Get.offAllNamed(RoutesClass.accountVerification);
            }
            productController = Get.put(ProductController());
            orderController = Get.put(OrderController());
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
