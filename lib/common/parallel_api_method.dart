class ParallelApiMethod {
  Future<List<T>> loadParallel<T>(List<Future<T> Function()> apiFunctions) async {
    final results = await Future.wait(apiFunctions.map((api) => api()));
    return results;
  }
}

// Future<void> productRefresh() async {
//   final results = await ParallelApiMethod().loadParallel<ProductListingModel?>([
//     () => getProductApi("APPROVED", isLoader: false),
//     () => getProductApi("PENDING", isLoader: false),
//     () => getProductApi("DISAPPROVED", isLoader: false),
//   ]);

//   print("results ===> $results"); 
//   // results is a List<ProductListingModel?> [approved, pending, disapproved]
// }


// Future<ProductListingModel?> getProductApi(var status, {bool isLoader = true}) async {
//   var connection = await CommonMethods.checkInternetConnectivity();
//   Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

//   if (connection == true) {
//     if (isLoader) setRxRequestStatus(Status.LOADING);
//     try {
//       final value = await _api.getproductApi(status);
//       if (isLoader) setRxRequestStatus(Status.COMPLETED);

//       if (status == "APPROVED") {
//         setApprovedProductdata(value);
//       } else if (status == "PENDING") {
//         setPendingProductdata(value);
//       } else if (status == "DISAPPROVED") {
//         setDisapprovedProductdata(value);
//       }

//       Utils.printLog("Response ${value.toString()}");
//       return value; // ✅ return the model
//     } catch (error, stackTrace) {
//       handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
//       return null;
//     }
//   } else {
//     CommonMethods.showToast(appStrings.weUnableCheckData);
//     return null;
//   }
// }

