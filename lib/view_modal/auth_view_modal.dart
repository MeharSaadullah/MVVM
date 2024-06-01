import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/modal/user_modal.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/routes/utils.dart';
import 'package:mvvm/view_modal/user_view_modal.dart';
import 'package:provider/provider.dart';

class AuthViewModal with ChangeNotifier {
  final _myRepo = AuthRespository();

  bool _loading = false; // loading for log in button
  bool get loading => _loading;

  bool _signuploading = false;
  bool get signuploading => _signuploading; // loading for sign up button

  setsignupLoading(bool vlaue) {
    _signuploading = vlaue;
    notifyListeners();
  }

  setLoading(bool vlaue) {
    _loading = vlaue;
    notifyListeners();
  }

  Future<dynamic> authloginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPrefrences = Provider.of<UserViewModal>(context, listen: false);
      userPrefrences.saveUser(UserModal(
        token: value['token'].toString(),
      ));

      Utils.flushBarErrorMessage('login successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<dynamic> signupApi(dynamic data, BuildContext context) async {
    setsignupLoading(true);
    _myRepo.signupApi(data).then((value) {
      setsignupLoading(false);
      Utils.flushBarErrorMessage('Signup successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setsignupLoading(false);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
