import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bhk_artisan/Modules/controller/logincontroller.dart';
import 'package:bhk_artisan/Modules/screens/login_screen.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../common/common_constants.dart';

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {

  bool refresh = true;

  bool isRefreshing = false;

  Future<void> refreshTokenAndRetry(String url) async {
    if (isRefreshing) {
      return;
    }
    isRefreshing = true;
    try {
      String refreshToken = await Utils.getPreferenceValues(Constants.refreshToken) ?? "";
      String accessToken = await Utils.getPreferenceValues(Constants.accessToken) ?? "";
      if (refreshToken.isEmpty || accessToken.isEmpty) {
        throw AuthenticationException("Refresh token or access token is missing ${refreshToken.isEmpty} ${accessToken.isEmpty}");
      }
      Utils.printLog("Refresh Token API URL: $url");
      Map<String, dynamic> data = {
        "refreshToken": refreshToken,
        "accessToken": accessToken,
      };
      Utils.printLog("Refresh Token API Request Body: $data");
      String jsonBody = jsonEncode(data);
      Utils.printLog("Final JSON Body: $jsonBody");
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'accesstoken': accessToken,
              'Content-Type': 'application/json',
            },
            body: jsonBody,
          )
          .timeout(const Duration(seconds: 600));
      Utils.printLog("Refresh Token API Response: ${response.body}");
      if (response.statusCode == 200) {
        var responseJson;
        try {
          responseJson = jsonDecode(response.body);
        } catch (e) {
          throw FormatException("Failed to parse response JSON: $e");
        }
        var data = responseJson['data'];
        if (data != null && data.containsKey('accessToken')) {
          String newAccessToken = data['accessToken'];
          Utils.savePreferenceValues(Constants.accessToken, newAccessToken);
          refresh = false;
        } else {
          throw Exception("Token refresh failed: 'accessToken' missing in response data");
        }
      } else {
        throw Exception("Token refresh failed: ${response.body}");
      }
    } catch (e) {
      Utils.printLog("Token refresh failed: $e");
      rethrow;
    } finally {
      isRefreshing = false;
    }
  }

  void expired(response) async {
    final decoded = json.decode(response.body);

    if (decoded is Map && decoded['statusCode'] == 463) {
      CommonMethods.showToast("Session expired. Please login again.");

      Utils.savePreferenceValues(Constants.accessToken, "");
      Utils.savePreferenceValues(Constants.email, "");
      await Utils.clearPreferenceValues();
      Get.delete<LoginController>();
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Future<dynamic> getApi(String url) async {
    Utils.printLog(url);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final response = await http.get(Uri.parse(url), headers: {'content-Type': 'application/json', 'accesstoken': token}).timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);

    return responseJson;
  }

  @override
  Future<dynamic> getApiWithParameter(var page, var status, var search, String url) async {
    Utils.printLog(url);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final uri = Uri.parse(url).replace(queryParameters: {'page': page, 'status': status, 'search': search});
      final response = await http.get(uri, headers: {'Accept': 'application/json', 'accesstoken': token}).timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);

    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    Utils.printLog(url);
    Utils.printLog(data);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Accept': 'application/json', 'accesstoken': token},
            body: data, //jsonEncode(data) //if raw form then we set jsonEncode if form the only data
          )
          .timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);
      Utils.printLog('Response: $response');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  Future putEncodeApi(data, String url) async {
    Utils.printLog(url);
    Utils.printLog(data);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: {'content-Type': "application/json", 'accesstoken': token},
            body: jsonEncode(data), //jsonEncode(data) //if raw form then we set jsonEncode if form the only data
          )
          .timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);

      Utils.printLog('Response: $response');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  Future deleteEncodeApi(String url) async {
    Utils.printLog(url);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final response = await http.delete(Uri.parse(url), headers: {'content-Type': "application/json", 'accesstoken': token}).timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);

      Utils.printLog('Response: $response');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException(response.body);
      case 401:
        throw AuthenticationException(response.body);
      case 408:
        throw FetchDataException(response.body);
      case 409:
        throw FetchDataException(response.body);
      case 502:
        throw FetchDataException('Server error: 502 Bad Gateway. Please try again later.');
      case 503:
        throw FetchDataException('Server unavailable: 503 Service Unavailable. Please try again later.');
      case 504:
        throw FetchDataException('Server timeout: 504 Gateway Timeout. Please try again later.');
      default:
        // Handle all other 5xx errors
        if (response.statusCode >= 500 && response.statusCode < 600) {
          throw FetchDataException('Server error: ${response.statusCode}. Please try again later.');
        }
        throw FetchDataException(' ${response.body}');
    }
  }

  Future<dynamic> multiPartImageOnlyApi(String url, List<String> imagePaths, String key) async {
    Utils.printLog(url);
    Utils.printLog(imagePaths);

    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers['accesstoken'] = token;

      if (imagePaths.isNotEmpty) {
        final files = await Future.wait(imagePaths.map((path) => http.MultipartFile.fromPath(key, path)));
        request.files.addAll(files);
      }

      final response = await request.send();
      final responseHttp = await http.Response.fromStream(response);

      expired(responseHttp);
      responseJson = returnResponse(responseHttp);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }

    Utils.printLog(responseJson);
    return responseJson;
  }

  Future<dynamic> multiPartMediaApi(var data, String url, List<String>? imagePaths, var key) async {
    Utils.printLog(url);
    Utils.printLog(data);
    Utils.printLog(imagePaths);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields.addAll(data);
      request.headers['accesstoken'] = token;

      if (imagePaths != null && imagePaths.isNotEmpty) {
        final files = await Future.wait(imagePaths.map((path) => http.MultipartFile.fromPath(key, path)));
        request.files.addAll(files);
      }
      final response = await request.send();
      final responseHttp = await http.Response.fromStream(response);
      expired(responseHttp);
      responseJson = returnResponse(responseHttp);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> multiPartApi(var data, String url, String? path, var keys) async {
    Utils.printLog(url);
    Utils.printLog(data);
    Utils.printLog(path);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields.addAll(data);
      request.headers['accesstoken'] = token;
      if (path != null) {
        request.files.add(await http.MultipartFile.fromPath(keys, path));
      }
      final response = await request.send();
      final responseHttp = await http.Response.fromStream(response);
      expired(responseHttp);
      responseJson = returnResponse(responseHttp);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  @override
  Future postEncodeApi(data, String url) async {
    Utils.printLog(url);
    Utils.printLog(data);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'content-Type': "application/json", 'accesstoken': token},
            body: jsonEncode(data), //jsonEncode(data) //if raw form then we set jsonEncode if form the only data
          )
          .timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);

      Utils.printLog('Response: $response');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  Future postEncodeApiForFCM(data, String url) async {
    Utils.printLog(url);
    Utils.printLog(data);
    dynamic responseJson;
    String token = await Utils.getPreferenceValues(Constants.accessToken) ?? "";

    try {
      final response = await http.post(Uri.parse(url), headers: {'content-Type': "application/json", 'accesstoken': token, 'devicetype': "ANDROID"}, body: jsonEncode(data)).timeout(const Duration(seconds: 600));
      expired(response);
      responseJson = returnResponse(response);
      Utils.printLog('Response: $response');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    Utils.printLog(responseJson);
    return responseJson;
  }

  Future<bool> uploadFileToS3WithPresignedUrl(String path, String presignedUrl) async {
    Utils.printLog("Presigned URL: $presignedUrl");
    Utils.printLog("Uploading file: $path");

    bool isUploaded = false;

    try {
      final file = File(path);

      final bytes = await file.readAsBytes();
      final response = await http.put(Uri.parse(presignedUrl), body: bytes, headers: {"Content-Type": "video/mp4", "x-amz-server-side-encryption": "AES256"});

      if (response.statusCode == 200) {
        Utils.printLog("✅ Upload successful");
        isUploaded = true;
      } else {
        Utils.printLog("❌ Upload failed: ${response.statusCode}");
        throw Exception("Upload failed with status: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on DioException catch (e) {
      Utils.printLog("Dio error: ${e.message}");
      throw UploadFailedException(e.message ?? "Upload failed");
    } on UnauthorizedException {
      throw AuthenticationException('');
    } catch (e) {
      Utils.printLog("Unexpected error: $e");
      throw Exception("Unexpected error: $e");
    }

    return isUploaded;
  }
}
