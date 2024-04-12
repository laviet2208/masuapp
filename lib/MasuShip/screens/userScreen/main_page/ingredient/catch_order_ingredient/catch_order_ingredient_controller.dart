import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

class catch_order_ingredient_controller {
  static Future<bool> check_if_no_have_order() async {
    bool check = true;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('owner/id').equalTo(finalData.user_account.id).once().then((DatabaseEvent event) async {
      final dynamic orders = event.snapshot.value;
      if (orders != null) {
        await orders.forEach((key, value) {
          // đơn lái xe hộ
          if (value['orderList'] != null) {
            if (value['status'].toString() == 'UC') {
              check = false;
            }
          }

          // đơn gọi xe bình thường
          if (value['type'] == null && value['payer'] == null && value['shopList'] == null  && value['buyLocation'] == null) {
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
        // đơn lái xe hộ
        if (value['orderList'] != null) {
          if (value['status'].toString() == 'UC') {
            id = value['id'].toString();
          }
        }

        // đơn gọi xe bình thường
        if (value['type'] == null && value['payer'] == null && value['shopList'] == null) {
          if (value['status'].toString() == 'A' || value['status'].toString() == 'B' || value['status'].toString() == 'C') {
            id = value['id'].toString();
          }
        }
      });
    });
    return id;
  }

  static Future<int> get_un_complete_order_type(String id) async {
    int type = 1; // Gọi xe đã biết điểm đến
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").child(id).once().then((DatabaseEvent event) async {
      final dynamic orders = event.snapshot.value;
      if (double.parse(orders['locationGet']['longitude'].toString()) == 0) {
        type = 2; // Gọi xe tự chỉ đường
      }
      if (orders['orderList'] != null) {
        type = 3; // Gọi lái xe về hộ
      }
    });
    return type;
  }


}