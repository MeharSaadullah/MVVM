import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
  }

  static void fieldfocuschange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context)
        .requestFocus(nextFocus); // change focus from 1st to 2nd
  }

  static toastMessage(String message) {
    // Fluttertoast.showToast(msg: message);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(15),
          message: message,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          reverseAnimationCurve: Curves.bounceInOut,
          positionOffset: 20,
        )..show(context));
  }

  // 1 thing more is snackbar we can also use that
}
