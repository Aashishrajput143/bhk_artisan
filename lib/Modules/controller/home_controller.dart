import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/controller/orderscreencontroller.dart';
import 'package:bhk_artisan/Modules/controller/productscreencontroller.dart';
import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/Modules/screens/dashboardManagement/home_screen.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  final _api = ProductRepository();

  var screen = HomeScreen();

  var sliderController = CarouselSliderController();
  CommonScreenController commonController = Get.find();
  ProductController productController = Get.put(ProductController());
  OrderController orderController = Get.put(OrderController());
  GetOrderController getOrderController = Get.put(GetOrderController());

  var greetings = "Good Morning".obs;

  var chartData = <Map<String, dynamic>>[
    {"month": "Jan", "sales": 120},
    {"month": "Feb", "sales": 150},
    {"month": "Mar", "sales": 180},
    {"month": "Apr", "sales": 100},
    {"month": "May", "sales": 210},
    {"month": "Jun", "sales": 160},
    {"month": "Jul", "sales": 250},
    {"month": "Aug", "sales": 300},
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

  void initState(){
    setGreeting();
    getProductApi("APPROVED", isLoader:getApprovedProductModel.value.data?.docs?.isEmpty ?? true? true : false);
  }

  void setGreeting() {
    String time = DateTime.now().toString();
    time = time.split(" ")[1].toString();
    time = time.split(".")[0].toString();
    DateTime timeNow = DateTime.parse("2000-01-01 $time");
    DateTime morningStart = DateTime.parse("2000-01-01 05:00:00");
    DateTime morningEnd = DateTime.parse("2000-01-01 11:59:59");
    DateTime afternoonStart = DateTime.parse("2000-01-01 12:00:00");
    DateTime afternoonEnd = DateTime.parse("2000-01-01 16:59:59");
    DateTime eveningStart = DateTime.parse("2000-01-01 17:00:00");
    DateTime eveningEnd = DateTime.parse("2000-01-01 20:59:59");
    if (timeNow.isAfter(morningStart) && timeNow.isBefore(morningEnd)) {
      greetings.value = "Good Morning";
    } else if (timeNow.isAfter(afternoonStart) && timeNow.isBefore(afternoonEnd)) {
      greetings.value = "Good Afternoon";
    } else if (timeNow.isAfter(eveningStart) && timeNow.isBefore(eveningEnd)) {
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
