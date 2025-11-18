import 'package:bhk_artisan/Modules/controller/product_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/add_address_model.dart';
import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/repository/address_repository.dart';
import 'package:bhk_artisan/Modules/repository/profile_repository.dart';
import 'package:bhk_artisan/Modules/screens/home_screen.dart';
import 'package:bhk_artisan/Modules/screens/logisticsManagement/logistics_screen.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/address_type_enum.dart';
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
  final addAddressModel = AddAddressModel().obs;

  void setProfileData(GetProfileModel value) => profileData.value = value;
  void setaddAddressModeldata(AddAddressModel value) => addAddressModel.value = value;

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
            if (value.data?.hasAddress == false) addAddressApi(value.data?.id);
            Utils.printLog("Response===> ${value.toString()}");
            if (value.data?.verifyStatus == false) {
              Get.offAllNamed(RoutesClass.accountVerification);
            }
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> addAddressApi(var id) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "userId": id,
        "isDefault": true,
        "houseNo": locationController.place.value?.name ?? "",
        "street": locationController.place.value?.street ?? locationController.place.value?.subLocality ?? "",
        "city": locationController.place.value?.locality ?? "",
        "state": locationController.place.value?.administrativeArea ?? "",
        "country": locationController.place.value?.country ?? "",
        "postalCode": locationController.place.value?.postalCode ?? "",
        "addressType": AddressType.HOME.name,
        "latitude": locationController.latitude.value,
        "longitude": locationController.longitude.value,
      };

      apiAddress
          .addAddressApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setaddAddressModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
