import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:get/get.dart';

class GetOrderController extends GetxController {
  final _api = OrderRepository();

  var isAccepted = List.generate(4, (_) => false.obs);
  var isDeclined = List.generate(4, (_) => false.obs);
  var hasData = false.obs;

  var index = 0.obs;

  Future<void> ordersRefresh() async {}

  @override
  void onInit() {
    super.onInit();
    getAllOrderStepApi();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAllOrderStepModel = GetAllOrderStepsModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAllOrderStepdata(GetAllOrderStepsModel value) => getAllOrderStepModel.value = value;

  Future<void> getAllOrderStepApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getAllOrderStepApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setAllOrderStepdata(value);
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
