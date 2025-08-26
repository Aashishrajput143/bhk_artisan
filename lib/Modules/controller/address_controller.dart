import 'package:bhk_artisan/common/Constants.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
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

  var hasAddress = false.obs;

  LocationController locationController = Get.put(LocationController());

  var addresses = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
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

  void loadData() async {
    String? defaultId = await Utils.getPreferenceValues(Constants.defaultAddress);

    addresses.value = [
      AddressModel(id: "1", title: "Home", fullAddress: "123 MG Road, New South Wales (NSW), New Delhi, 110059, India", isDefault: false),
      AddressModel(id: "2", title: "Work", fullAddress: "7th Floor, Tech Park, Cyber City, Gurugram, Haryana, 122022, India", isDefault: false),
      AddressModel(id: "3", title: "Others", fullAddress: "Flat 405, Sunshine Apartments, Banjara Hills, Hyderabad, Telangana, 500034, India", isDefault: false),
    ];

    if (defaultId != null && defaultId.isNotEmpty) {
      addresses.value = addresses.map((a) {
        return a.copyWith(isDefault: a.id == defaultId);
      }).toList();
    } else {
      addresses[0] = addresses[0].copyWith(isDefault: true);
    }
  }

  void markAsDefault(String id) {
    addresses.value = addresses.map((a) {
      return a.copyWith(isDefault: a.id == id);
    }).toList();

    Utils.savePreferenceValues(Constants.defaultAddress, id);
  }

  void deleteAddress(String id) {
    final address = addresses.firstWhere((a) => a.id == id);

    if (address.isDefault) {
      // Show your common toast
      CommonMethods.showToast("Default address cannot be deleted", icon: Icons.warning);
      return;
    }
    addresses.removeWhere((a) => a.id == id);
  }

  var type = "Home".obs;
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
