import 'package:bhk_artisan/Modules/model/login_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class SignupRepository {
  final _apiServices = NetworkApiServices();

  Future<LoginModel> signUpApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApiForFCM(data, AppUrl.register);
    return LoginModel.fromJson(response);
  }
}
