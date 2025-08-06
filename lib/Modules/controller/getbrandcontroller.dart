import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getbrandModel.dart';
import '../repository/brandrepository.dart';

class GetBrandController extends GetxController {
  final repository = BrandRepository();

  final scrollController = ScrollController().obs;
  var brandList = List<Docs>.empty(growable: true);

  var page = 1.obs;
  var isMoreDataAvailable = false.obs;

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final getBrandModel = GetBrandModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setGetbranddata(GetBrandModel value) => getBrandModel.value = value;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getBrandApi();
  }

  void paginateTask() {
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        isMoreDataAvailable.value = true;
        page++;
        getMoreData();
        Utils.printLog("increase page number $page");
      }
    });
  }

  Future<void> brandRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    getBrandApi();
    print("items.length");
  }

  Future<void> getBrandApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getbrandApi(page.toString()).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetbranddata(value);
        brandList.clear();
        brandList.addAll(getBrandModel.value.data?.docs ?? []);
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
        Utils.printLog("Error===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getMoreData() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      isMoreDataAvailable.value = true;

      repository.getbrandApi(page.toString()).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetbranddata(value);
        if (getBrandModel.value.data?.docs?.isNotEmpty ?? false) {
          print(page);
          brandList.addAll(getBrandModel.value.data?.docs ?? []);
          isMoreDataAvailable.value = false;
        } else {
          page--;
          isMoreDataAvailable.value = false;
        }

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
