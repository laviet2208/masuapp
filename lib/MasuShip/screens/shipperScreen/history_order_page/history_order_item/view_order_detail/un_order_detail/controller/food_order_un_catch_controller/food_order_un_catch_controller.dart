import 'package:firebase_database/firebase_database.dart';
import '../../../../../../../../Data/OrderData/foodOrder/foodOrder.dart';

class food_order_un_catch_controller {
  static Future<void> push_food_order_data(foodOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }
}