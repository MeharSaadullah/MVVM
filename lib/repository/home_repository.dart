import 'package:mvvm/data/network/BaseApiService.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/modal/movies_modal.dart';
import 'package:mvvm/resources/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchmovielist() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrl.movieapiurl,
      );
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw (e);
    }
  }
}
