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
  var isData = true.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final getProductModel = ProductListingModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setGetproductdata(ProductListingModel value) => getProductModel.value = value;

  @override
  onInit() {
    super.onInit();
    getProductApi("APPROVED");
  }

  Future<void> productRefresh(var status) async {
    getProductApi(status);
  }

  Future<void> getProductApi(var status) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getproductApi(status)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setGetproductdata(value);
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
