import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/signUpModel.dart';

class SignupRepository {
  final _apiServices = NetworkApiServices();

  Future<SignUpModel> signUpApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApiForFCM(data, AppUrl.register);
    return SignUpModel.fromJson(response);
  }
}
