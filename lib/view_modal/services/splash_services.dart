import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/modal/user_modal.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_modal/user_view_modal.dart';

class Splashservices {
  Future<UserModal> getUserData() => UserViewModal().getuser();

  void CheckAuthntication(BuildContext context) async {
    getUserData().then((value) async {
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(Duration(seconds: 5));

        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 5));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
