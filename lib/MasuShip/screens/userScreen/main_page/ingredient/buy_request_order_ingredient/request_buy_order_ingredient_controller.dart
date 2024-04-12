import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

class request_buy_order_ingredient_controller {
  static Future<bool> check_if_no_have_order() async {
    bool check = true;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('owner/id').equalTo(finalData.user_account.id).once().then((DatabaseEvent event) async {
      final dynamic orders = event.snapshot.value;
      if (orders != null) {
        await orders.forEach((key, value) {
          // đơn mua hộ
          if (value['buyLocation'] != null) {
            if (value['status'].toString() == 'A' || value['status'].toString() == 'B' || value['status'].toString() == 'C') {
              check = false;
            }
          }
        });
      }

    });
    return check;
  }

  static Future<String> get_un_complete_order_id() async {
    String id = '';
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('owner/id').equalTo(finalData.user_account.id).once().then((DatabaseEvent event) async {
      final dynamic orders = event.snapshot.value;
      await orders.forEach((key, value) {
        // đơn mua hộ
        if (value['buyLocation'] != null) {
          if (value['status'].toString() == 'A' || value['status'].toString() == 'B' || value['status'].toString() == 'C') {
            id = value['id'].toString();
          }
        }
      });
    });
    return id;
  }
}