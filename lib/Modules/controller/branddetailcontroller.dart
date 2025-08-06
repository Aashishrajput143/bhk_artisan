import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:get/get.dart';

import '../model/branddetailsmodel.dart';
import '../repository/brandrepository.dart';

class GetBranddetailcontroller extends GetxController {
  final repository = BrandRepository();
  @override
  void onInit() {
    super.onInit();
    int brandId = Get.arguments['brandid'];
    print(brandId);
    //getBrandDetailsApi(brandId);
  }

  int indexs = 1;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final getBrandDetailsModel = BrandDetailsModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setGetBrandDetailsdata(BrandDetailsModel value) =>
      getBrandDetailsModel.value = value;

  Future<void> getBrandDetailsApi(brandId) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getbranddetailsApi(brandId).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetBrandDetailsdata(value);
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
}
