

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/verify_otp_model.dart';

class OtpRepository {
  final _apiServices = NetworkApiServices();
  Future<VerifyOTPModel> verifyOtpApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.verifyOtp);
    return VerifyOTPModel.fromJson(response);
  }
}