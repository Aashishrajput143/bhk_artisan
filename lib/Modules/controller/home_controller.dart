import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/controller/order_screen_controller.dart';
import 'package:bhk_artisan/Modules/controller/product_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/Modules/model/sales_graph_model.dart';
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/Modules/repository/sales_repository.dart';
import 'package:bhk_artisan/Modules/screens/home_screen.dart';
import 'package:bhk_artisan/common/common_function.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/sales_type_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart' as orderstep;

class Homecontroller extends GetxController {
  final _api = ProductRepository();
  final salesRepository = SalesRepository();

  var screen = HomeScreen();
  var sliderController = CarouselSliderController();
  CommonScreenController commonController = Get.find();
  ProductController productController = Get.put(ProductController());
  OrderController orderController = Get.put(OrderController());
  GetOrderController getOrderController = Get.put(GetOrderController());

  var greetings = "Good Morning".obs;

  List<ChartData> get selectedFilterData {
    final filters = getSalesGraphModel.value.docs;
    if (filters == null || filters.isEmpty) return [];

    final filter = filters.firstWhere((e) =>dropdownmonth.value == SalesType.WEEKLY.displayName?e.filter == SalesType.WEEKLY.salesValue: e.filter == dropdownmonth.value, orElse: () => filters.first);

    return filter.data ?? [];
  }

  String totalSales() {
    double total = getSalesGraphModel.value.docs?.last.data?.isNotEmpty??false?(getSalesGraphModel.value.docs?.last.data?.last.sales??0).toDouble():0;
    return formatNumberIndian(total);
  }

  String getTodayOrdersCount(List<orderstep.Data> orders) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return orders
        .where((order) {
          if (order.artisianAssignedAt == null && order.createdAt == null) return false;

          final created = DateTime.parse(order.artisianAssignedAt??order.createdAt!);
          final createdDate = DateTime(created.year, created.month, created.day);

          return createdDate == today;
        })
        .length
        .toString();
  }

  int currentYear = DateTime.now().year;
  RxDouble scrollPosition = 0.0.obs;
  RxDouble maxScrollExtent = 0.0.obs;
  var dropdownmonth = SalesType.WEEKLY.displayName.obs;
  var dropdownsold = 'Product Sales'.obs;

  var scrollController = ScrollController().obs;

  List<String> daysfilter = [SalesType.WEEKLY.displayName, SalesType.MONTHLY.displayName, SalesType.YEARLY.displayName];

  List<String> salesfilter = ['Product Sales', 'Units Sold'];

  void updateScrollPosition(double position, double maxExtent) {
    if (position == 0.0) {
      scrollPosition.value = scrollPosition.value + 10.0;
    }
    scrollPosition.value = position;
    maxScrollExtent.value = maxExtent;
  }

  void initState() {
    commonController.getProfileApi();
    scrollPosition.value = 0;
    setGreeting();
    getSalesApi();
    getOrderController.getAllOrderStepApi();
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
    scrollController.value.addListener(() {
      scrollPosition.value = scrollController.value.position.pixels;
      maxScrollExtent.value = scrollController.value.position.maxScrollExtent;
    });

    setGreeting();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (commonController.isDialog.value) {
        screen.showSuccessDialog();
      }
    });
  }

  Future<void> dashboardRefresh() async {
    initState();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getApprovedProductModel = ProductListingModel().obs;
  final getSalesGraphModel = SalesGraphModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setApprovedProductdata(ProductListingModel value) => getApprovedProductModel.value = value;
  void setSalesGraphData(SalesGraphModel value) => getSalesGraphModel.value = value;

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

  Future<void> getSalesApi({bool isLoader = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (isLoader) setRxRequestStatus(Status.LOADING);
      salesRepository
          .getsalesApi()
          .then((value) {
            if (isLoader) setRxRequestStatus(Status.COMPLETED);
            setSalesGraphData(value);
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
