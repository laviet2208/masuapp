import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/next_step_food_order/next_step_food_button.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/price_list_food.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/request_sub_fee_food_button.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/restaurant_location.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/shipper_main_screen.dart';

import '../../../../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../../../../Data/otherData/Tool.dart';
import '../../../../../../../Data/voucherData/Voucher.dart';

class view_un_food_order_detail extends StatefulWidget {
  final String id;
  const view_un_food_order_detail({super.key, required this.id});

  @override
  State<view_un_food_order_detail> createState() => _view_un_food_order_detailState();
}

class _view_un_food_order_detailState extends State<view_un_food_order_detail> {
  foodOrder order = foodOrder(
    id: generateID(25),
    locationSet: finalData.user_account.location,
    locationGet: finalData.user_account.location,
    cost: 0,
    owner: finalData.user_account,
    shipper: finalData.shipper_account,
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    productList: [],
    shopList: [],
    timeList: [],
    costFee: finalData.bikeCost,
    note: '',
    waitFee: 0,
    weatherFee: 0,
    pointFee: 0,
    resCost: finalData.restaurantcost,
  );

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = foodOrder.fromJson(orders);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: get_usually_decoration_gradient(),
            child: ListView(
              children: [
                Container(
                  width: width,
                  height: 50,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 60,
                        right: 60,
                        top: 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Quay về menu chính',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                fontFamily: 'muli',
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(height: 20,),

                restaurant_location(order: order),

                Container(height: 20,),

                price_list_food(order: order),

                Container(height: 20,),

                next_step_food_button(order: order),

                Container(height: 20,),

                request_sub_fee_food_button(order: order),

                Container(height: 20,),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
        return true;
      },
    );
  }
}
