import 'package:bhk_artisan/Modules/model/add_address_model.dart';
import 'package:bhk_artisan/Modules/model/get_address_model.dart';
import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';

class AddressRepository {
  final _apiServices = NetworkApiServices();

  Future<AddAddressModel> addAddressApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data,AppUrl.addAddress);
    return AddAddressModel.fromJson(response);
  }

  Future<AddAddressModel> editAddressApi(var data,var id) async {
    dynamic response = await _apiServices.putEncodeApi(data,"${AppUrl.editAddress}$id");
    return AddAddressModel.fromJson(response);
  }

  Future<GetAddressModel> getAddressApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getAddress);
    return GetAddressModel.fromJson(response);
  }

  Future<AddAddressModel> deleteAddressApi(var id) async {
    dynamic response = await _apiServices.deleteEncodeApi("${AppUrl.deleteAddress}$id");
    return AddAddressModel.fromJson(response);
  }
}
