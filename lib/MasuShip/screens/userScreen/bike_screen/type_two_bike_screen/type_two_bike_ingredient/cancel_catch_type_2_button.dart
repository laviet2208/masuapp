import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import '../../../../../Data/accountData/shipperAccount.dart';
import '../../../../../Data/otherData/Tool.dart';
import '../../../../../Data/otherData/utils.dart';

class cancel_catch_type_2_button extends StatelessWidget {
  final CatchOrder order;
  const cancel_catch_type_2_button({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: type_one_wait_controller.check_if_can_cancel(order.status) ? 45 : 0,
          decoration: type_one_wait_controller.check_if_can_cancel(order.status) != 0 ?  BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // màu của shadow
                spreadRadius: 2, // bán kính của shadow
                blurRadius: 7, // độ mờ của shadow
                offset: Offset(0, 3), // vị trí của shadow
              ),
            ],
          ) : null,
          child: Center(
            child: Text(
              'Hủy đơn hàng',
              style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
      onTap: () async {
        DatabaseReference reference = FirebaseDatabase.instance.reference();
        if (order.status == 'B') {
          shipperAccount account = await type_one_wait_controller.get_shipper_account(order.shipper.id);
          account.orderHaveStatus = account.orderHaveStatus - 1;
          reference = FirebaseDatabase.instance.reference();
          await reference.child('Account').child(account.id).set(account.toJson());
        }
        order.status = 'E';
        order.S4time = getCurrentTime();
        reference = FirebaseDatabase.instance.reference();
        await reference.child('Order').child(order.id).set(order.toJson());
        toastMessage('Bạn đã hủy đơn thành công');
      },
    );
  }
}
