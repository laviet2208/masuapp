import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void toastMessage(String mes) {
  Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 244, 164, 84),
      textColor: Colors.white,
      fontSize: 14.0
  );
}