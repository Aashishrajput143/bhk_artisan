import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/updateprofilemodel.dart';

class UpdateProfileRepository {
  final _apiServices = NetworkApiServices();

  Future<UpdateProfileModel> updateProfileApi(var data, var path) async {
    dynamic response = await _apiServices.multiPartApi(
        data, AppUrl.updateprofile, path, "avatar");
    return UpdateProfileModel.fromJson(response);
  }
}
