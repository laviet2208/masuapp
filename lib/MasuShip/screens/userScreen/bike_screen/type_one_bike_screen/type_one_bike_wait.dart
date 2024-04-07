import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/cancel_order_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_future_builder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_log_type_one_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/price_list_type_1_wait_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';

class type_one_bike_wait extends StatefulWidget {
  final String orderId;
  const type_one_bike_wait({super.key, required this.orderId});

  @override
  State<type_one_bike_wait> createState() => _type_one_bike_waitState();
}

class _type_one_bike_waitState extends State<type_one_bike_wait> {
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
                  height: 250,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
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
                                  child: location_future_builder(futureFunc: type_one_wait_controller.get_un_complete_order_data(widget.orderId), type: 'start',),
                                ),
                              ),

                              Container(
                                width: 30,
                              ),

                              location_title(type: 'end'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  child: location_future_builder(futureFunc: type_one_wait_controller.get_un_complete_order_data(widget.orderId), type: 'end',),
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
                        child: title_gradient_container(icon: Icons.location_on_outlined, title: 'Thông tin điểm đón, trả'),
                      ),
                    ],
                  ),
                ),
              ),

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
                        child: order_log_type_one_ingredient(id: widget.orderId, beforeWidget: user_main_screen(),),
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
                        child: price_list_type_1_wait_ingredient(id: widget.orderId),
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

              cancel_order_button(id: widget.orderId),

              Container(height: 20,),
            ],
          ),
        ),

      ),
    );
  }
}
