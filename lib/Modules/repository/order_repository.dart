import 'package:bhk_artisan/Modules/model/add_product_model.dart';
import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/Modules/model/order_details_model.dart';
import 'package:bhk_artisan/Modules/model/update_order_status_model.dart';
import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

class OrderRepository {
  final _apiServices = NetworkApiServices();

  Future<GetAllOrderStepsModel> getAllOrderStepApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.allorders);
    return GetAllOrderStepsModel.fromJson(response);
  }

  Future<OrderDetailsModel> orderDetailsApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.ordersDetails}$id");
    return OrderDetailsModel.fromJson(response);
  }

  Future<UpdateOrderStatusModel> updateOrderStatusApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.orderStatus);
    return UpdateOrderStatusModel.fromJson(response);
  }

  Future<UpdateOrderStatusModel> updatePickupAddressStatusApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.pickupAddress);
    return UpdateOrderStatusModel.fromJson(response);
  }

  Future<UpdateOrderStatusModel> updateOrderProgressApi(var data, var id) async {
    dynamic response = await _apiServices.putEncodeApi(data, "${AppUrl.orderStatus}$id/progress");
    return UpdateOrderStatusModel.fromJson(response);
  }

  Future<AddProductModel> updateOrderImageApi(var data, var path, var id) async {
    dynamic response = await _apiServices.multiPartMediaApi(data, "${AppUrl.completeOrder}$id", path, "work_images");
    return AddProductModel.fromJson(response);
  }
}
