import 'package:bhk_artisan/Modules/model/add_address_model.dart';
import 'package:bhk_artisan/Modules/model/get_address_model.dart';
import 'package:bhk_artisan/Modules/repository/address_repository.dart';
import 'package:bhk_artisan/common/Constants.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/address_type_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final _api = AddressRepository();

  var cityController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var countryController = TextEditingController().obs;
  var flatNameController = TextEditingController().obs;
  var streetNameController = TextEditingController().obs;
  var lanMarkController = TextEditingController().obs;
  var pinController = TextEditingController().obs;

  var cityFocusNode = FocusNode().obs;
  var stateFocusNode = FocusNode().obs;
  var countryFocusNode = FocusNode().obs;
  var flatFocusNode = FocusNode().obs;
  var streetFocusNode = FocusNode().obs;
  var landMarkFocusNode = FocusNode().obs;
  var pinFocusNode = FocusNode().obs;

  var addressType = AddressType.HOME.obs;
  var hasDefault = false.obs;

  LocationController locationController = Get.put(LocationController());

  @override
  void onInit() {
    super.onInit();
    getAddressApi();
    if (locationController.place.value != null) {
      loadLocation();
    }
    ever(locationController.place, (_) {
      loadLocation();
    });
  }

  void loadLocation() {
    flatNameController.value.text = locationController.place.value?.name ?? "";
    streetNameController.value.text = locationController.place.value?.street ?? "";
    lanMarkController.value.text = locationController.place.value?.subLocality ?? "";
    cityController.value.text = locationController.place.value?.locality ?? "";
    stateController.value.text = locationController.place.value?.administrativeArea ?? "";
    countryController.value.text = locationController.place.value?.country ?? "";
    pinController.value.text = locationController.place.value?.postalCode ?? "";
  }

  bool isAddressTypeNotExists(AddressType type) {
    return !(getAddressModel.value.data?.any((addr) => (addr.addressType ?? "").toLowerCase() == type.addressValue.toLowerCase()) ?? false);
  }

  String getFullAddress(GetAddressModel address, int index) {
    List<String> parts = [];

    void addIfNotEmpty(String? value) {
      if (value != null && value.trim().isNotEmpty) {
        parts.add(value.trim());
      }
    }

    addIfNotEmpty(address.data?[index].houseNo);
    addIfNotEmpty(address.data?[index].street);
    addIfNotEmpty(address.data?[index].city);
    addIfNotEmpty(address.data?[index].state);
    addIfNotEmpty(address.data?[index].postalCode);
    addIfNotEmpty(address.data?[index].country);

    return parts.join(", ");
  }

  bool validateForm() {
    if ((flatNameController.value.text.isNotEmpty) && (streetNameController.value.text.isNotEmpty) && (cityController.value.text.isNotEmpty) && (stateController.value.text.isNotEmpty) && (countryController.value.text.isNotEmpty) && (pinController.value.text.isNotEmpty) && (addressType.value.addressValue.isNotEmpty)) return true;
    return false;
  }

  void setDisabledAddressType() {
    if (isAddressTypeNotExists(AddressType.HOME)) {
      addressType.value = AddressType.HOME;
    } else if (isAddressTypeNotExists(AddressType.OFFICE)) {
      addressType.value = AddressType.OFFICE;
    } else {
      addressType.value = AddressType.OTHERS;
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAddressModel = GetAddressModel().obs;
  final addAddressModel = AddAddressModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setgetAddressModeldata(GetAddressModel value) => getAddressModel.value = value;
  void setaddAddressModeldata(AddAddressModel value) => addAddressModel.value = value;

  Future<void> getAddressApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      String? userId = await Utils.getPreferenceValues(Constants.userId);

      _api
          .getAddressApi(userId ?? "46")
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setgetAddressModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            setDisabledAddressType();
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> addAddressApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "isDefault": hasDefault.value,
        "houseNo": flatNameController.value.text,
        "street": streetNameController.value.text,
        "city": cityController.value.text,
        "state": stateController.value.text,
        "country": countryController.value.text,
        "postalCode": pinController.value.text,
        "addressType": addressType.value.addressValue,
        if (lanMarkController.value.text.isNotEmpty) "landmark": lanMarkController.value.text,
        "latitude": locationController.latitude.value,
        "longitude": locationController.longitude.value,
      };

      _api
          .addAddressApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setaddAddressModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            getAddressApi();
            Get.back();
            CommonMethods.showToast("Address Added Successfully...", icon: Icons.check, bgColor: Colors.green);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}

class AddressModel {
  final String id;
  final String title;
  final String fullAddress;
  final bool isDefault;

  AddressModel({required this.id, required this.title, required this.fullAddress, this.isDefault = false});

  AddressModel copyWith({bool? isDefault}) {
    return AddressModel(id: id, title: title, fullAddress: fullAddress, isDefault: isDefault ?? this.isDefault);
  }
}
