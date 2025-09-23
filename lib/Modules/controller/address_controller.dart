import 'package:bhk_artisan/Modules/model/add_address_model.dart';
import 'package:bhk_artisan/Modules/model/get_address_model.dart';
import 'package:bhk_artisan/Modules/repository/address_repository.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_methods.dart';
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
    locationController.getCurrentLocation();
    if (locationController.place.value != null) {
      loadLocation();
    }
    ever(locationController.place, (_) {
      loadLocation();
    });
  }

  void loadLocation() {
    flatNameController.value.text = locationController.place.value?.name ?? "";
    streetNameController.value.text = locationController.place.value?.subLocality ?? "";
    cityController.value.text = locationController.place.value?.locality ?? "";
    stateController.value.text = locationController.place.value?.administrativeArea ?? "";
    countryController.value.text = locationController.place.value?.country ?? "";
    pinController.value.text = locationController.place.value?.postalCode ?? "";
    lanMarkController.value.text = "";
  }

  void getLocationApi(int index) {
    hasDefault.value = getAddressModel.value.data?[index].isDefault ?? false;
    addressType.value = (getAddressModel.value.data?[index].addressType ?? "OTHERS").toAddressType();
    flatNameController.value.text = getAddressModel.value.data?[index].houseNo ?? "";
    streetNameController.value.text = getAddressModel.value.data?[index].street ?? "";
    cityController.value.text = getAddressModel.value.data?[index].city ?? "";
    stateController.value.text = getAddressModel.value.data?[index].state ?? "";
    countryController.value.text = getAddressModel.value.data?[index].country ?? "";
    pinController.value.text = getAddressModel.value.data?[index].postalCode ?? "";
    lanMarkController.value.text = getAddressModel.value.data?[index].landmark ?? "";
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
    addIfNotEmpty(address.data?[index].landmark);
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

  String? validateStringForm() {
    if ((flatNameController.value.text.isEmpty) && (streetNameController.value.text.isEmpty) && (cityController.value.text.isEmpty) && (stateController.value.text.isEmpty) && (countryController.value.text.isEmpty) && (pinController.value.text.isEmpty) && (addressType.value.addressValue.isEmpty)) {
      return "Please fill all mandatory Fields";
    } else if (flatNameController.value.text.isEmpty) {
      return "Please Enter your house/Flat/Building";
    } else if (streetNameController.value.text.isEmpty) {
      return "Please Enter your Street/Area/Locality";
    } else if (cityController.value.text.isEmpty) {
      return "Please Enter your City";
    } else if (stateController.value.text.isEmpty) {
      return "Please Enter your State";
    } else if (countryController.value.text.isEmpty) {
      return "Please Enter your Country";
    } else if (pinController.value.text.isEmpty) {
      return "Please Enter your Pin Code";
    } else if (addressType.value.addressValue.isEmpty) {
      return "Please Select your Address Type";
    }
    return null;
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

  bool isAddressTypeSelectable(AddressType type, {String? editingId}) {
    if (editingId != null && editingId.isNotEmpty) {
      final editingAddress = getAddressModel.value.data?.firstWhereOrNull((e) => e.id.toString() == editingId);

      if (editingAddress != null) {
        return editingAddress.addressType?.toUpperCase().toAddressType() == type;
      }
      return false;
    }

    return isAddressTypeNotExists(type);
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAddressModel = GetAddressModel().obs;
  final editAddressModel = AddAddressModel().obs;
  final addAddressModel = AddAddressModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setgetAddressModeldata(GetAddressModel value) => getAddressModel.value = value;
  void setaddAddressModeldata(AddAddressModel value) => addAddressModel.value = value;
  void seteditAddressModeldata(AddAddressModel value) => editAddressModel.value = value;

  Future<void> getAddressApi({bool isLoader = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (isLoader) setRxRequestStatus(Status.LOADING);
      _api
          .getAddressApi()
          .then((value) {
            if (isLoader) setRxRequestStatus(Status.COMPLETED);
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

  Future<void> editAddressApi(var id, {bool isDefault = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      //setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {};

      if (isDefault) {
        data = {"isDefault": true};
      } else {
        data = {
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
      }

      _api
          .editAddressApi(data, id)
          .then((value) {
            //setRxRequestStatus(Status.COMPLETED);
            seteditAddressModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            getAddressApi(isLoader: false);
            if (!isDefault) {
              Get.back();
              CommonMethods.showToast("Address Updated Successfully...", icon: Icons.check, bgColor: Colors.green);
            }
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> deleteAddressApi(var id, {bool loader = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      _api
          .deleteAddressApi(id)
          .then((value) {
            if (loader) setRxRequestStatus(Status.COMPLETED);
            seteditAddressModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            getAddressApi(isLoader: false);
            CommonMethods.showToast("Address Deleted Successfully...", icon: Icons.check, bgColor: Colors.green);
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
