import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/modal/movies_modal.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewViewModal with ChangeNotifier {
  final _myrepo = HomeRepository();

  ApiResponse<MovieListModel> movielist = ApiResponse.loading();

  setmovielist(ApiResponse<MovieListModel> response) {
    movielist = response;
    notifyListeners();
  }

  Future<void> returnmovielist() async {
    setmovielist(ApiResponse.loading());

    _myrepo.fetchmovielist().then((value) {
      setmovielist(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(error.toString());
      setmovielist(ApiResponse.error(error.toString()));
    });
  }
}
