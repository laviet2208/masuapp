import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_page/shipper_dashboard/dashboard_controller.dart';
import '../../../../Data/OrderData/catchOrder.dart';
import '../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../Data/otherData/utils.dart';

class shipper_dashboard_month extends StatefulWidget {
  const shipper_dashboard_month({super.key});

  @override
  State<shipper_dashboard_month> createState() => _shipper_dashboard_monthState();
}

class _shipper_dashboard_monthState extends State<shipper_dashboard_month> {
  List<CatchOrder> catch_order_list = [];
  List<foodOrder> food_order_list = [];
  List<requestBuyOrder> request_order_list = [];
  List<expressOrder> express_order_list = [];
  List<catchOrderType3> bike_order_list = [];


  Future<void> get_order_data() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('shipper/id').equalTo(finalData.shipper_account.id).once().then((DatabaseEvent event) {
      final dynamic orders = event.snapshot.value;
      catch_order_list.clear();
      food_order_list.clear();
      request_order_list.clear();
      express_order_list.clear();
      bike_order_list.clear();
      orders.forEach((key, value) {
        if (value['resCost'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          if (order.timeList[1].month == DateTime.now().month && order.timeList[1].year == DateTime.now().year) {
            food_order_list.add(order);
          }
        } else if (value['receiver'] != null) {
          expressOrder order = expressOrder.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            express_order_list.add(order);
          }
        } else if (value['motherOrder'] != null) {
          catchOrderType3 order = catchOrderType3.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            bike_order_list.add(order);
          }
        } else if (value['buyLocation'] != null) {
          requestBuyOrder order = requestBuyOrder.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            request_order_list.add(order);
          }
        } else {
          CatchOrder order = CatchOrder.fromJson(value);
          if (order.S2time.day == DateTime.now().day && order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            catch_order_list.add(order);
          }
        }
        setState(() {

        });
      });
    });
  }

  Duration get_all_time() {
    return dashboard_controller.total_time_of_catch_order(catch_order_list) + dashboard_controller.total_time_of_food_order(food_order_list) +
        dashboard_controller.total_time_of_catch_3_order(bike_order_list) + dashboard_controller.total_time_of_express_order(express_order_list) +
        dashboard_controller.total_time_of_request_order(request_order_list);
  }

  double get_total_income() {
    return dashboard_controller.get_total_catch_income(catch_order_list) + dashboard_controller.get_total_catch_3_income(bike_order_list) +
        dashboard_controller.get_total_express_income(express_order_list) + dashboard_controller.get_total_food_income(food_order_list) +
        dashboard_controller.get_total_request_income(request_order_list);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: get_usually_decoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 10,
            ),

            Container(
              height: 20,
              child: Row(
                children: [
                  Container(width: 15,),

                  Container(
                    width: 20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/image/dashboard1.png')
                        )
                    ),
                  ),

                  Container(width: 15,),

                  Container(
                    width: width - 170,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: AutoSizeText(
                        'Thống kê tháng này',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.yellow,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Làm mới',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      toastMessage('Đang tải dữ liệu');
                      await get_order_data();
                    },
                  )
                ],
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Đơn chở người : ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: catch_order_list.length.toString() + ' Đơn',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Đơn mua hộ : ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: request_order_list.length.toString() + ' Đơn',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Đơn đồ ăn : ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: food_order_list.length.toString() + ' Đơn',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Đơn express : ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: catch_order_list.length.toString() + ' Đơn',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 0.5,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Thời gian chạy đơn: ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: get_all_time().inHours.toString() + ' giờ, ' + get_all_time().inMinutes.remainder(60).toString() + ' phút',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 30, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Tổng thu nhập ngày: ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: getStringNumber(get_total_income()) + '.đ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
