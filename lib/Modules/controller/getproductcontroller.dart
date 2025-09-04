import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../repository/product_repository.dart';

class GetProductController extends GetxController {
  final _api = ProductRepository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final getApprovedProductModel = ProductListingModel().obs;
  final getPendingProductModel = ProductListingModel().obs;
  final getDisapprovedProductModel = ProductListingModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setApprovedProductdata(ProductListingModel value) => getApprovedProductModel.value = value;
  void setPendingProductdata(ProductListingModel value) => getPendingProductModel.value = value;
  void setDisapprovedProductdata(ProductListingModel value) => getDisapprovedProductModel.value = value;

  @override
  onInit() {
    super.onInit();
    getProductApi("APPROVED");
  }

  Future<void> productRefresh(var status) async {
    getProductApi(status);
  }

  Future<void> getProductApi(var status, {bool isLoader = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (isLoader) setRxRequestStatus(Status.LOADING);
      _api
          .getproductApi(status)
          .then((value) {
            if (isLoader) setRxRequestStatus(Status.COMPLETED);
            if (status == "APPROVED") {
              setApprovedProductdata(value);
            } else if (status == "PENDING") {
              setPendingProductdata(value);
            } else if (status == "DISAPPROVED") {
              setDisapprovedProductdata(value);
            }
            Utils.printLog("Response ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
