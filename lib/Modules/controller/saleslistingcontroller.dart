import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:get/get.dart';

import '../model/salesgraphmodel.dart';
import '../repository/salesrepository.dart';

class SalesListingController extends GetxController {
  final salesrepository = SalesRepository();
  var chartData = <Map<String, dynamic>>[].obs;
  int currentYear = DateTime.now().year;

  @override
  void onInit() {
    fetchChartData();
    super.onInit();
  }

  void fetchChartData() {
    chartData.value = [
      {"month": "Jan", "sales": 100},
      {"month": "Feb", "sales": 200},
      {"month": "Mar", "sales": 300},
      {"month": "Apr", "sales": 400},
      {"month": "May", "sales": 500},
      {"month": "Jun", "sales": 600},
      {"month": "Jul", "sales": 700},
      {"month": "Aug", "sales": 800},
    ];
  }

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final getSalesModel = SalesGraphModel().obs;

  void setGetTotalSalesdata(SalesGraphModel value) => getSalesModel.value = value;

  Future<void> getSalesApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      int currentYear = DateTime.now().year;

      salesrepository
          .getsalesApi(currentYear)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setGetTotalSalesdata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
            var monthsData = getSalesModel.value.data?.monthsData;

            chartData.value =
                monthsData?.map((data) {
                  return {'month': data.month, 'sales': data.sales};
                }).toList() ??
                [];
            print("redirect");
          })
          .onError((error, stackTrace) {
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
