import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/Modules/model/add_product_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadOrderImageController extends GetxController {
  final _api = OrderRepository();

  var imagefiles = <String>[].obs;
  var id = 0.obs;
  var isButtonEnabled = true.obs;
  var addressId = "0".obs;

  AddressController addressController = Get.put(AddressController());

  @override
  void onInit() {
    id.value = (Get.arguments ?? 0);
    if (id.value != 0) {
      ever(addressController.getAddressModel, (_) => setDefaultSelection());
    }
    super.onInit();
  }

  void setDefaultSelection() {
    final addresses = addressController.getAddressModel.value.data ?? [];
    if (addresses.isNotEmpty) {
      final defaultAddress = addresses.firstWhere((a) => a.isDefault == true);

      if (defaultAddress.id != null) {
        addressId.value = (defaultAddress.id ?? 0).toString();
      }
    }
  }

  String getFullAddress(int index) {
    final address = addressController.getAddressModel.value;
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

  String? validateStringForm() {
    if ((imagefiles.length < 4 || imagefiles.length > 10)) {
      return "Please Upload Min 4 and Max 10 Images";
    }
    return null;
  }

  final rxRequestStatus = Status.COMPLETED.obs;

  final addProductData = AddProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setaddProductModeldata(AddProductModel value) => addProductData.value = value;

  Future<void> uploadOrderImageApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, String> data = {"progress_percentage": "100", "progress_status": OrderStatus.COMPLETED.name, "addressId": addressId.value};
      _api
          .updateOrderImageApi(data, imagefiles, id)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setaddProductModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Get.back();
            Get.back();
            CommonMethods.showToast("Order Completed Successfully...", icon: Icons.check, bgColor: Colors.green);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
