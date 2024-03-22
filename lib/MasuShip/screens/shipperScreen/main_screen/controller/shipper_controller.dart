import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_page/main_page.dart';

import '../../../../../GENERAL/utils/utils.dart';
import '../../account_page/account_page.dart';
import '../../history_order_page/history_order_page.dart';

class shipper_controller {
  static Widget getBodyWidget(int index) {
    switch (index) {
      case 0 :
        return main_page();
      case 1 :
        return history_order_page();
      case 3:
        return account_page();
      default:
        return Container();
    }
  }
}