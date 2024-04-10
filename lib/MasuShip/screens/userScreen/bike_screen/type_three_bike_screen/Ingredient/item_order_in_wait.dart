import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/cancel_order_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/general_info_order_type_3.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/price_list_order_type_3.dart';

import '../../../../../Data/otherData/Time.dart';
import '../../../../../Data/otherData/Tool.dart';

class item_order_in_wait extends StatefulWidget {
  final String id;
  final VoidCallback callback;
  const item_order_in_wait({super.key, required this.id, required this.callback});

  @override
  State<item_order_in_wait> createState() => _item_order_in_waitState();
}

class _item_order_in_waitState extends State<item_order_in_wait> {

  catchOrderType3 orderType3 = catchOrderType3(
      id: generateID(25),
      locationSet: finalData.shipper_account.location,
      locationGet: finalData.shipper_account.location,
      cost: 0,
      owner: finalData.user_account,
      shipper: finalData.shipper_account,
      status: 'A',
      voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 00, area: ''),
      S1time: getCurrentTime(),
      S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      costFee: finalData.bikeCost,
      subFee: 0,
      type: 1,
      motherOrder: ''
  );

  void get_child_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      orderType3 = catchOrderType3.fromJson(orders);
      widget.callback();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_child_order_data();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: (orderType3.status == 'E' || orderType3.status == 'E1') ? 0 : null,
          decoration: (orderType3.status == 'E' || orderType3.status == 'E1') ? null :BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // màu của shadow
                spreadRadius: 2, // bán kính của shadow
                blurRadius: 7, // độ mờ của shadow
                offset: Offset(0, 3), // vị trí của shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 10,),

              general_info_order_type_3(order: orderType3),

              Container(height: 8,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 0.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),

              Container(height: 8,),

              price_list_order_type_3(order: orderType3),

              Container(height: 10,),

              cancel_order_button(orderType3: orderType3),

              Container(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
