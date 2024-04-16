import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/express_order_ingredient/accept_wait_sub_fee_dialog.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/express_order_ingredient/accept_weather_sub_fee_dialog.dart';

class request_sub_fee_food_button extends StatelessWidget {
  final foodOrder order;
  const request_sub_fee_food_button({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            gradient: LinearGradient(
              colors: [Colors.yellow , Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
          ),
          child: Center(
            child: Text(
              'Yêu cầu phụ phí',
              style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 30,),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: (order.status == 'B' && order.weatherFee == 0) ? 50 : 0,
                          decoration: (order.status == 'B' && order.weatherFee == 0) ? BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow , Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                              'Phụ phí thời tiết',
                              style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return accept_weather_sub_fee_dialog(order: order);
                          },
                        );
                      },
                    ),

                    Container(height: (order.status == 'B') ? 20 : 0,),

                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: (order.status == 'D' && order.waitFee == 0) ? 50 : 0,
                          decoration: (order.status == 'D' && order.waitFee == 0) ? BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow , Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                              'Phụ phí chờ món',
                              style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return accept_wait_sub_fee_dialog(order: order);
                          },
                        );
                      },
                    ),

                    Container(height: 30,),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
