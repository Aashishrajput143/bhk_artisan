import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getstoremodel.dart';
import '../repository/storerepository.dart';

class GetStoreController extends GetxController {
  final repository = StoreRepository();

  final scrollController = ScrollController().obs;
  var StoreList = List<Docs>.empty(growable: true);

  var page = 1.obs;
  var isMoreDataAvailable = false.obs;

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final getStoreModel = GetStoreModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setgetstoredata(GetStoreModel value) => getStoreModel.value = value;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //getStoreApi();
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

  Future<void> storeRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    //getStoreApi();
    print("items.length");
  }

  Future<void> getStoreApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getstoreApi(page.toString()).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetstoredata(value);
        StoreList.clear();
        StoreList.addAll(getStoreModel.value.data?.docs ?? []);
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

      repository.getstoreApi(page.toString()).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetstoredata(value);
        if (getStoreModel.value.data?.docs?.isNotEmpty ?? false) {
          print(page);
          StoreList.addAll(getStoreModel.value.data?.docs ?? []);
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
