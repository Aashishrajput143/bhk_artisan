import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

import '../model/salesgraphmodel.dart';

class SalesRepository {
  final _apiServices = NetworkApiServices();

  Future<SalesGraphModel> getsalesApi(var year) async {
    dynamic response = await _apiServices.getApi("${AppUrl.salesgraph}$year");
    return SalesGraphModel.fromJson(response);
  }
}
