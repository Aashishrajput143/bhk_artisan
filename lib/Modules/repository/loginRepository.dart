import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/signUpModel.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<SignUpModel> logInApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.login);
    return SignUpModel.fromJson(response);
  }
}
