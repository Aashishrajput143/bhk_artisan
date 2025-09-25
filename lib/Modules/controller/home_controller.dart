import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/controller/orderscreencontroller.dart';
import 'package:bhk_artisan/Modules/controller/productscreencontroller.dart';
import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/Modules/screens/home_screen.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart' as orderstep;

class Homecontroller extends GetxController {
  final _api = ProductRepository();

  var screen = HomeScreen();

  var isProductGraph = true.obs;

  var sliderController = CarouselSliderController();
  CommonScreenController commonController = Get.find();
  ProductController productController = Get.put(ProductController());
  OrderController orderController = Get.put(OrderController());
  GetOrderController getOrderController = Get.put(GetOrderController());

  var greetings = "Good Morning".obs;

  var chartData = <Map<String, dynamic>>[
    {"month": "Jan", "sales": 12000, "unitsSold": 30},
    {"month": "Feb", "sales": 17000, "unitsSold": 40},
    {"month": "Mar", "sales": 18000, "unitsSold": 50},
    {"month": "Apr", "sales": 10000, "unitsSold": 20},
    {"month": "May", "sales": 21000, "unitsSold": 60},
    {"month": "Jun", "sales": 16000, "unitsSold": 45},
    {"month": "Jul", "sales": 25000, "unitsSold": 70},
    {"month": "Aug", "sales": 30000, "unitsSold": 80},
  ];

  String totalSales() {
    double total = calculateSales(chartData);
    return formatNumberIndian(total);
  }

  double calculateSales(List<Map<String, dynamic>> chartData) {
    return chartData.fold<double>(0, (sum, item) => sum + (item["sales"] as num).toDouble());
  }

  String formatNumberIndian(double number) {
    if (number >= 10000000) {
      return "${removeTrailingZero(number / 10000000)}Cr";
    } else if (number >= 100000) {
      return "${removeTrailingZero(number / 100000)}L";
    } else if (number >= 1000) {
      return "${removeTrailingZero(number / 1000)}K";
    } else {
      return removeTrailingZero(number);
    }
  }

  String removeTrailingZero(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }

  String getTodayOrdersCount(List<orderstep.Data> orders) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return orders.where((order) {
      if (order.createdAt == null) return false;

      final created = DateTime.parse(order.createdAt!);
      final createdDate = DateTime(created.year, created.month, created.day);

      return createdDate == today;
    }).length.toString();
  }

  int currentYear = DateTime.now().year;
  RxDouble scrollPosition = 0.0.obs;
  RxDouble maxScrollExtent = 0.0.obs;
  var dropdownmonth = 'Last 7 days'.obs;
  var dropdownsold = 'Product Sales'.obs;

  var scrollController = ScrollController().obs;

  List<String> daysfilter = ['Last 7 days', 'Last 30 days', 'Last 12 months', 'This week', 'This month', 'Year to date'];

  List<String> salesfilter = ['Product Sales', 'Units Sold'];

  void updateScrollPosition(double position, double maxExtent) {
    if (position == 0.0) {
      scrollPosition.value = scrollPosition.value + 10.0;
    }
    scrollPosition.value = position;
    maxScrollExtent.value = maxExtent;
  }

  void initState() {
    scrollPosition.value = 0;
    setGreeting();
    getProductApi("APPROVED", isLoader: getApprovedProductModel.value.data?.docs?.isEmpty ?? true ? true : false);
  }

  void setGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      greetings.value = "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      greetings.value = "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      greetings.value = "Good Evening";
    } else {
      greetings.value = "Good Night";
    }
  }

  @override
  void onInit() {
    super.onInit();
    bool isDialog = Get.arguments?['isDialog'] ?? false;

    scrollController.value.addListener(() {
      scrollPosition.value = scrollController.value.position.pixels;
      maxScrollExtent.value = scrollController.value.position.maxScrollExtent;
    });

    setGreeting();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isDialog) {
        screen.showSuccessDialog();
      }
    });
  }

  Future<void> dashboardRefresh() async {
    initState();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getApprovedProductModel = ProductListingModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setApprovedProductdata(ProductListingModel value) => getApprovedProductModel.value = value;

  Future<void> getProductApi(var status, {bool isLoader = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (isLoader) setRxRequestStatus(Status.LOADING);
      _api
          .getproductApi(status)
          .then((value) {
            if (isLoader) setRxRequestStatus(Status.COMPLETED);
            setApprovedProductdata(value);
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
