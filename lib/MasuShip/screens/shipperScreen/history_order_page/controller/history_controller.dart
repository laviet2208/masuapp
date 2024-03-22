import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/un_complete_order_page.dart';

import '../history_order_childpage/complete_order_page/complete_order_page.dart';

class history_controller {
  static Widget get_history_widget(int index) {
    switch (index) {
      case 1 :
        return finalData.shipper_account.onlineStatus == 0 ? Container(alignment: Alignment.center, child: Text('Hãy check-in để xem đơn chưa hoàn thành', style: TextStyle(color: Colors.black, fontFamily: 'roboto'),),) : un_complete_order_page();
      case 2 :
        return complete_order_page();
      default:
        return Container();
    }
  }
}