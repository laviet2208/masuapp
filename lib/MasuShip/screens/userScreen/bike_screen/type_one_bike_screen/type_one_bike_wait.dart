import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/cancel_order_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_log_type_one_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/price_list_type_1_wait_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';
import '../../../../Data/OrderData/catchOrder.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/voucherData/Voucher.dart';

class type_one_bike_wait extends StatefulWidget {
  final String orderId;
  const type_one_bike_wait({super.key, required this.orderId});

  @override
  State<type_one_bike_wait> createState() => _type_one_bike_waitState();
}

class _type_one_bike_waitState extends State<type_one_bike_wait> {

  CatchOrder order = CatchOrder(
    id: generateID(25),
    locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    cost: 0,
    owner: finalData.user_account,
    shipper: finalData.shipper_account,
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    costFee: finalData.bikeCost,
    subFee: 0,
  );

  void get_catch_type_1_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.orderId).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = CatchOrder.fromJson(orders);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_catch_type_1_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button_in_wait(),

              Container(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 210,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              location_title(type: 'start'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  child: general_ingredient.get_location_text(order.locationSet.mainText + order.locationSet.secondaryText, Colors.black),
                                ),
                              ),

                              Container(
                                width: 30,
                              ),

                              location_title(type: 'end'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  child: general_ingredient.get_location_text(order.locationGet.mainText + order.locationGet.secondaryText, Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.location_on_outlined, title: 'Thông tin điểm đón, trả'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 280,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: order_log_type_one_ingredient(order: order,),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.signal_wifi_statusbar_null, title: 'Trạng thái đơn'),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 250,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: price_list_type_1_wait_ingredient(order: order,),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.money, title: 'Thông tin thanh toán'),
                      ),
                    ],
                  ),
                ),
              ),

              cancel_order_button(order: order),

              Container(height: 20,),
            ],
          ),
        ),

      ),
    );
  }
}
