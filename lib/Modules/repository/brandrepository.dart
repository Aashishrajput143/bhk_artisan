import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

import '../model/addbrandmodel.dart';
import '../model/branddetailsmodel.dart';
import '../model/getbrandModel.dart';

class BrandRepository {
  final _apiServices = NetworkApiServices();

  Future<AddBrandModel> addbrandApi(var data, var path) async {
    dynamic response = await _apiServices.multiPartApi(
        data, AppUrl.addbrand, path, "brand_logo");
    return AddBrandModel.fromJson(response);
  }

  Future<GetBrandModel> getbrandApi(var page) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getbrand}$page&pageSize=20");
    return GetBrandModel.fromJson(response);
  }

  Future<GetBrandModel> getdashbrandApi(var page) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getbrand}$page&pageSize=10");
    return GetBrandModel.fromJson(response);
  }

  Future<BrandDetailsModel> getbranddetailsApi(brandId) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getbranddetails}$brandId");
    return BrandDetailsModel.fromJson(response);
  }
}
