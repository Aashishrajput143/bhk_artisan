import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

import '../model/sales_graph_model.dart';

class SalesRepository {
  final _apiServices = NetworkApiServices();

  Future<SalesGraphModel> getsalesApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.salesgraph);
    return SalesGraphModel.fromJson(response);
  }
}
