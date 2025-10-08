import 'package:bhk_artisan/Modules/model/product_details_model.dart';
import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';
import '../model/add_product_model.dart';
import '../model/get_category_model.dart';
import '../model/get_subcategory_model.dart';

class ProductRepository {
  final _apiServices = NetworkApiServices();

  Future<GetCategoryModel> getcategoryApi(var page, var toPage) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getcategory}$page&pageSize=$toPage");
    return GetCategoryModel.fromJson(response);
  }

  Future<GetSubCategoryModel> getsubcategoryApi(cateId) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getsubcategory}$cateId");
    return GetSubCategoryModel.fromJson(response);
  }

  Future<GetSubCategoryModel> getallsubcategoryApi(var page, var toPage) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getallSubcategory}$page&pageSize=$toPage");
    return GetSubCategoryModel.fromJson(response);
  }

  Future<AddProductModel> addproductApi(var data, var path) async {
    dynamic response = await _apiServices.multiPartMediaApi(data, AppUrl.addproduct, path, "images");
    return AddProductModel.fromJson(response);
  }

  Future<ProductListingModel> getproductApi(var status) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getproductlisting}adminApprovalStatus=$status");
    return ProductListingModel.fromJson(response);
  }

  Future<ProductDetailsModel> getproductDetailsApi(var productId) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getproduct}$productId");
    return ProductDetailsModel.fromJson(response);
  }
}
