import 'package:bhk_artisan/Modules/model/update_profile_model.dart';
import 'package:bhk_artisan/data/app_url/app_url.dart';
import 'package:bhk_artisan/data/network/network_api_services.dart';
import '../model/get_profile_model.dart';

class ProfileRepository {
  final _apiServices = NetworkApiServices();

  Future<GetProfileModel> getprofileApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.loggedinuser);
    return GetProfileModel.fromJson(response);
  }

  Future<UpdateProfileModel> updateProfileApi(var data, var path) async {
    dynamic response = await _apiServices.multiPartApi(data, AppUrl.updateprofile, path, "avatar");
    return UpdateProfileModel.fromJson(response);
  }
}
