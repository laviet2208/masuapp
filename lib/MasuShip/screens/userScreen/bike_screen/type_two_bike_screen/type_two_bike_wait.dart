import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/type_two_bike_ingredient/cancel_catch_type_2_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import '../../../../Data/OrderData/catchOrder.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../general/title_gradient_container.dart';
import '../../main_screen/user_main_screen.dart';
import '../type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import '../type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import '../type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_log_type_one_ingredient.dart';
import 'type_two_bike_ingredient/price_list_type_2_wait_ingredient.dart';

class type_two_bike_wait extends StatefulWidget {
  final String orderId;
  const type_two_bike_wait({super.key, required this.orderId});

  @override
  State<type_two_bike_wait> createState() => _type_two_bike_waitState();
}

class _type_two_bike_waitState extends State<type_two_bike_wait> {
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
    costFee: finalData.bikeShipCost,
    subFee: 0,
  );

  void get_catch_type_2_data() {
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
    get_catch_type_2_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button_in_wait(),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 150,
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
                                  child: general_ingredient.get_location_text(order.locationSet.mainText + ',' + order.locationSet.secondaryText, Colors.black),
                                ),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.location_on_outlined, title: 'Thông tin điểm đón khách'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 150,
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

                              location_title(type: 'end'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  child: general_ingredient.get_location_text(order.locationGet.longitude == 0 ? 'Điểm đến sẽ hiển thị khi bạn đến nơi' : (order.locationGet.mainText + ',' + order.locationGet.secondaryText), Colors.black),
                                ),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.my_location, title: 'Thông tin điểm trả khách'),
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
                        bottom: 0,
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

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: price_list_type_2_wait_ingredient(order: order),
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

              Container(height: 20,),

              cancel_catch_type_2_button(order: order),

              Container(height: 20,),
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
