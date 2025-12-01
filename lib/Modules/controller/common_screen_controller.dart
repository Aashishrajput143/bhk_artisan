import 'package:bhk_artisan/Modules/controller/product_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/repository/address_repository.dart';
import 'package:bhk_artisan/Modules/repository/profile_repository.dart';
import 'package:bhk_artisan/Modules/screens/common_screen.dart';
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

class CommonScreenController extends GetxController with WidgetsBindingObserver {
  final _api = ProfileRepository();
  var selectedIndex = 0.obs;
  final apiAddress = AddressRepository();
  var isDialog = false.obs;

  late LocationController locationController;

  var screen = CommonScreen();

  ProductController productController = Get.put(ProductController());

  @override
  void onInit() {
    super.onInit();
    isDialog.value = Get.arguments?['isDialog'] ?? false;
    getProfileApi();
    WidgetsBinding.instance.addObserver(this);
    locationController = Get.find<LocationController>();
  }

  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else {
      return 0;
    }
  }

  void onTap(index) {
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
    BottomNavigationBarItem(icon: Icon(Icons.home), label: appStrings.home),
    BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: appStrings.orders),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: appStrings.products),
    BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: appStrings.logistics),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: appStrings.profile),
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
          .then((value) async {
            setRxRequestStatus(Status.COMPLETED);
            setProfileData(value);
            Utils.savePreferenceValues(Constants.userId, "${value.data?.id}");
            debugPrint("user_id===>${value.data?.id}");
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
            if (value.data?.verifyStatus == false) {
              Get.offAllNamed(RoutesClass.accountVerification);
            }
            if (value.data?.hasAddress == false) {
              await Future.delayed(Duration(seconds: 30));
              screen.showUpdateLocationDialog();
            }
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
