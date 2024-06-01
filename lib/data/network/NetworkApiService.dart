import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart';

import 'package:mvvm/data/app_exception.dart';
import 'package:mvvm/data/network/BaseApiService.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final Response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));
      responseJson = returnResponse(Response); // response in braces
    } on SocketException {
      throw FetchDataException('No Iternet connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiRespinse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Iternet connection');

      return responseJson;
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);

        return responseJson;
      default:
        throw FetchDataException(
            'Error occured while communicating with server ' +
                ' with status code' +
                response.statusCode.toString());
    }
  }
}
