import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/item_order_in_wait.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../main_screen/user_main_screen.dart';

class type_three_bike_wait extends StatefulWidget {
  final String id;
  const type_three_bike_wait({super.key, required this.id});

  @override
  State<type_three_bike_wait> createState() => _type_three_bike_waitState();
}

class _type_three_bike_waitState extends State<type_three_bike_wait> {

  motherOrder order = motherOrder(id: '', locationSet: finalData.shipper_account.location, locationGet: finalData.shipper_account.location, cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: 'N', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), orderList: [], createTime: getCurrentTime());

  void get_mother_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = motherOrder.fromJson(orders);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_mother_order_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button_in_wait(),

              Container(height: 20,),

              Container(
                child: ListView.builder(
                  itemCount: order.orderList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        item_order_in_wait(id: order.orderList[index], callback: () {setState(() {});}, order: order,),

                        Container(height: 20,)
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return true;
      },
    );
  }
}
