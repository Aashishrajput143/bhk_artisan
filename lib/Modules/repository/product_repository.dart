import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';
import '../model/add_product_model.dart';
import '../model/get_category_model.dart';
import '../model/getproductmodel.dart';
import '../model/get_subcategory_model.dart';
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

  Future<AddProductModel> addproductApi(var data, var path) async {
    dynamic response = await _apiServices.multiPartMediaApi(data, AppUrl.addproduct, path, "images");
    return AddProductModel.fromJson(response);
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
