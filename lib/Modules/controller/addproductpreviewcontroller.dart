import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addproductmediamodel.dart';
import '../model/getproductmodel.dart';
import '../repository/productrepository.dart';

class AddProductPreviewController extends GetxController {
  final repository = ProductRepository();

  @override
  void onInit() {
    super.onInit();
    //getProductApi();
    print("length========>${getProductModel.value.data?.docs?.length}");
  }

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  var isProductAdded = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final addProductMediaModel = AddProductMediaModel().obs;
  final getProductModel = GetProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  // void setAddProductnData(SignUpModel value) => addproductData.value = value;

  void setGetproductdata(GetProductModel value) =>
      getProductModel.value = value;

  Future<void> getProductApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getproductApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetproductdata(value);
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
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
