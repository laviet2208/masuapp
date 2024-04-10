import 'package:firebase_database/firebase_database.dart';
import '../../../../../../../../Data/OrderData/catchOrder.dart';

class un_complete_catch_type_2_controller {
  static Stream<CatchOrder> getUnCompleteOrderDataStream(String id) {
    final reference = FirebaseDatabase.instance.reference();
    return reference.child('Order').child(id).onValue.map((event) {
      final dynamic order = event.snapshot.value;
      return CatchOrder.fromJson(order);
    });
  }
}