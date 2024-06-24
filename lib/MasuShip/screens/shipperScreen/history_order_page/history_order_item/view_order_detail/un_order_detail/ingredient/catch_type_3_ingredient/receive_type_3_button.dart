import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_1_controller/receive_button_controller.dart';
import '../../../../../../../../Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/controller/general_controller.dart';

class receive_type_3_button extends StatefulWidget {
  final catchOrderType3 order;
  const receive_type_3_button({super.key, required this.order,});

  @override
  State<receive_type_3_button> createState() => _receive_type_3_buttonState();
}

class _receive_type_3_buttonState extends State<receive_type_3_button> {
  bool loading = false;
  String status_text_button = "";

  Future<motherOrder> getData(String id) async {
    motherOrder orderm = motherOrder(id: '', locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), createTime: getCurrentTime(), orderList: []);
    final reference = FirebaseDatabase.instance.reference();
    final snapshot = await reference.child("Order").child(id).once();
    final dynamic data = snapshot.snapshot.value;
    if (data != null) {
      orderm = motherOrder.fromJson(data);
      print(orderm.toJson().toString());
    }
    return orderm;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.status == 'B') {
      status_text_button = 'Đã đón khách';
    }
    if (widget.order.status == 'C') {
      status_text_button = 'Đã hoàn thành';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: (widget.order.status == 'B' || widget.order.status == 'C') ? 45 : 0,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(5)
          ),
          alignment: Alignment.center,
          child: Text(
            widget.order.status == 'B' ? 'Đã đón được khách' : 'Đã đưa khách tới nơi',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      onTap: () async {
        if (widget.order.status == 'B') {
          receive_button_controller.B_status_event(widget.order, context,);
        } else if (widget.order.status == 'C') {
          receive_button_controller.C_status_event(widget.order, context,);
          motherOrder order = await getData(widget.order.motherOrder);
          print(order.toJson().toString());
          if (await general_controller.check_if_complete_all_order(order)) {
            final reference = FirebaseDatabase.instance.reference();
            order.status = 'CP';
            await reference.child('Order').child(order.id).set(order.toJson());
          }
        }
      },
    );
  }
}
