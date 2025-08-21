import 'package:bhk_artisan/Modules/model/login_model.dart';
import 'package:bhk_artisan/Modules/model/logout_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<LoginModel> logInApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.login);
    return LoginModel.fromJson(response);
  }

  Future<LogoutModel> logoutApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.logout);
    return LogoutModel.fromJson(response);
  }
}
