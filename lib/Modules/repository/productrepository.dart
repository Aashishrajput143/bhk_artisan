import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';
import '../model/addproductmediamodel.dart';
import '../model/addproductmodel.dart';
import '../model/getbrandModel.dart';
import '../model/getcategorymodel.dart';
import '../model/getproductmodel.dart';
import '../model/getstoremodel.dart';
import '../model/getsubcategorymodel.dart';
import '../model/productdetailsmodel.dart';

class ProductRepository {
  final _apiServices = NetworkApiServices();

  Future<GetCategoryModel> getcategoryApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getcategory);
    return GetCategoryModel.fromJson(response);
  }

  Future<GetSubCategoryModel> getsubcategoryApi(cateId) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getsubcategory}$cateId");
    return GetSubCategoryModel.fromJson(response);
  }

  Future<GetBrandModel> getbrandApi(var page) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getbrand}$page&pageSize=20");
    return GetBrandModel.fromJson(response);
  }

  Future<GetStoreModel> getstoreApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getstore);
    return GetStoreModel.fromJson(response);
  }

  Future<AddProductModel> addproductApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.addproduct);
    return AddProductModel.fromJson(response);
  }

  Future<AddProductMediaModel> addproductmediaApi(
      var data, List<String> paths, List<String> keys) async {
    dynamic response = await _apiServices.multiPartMediaApi(
        data, AppUrl.addproductmedia, paths, keys);
    return AddProductMediaModel.fromJson(response);
  }

  Future<GetProductModel> getproductApi() async {
    dynamic response = await _apiServices.getApi(
        "${AppUrl.getproductlisting}?product_status=AVAILABLE&isSeller=true");
    return GetProductModel.fromJson(response);
  }

  Future<GetProductModel> getTrendingproductApi() async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getproductlisting}?isSeller=true");
    return GetProductModel.fromJson(response);
  }

  Future<GetProductModel> getpendingproductApi() async {
    dynamic response = await _apiServices.getApi(
        "${AppUrl.getproductlisting}?product_status=DRAFT&isSeller=true&admin_approval_status=Pending");
    return GetProductModel.fromJson(response);
  }

  Future<ProductDetailsModel> getproductdetailsApi(productId) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getproduct}$productId");
    return ProductDetailsModel.fromJson(response);
  }
}
