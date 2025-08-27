import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

import '../model/ordersmodel.dart';
import '../model/today_order_model.dart';

class OrderRepository {
  final _apiServices = NetworkApiServices();

  Future<GetOrdersModel> getorderApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.orders);
    return GetOrdersModel.fromJson(response);
  }

  Future<TodayOrdersModel> gettodayorderApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.todayorder);
    return TodayOrdersModel.fromJson(response);
  }
}
