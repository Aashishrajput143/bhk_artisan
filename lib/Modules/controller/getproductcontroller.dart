import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getproductmodel.dart';
import '../repository/product_repository.dart';

class GetProductController extends GetxController {
  final repository = ProductRepository();
  var isData = true.obs;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //getProductApi();
  }

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  var isProductAdded = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final getProductModel = GetProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  // void setAddProductnData(SignUpModel value) => addproductData.value = value;
  void setGetproductdata(GetProductModel value) =>
      getProductModel.value = value;

  Future<void> productRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    //getProductApi();
    print("items.length");
  }

  Future<void> getProductApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getproductApi().then((value) {
        setGetproductdata(value);
        setRxRequestStatus(Status.COMPLETED);
        print(
            "set data===========>${getProductModel.value.data?.docs?.length}");
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
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
        Utils.printLog("Error===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
