import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/ordersmodel.dart';
import '../repository/orderrepository.dart';

class GetOrderController extends GetxController {
  final repository = OrderRepository();

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final getorderModel = GetOrdersModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setgetordersdata(GetOrdersModel value) => getorderModel.value = value;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //getOrdersApi();
  }

  Future<void> ordersRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    getOrdersApi();
    print("items.length");
  }

  Future<void> getOrdersApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getorderApi().then((value) {
        setgetordersdata(value);
        setRxRequestStatus(Status.COMPLETED);
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
