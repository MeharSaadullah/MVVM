import 'package:flutter/material.dart';
import 'package:mvvm/modal/user_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModal with ChangeNotifier {
  Future<bool> saveUser(UserModal user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('token', user.token.toString());
    notifyListeners();

    return true;
  }

  Future<UserModal> getuser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return UserModal(token: token.toString());
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
