import 'package:mvvm/data/network/BaseApiService.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/resources/app_url.dart';

class AuthRespository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrl.loginUrl,
      );
      return response;
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiRespinse(AppUrl.loginUrl, data);

      return response;
    } catch (e) {
      throw (e);
    }
  }
}
