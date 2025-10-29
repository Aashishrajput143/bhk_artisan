import 'package:bhk_artisan/Modules/model/get_all_logistics_model.dart';
import 'package:bhk_artisan/Modules/repository/logistics_repository.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:get/get.dart';
import 'common_screen_controller.dart';

class LogisticsListController extends GetxController {
  final _api = LogisticsRepository();
  
  CommonScreenController commonController = Get.find();
  final rxRequestStatus = Status.COMPLETED.obs;

  String getFullAddress(Docs? address) {
    List<String> parts = [];

    void addIfNotEmpty(String? value) {
      if (value != null && value.trim().isNotEmpty) {
        parts.add(value.trim());
      }
    }

    addIfNotEmpty(address?.pickupAddress?.houseNo);
    addIfNotEmpty(address?.pickupAddress?.street);
    addIfNotEmpty(address?.pickupAddress?.landmark);
    addIfNotEmpty(address?.pickupAddress?.city);
    addIfNotEmpty(address?.pickupAddress?.state);
    addIfNotEmpty(address?.pickupAddress?.postalCode);
    addIfNotEmpty(address?.pickupAddress?.country);

    return parts.join(", ");
  }

  final logisticsModel = GetAllLogisticsModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setLogisticsdata(GetAllLogisticsModel value) => logisticsModel.value = value;

  @override
  void onInit() {
    super.onInit();
    getAllLogisticsApi();
  }

  Future<void> getAllLogisticsApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      _api.getAllLogisticsApi().then((value) {
        setLogisticsdata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
      }).onError((error, stackTrace) {
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
}
