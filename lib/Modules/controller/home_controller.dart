import 'dart:convert';

import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/getbrandModel.dart';
import '../model/getcategorymodel.dart';
import '../model/getproductmodel.dart';
import '../model/salesgraphmodel.dart';
import '../model/todayordermodel.dart';
import '../repository/brandrepository.dart';
import '../repository/orderrepository.dart';
import '../repository/productrepository.dart';
import '../repository/salesrepository.dart';

class Homecontroller extends GetxController {
  final repository = ProductRepository();
  final salesrepository = SalesRepository();
  final orderrepository = OrderRepository();
  final brandrepository = BrandRepository();

  var bannerItems = <Map<String, String>>[].obs;
  var currentIndex = 0.obs;
  var sliderController = CarouselSliderController();

  CommonScreenController commonController = Get.find();

  // var chartData = <Map<String, dynamic>>[];

  var chartData = <Map<String, dynamic>>[
  {"month": "Jan", "sales": 120},
  {"month": "Feb", "sales": 150},
  {"month": "Mar", "sales": 180},
  {"month": "Apr", "sales": 100},
  {"month": "May", "sales": 210},
  {"month": "Jun", "sales": 160},
  {"month": "Jul", "sales": 250},
  {"month": "Aug", "sales": 300},
  // {"month": "Sep", "sales": 270},
  // {"month": "Oct", "sales": 220},
  // {"month": "Nov", "sales": 190},
  // {"month": "Dec", "sales": 230},
];

  int currentYear = DateTime.now().year;
  RxDouble scrollPosition = 0.0.obs;
  RxDouble maxScrollExtent = 0.0.obs;
  var dropdownmonth = 'Last 7 days'.obs;
  var dropdownsold = 'Product sales'.obs;

  var scrollController = ScrollController().obs;

  List<String> daysfilter = ['Last 7 days', 'Last 30 days', 'Last 12 months', 'This week', 'This month', 'Year to date'];

  List<String> salesfilter = ['Product sales', 'Units sold'];


  void updateScrollPosition(double position, double maxExtent) {
    if (position == 0.0) {
      scrollPosition.value = scrollPosition.value + 10.0;
    }
    scrollPosition.value = position;
    maxScrollExtent.value = maxExtent;
  }

  void showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Icon(Icons.check, color: Colors.white, size: 30),
            ),
            SizedBox(height: 20),
            // Success Title
            Text(
              "Success!",
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Success Message
            Text(
              "You have successfully logged into the system",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
            ),
            SizedBox(height: 20),
            // Go to Main Screen Button
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close the dialog and navigate to the main screen
                // Navigate to the main screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 118, 60, 31),
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Go to Dashboard", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void showExitDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Row(
          children: [
            Icon(Icons.help_outline, color: Colors.orange, size: 30),
            SizedBox(width: 8),
            Text("Confirm Exit...!!!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Text("Are you sure you want to exit?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog without doing anything
                },
                child: Text("CANCEL", style: TextStyle(color: Colors.pink)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close dialog and stay in the app
                    },
                    child: Text("NO", style: TextStyle(color: Colors.pink)),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop(); // Exit the app
                    },
                    child: Text("YES", style: TextStyle(color: Colors.pink)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onInit() {
    super.onInit();
    bool isDialog = Get.arguments?['isDialog'] ?? false;

    scrollController.value.addListener(() {
      scrollPosition.value = scrollController.value.position.pixels;
      maxScrollExtent.value = scrollController.value.position.maxScrollExtent;
    });

    // getCategoryApi();

    // getSalesApi();
    // getTodayorderApi();
    // getBrandApi();
    // getProductApi();
    // getTrendingProductApi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isDialog) {
        showSuccessDialog();
      }
    });

    bannerItems.addAll([
      {'imagePath': appImages.dashboardbanner, 'title': 'HAND MADE GIFTS', 'subtitle': 'Discount 50% for \nthe first transaction', 'discount': 'UP TO 50-60% OFF'},
      {'imagePath': appImages.dashboardbanner, 'title': 'BIGGEST SAVINGS ONLY HERE', 'subtitle': 'Discount 50% for \nthe first transaction', 'discount': 'UP TO 80% OFF'},
      {'imagePath': appImages.dashboardbanner, 'title': 'JEWELLERY & ACCESSORIES', 'subtitle': 'Discount 50% for \nthe first transaction', 'discount': 'UP TO 60-70% OFF'},
      {'imagePath': appImages.dashboardbanner, 'title': 'HOME DECOR & MORE', 'subtitle': 'Discount 50% for \nthe first transaction', 'discount': 'UP TO 60-70% OFF'},
    ]);
  }

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final getCategoryModel = GetCategoryModel().obs;
  final getBrandModel = GetBrandModel().obs;
  final getSalesModel = SalesGraphModel().obs;
  final getTodayOrdersModel = TodayOrdersModel().obs;
  final getProductModel = GetProductModel().obs;
  final getTrendingProductModel = GetProductModel().obs;

  void setGetCategorydata(GetCategoryModel value) => getCategoryModel.value = value;

  void setGetbranddata(GetBrandModel value) => getBrandModel.value = value;
  void setGetTotalSalesdata(SalesGraphModel value) => getSalesModel.value = value;
  void setGettodayOrderdata(TodayOrdersModel value) => getTodayOrdersModel.value = value;
  void setGetproductdata(GetProductModel value) => getProductModel.value = value;
  void setGettrendingproductdata(GetProductModel value) => getTrendingProductModel.value = value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // getCategoryApi();
    // getBrandApi();
    // getSalesApi();
    // getTodayorderApi();
    // getTrendingProductApi();
    // getProductApi();
  }

  Future<void> getBrandApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      brandrepository
          .getdashbrandApi(1)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setGetbranddata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
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

            chartData =
                monthsData?.map((data) {
                  return {'month': data.month, 'sales': data.sales};
                }).toList() ??
                [];
            print("redirect");
          })
          .onError((error, stackTrace) {
            handleApiError(
        error,stackTrace,
        setError: setError,
        setRxRequestStatus: setRxRequestStatus,
      );
    });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getTodayorderApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      orderrepository
          .gettodayorderApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setGettodayOrderdata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("> ${getTodayOrdersModel.value.data?.totalCount.toString()}");
            Utils.printLog("Response===> ${value.toString()}");
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

  Future<void> getCategoryApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository
          .getcategoryApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setGetCategorydata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
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

  Future<void> getProductApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository
          .getproductApi()
          .then((value) {
            setGetproductdata(value);
            setRxRequestStatus(Status.COMPLETED);
            print("set data===========>${getProductModel.value.data?.docs?.length}");
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
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
            Utils.printLog("Error===> ${stackTrace.toString()}");
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getTrendingProductApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository
          .getTrendingproductApi()
          .then((value) {
            setGettrendingproductdata(value);
            setRxRequestStatus(Status.COMPLETED);
            print("set data===========>${getTrendingProductModel.value.data?.docs?.length}");
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
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
            Utils.printLog("Error===> ${stackTrace.toString()}");
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> dashboardRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    // getCategoryApi();
    // getBrandApi();
    // getSalesApi();
    // getTodayorderApi();
    // getProductApi();
    // getTrendingProductApi();
    // print("items.length");
  }
}
