import 'package:bhk_artisan/Modules/model/get_all_logistics_model.dart';
import 'package:bhk_artisan/Modules/model/get_logistics_details_model.dart';
import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

class LogisticsRepository {
  final _apiServices = NetworkApiServices();

  Future<GetAllLogisticsModel> getAllLogisticsApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getAllLogistics);
    return GetAllLogisticsModel.fromJson(response);
  }

  Future<GetLogisticsDetailsModel> getLogisticsDetailsApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getAllLogistics}$id");
    return GetLogisticsDetailsModel.fromJson(response);
  }
}
