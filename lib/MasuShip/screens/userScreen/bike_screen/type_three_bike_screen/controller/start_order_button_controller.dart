import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/motherOrder.dart';

import '../../../../../Data/locationData/Location.dart';

class start_order_button_controller {
  static bool check_if_fill_all_infomation(List<Location> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].longitude == 0 && list[i].latitude == 0) {
        return false;
      }
    }
    return true;
  }

  static Future<void> push_mother_order_data(motherOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> push_child_order_data(catchOrderType3 order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }
}