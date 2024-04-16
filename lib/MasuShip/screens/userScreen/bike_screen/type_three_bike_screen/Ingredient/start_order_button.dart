import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/controller/general_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/controller/start_order_button_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_wait.dart';

import '../../../../../Data/locationData/Location.dart';

class start_order_button extends StatefulWidget {
  final Location startLocation;
  final List<Location> customerLocations;
  final List<Location> bikeLocations;
  final motherOrder order;
  const start_order_button({super.key, required this.startLocation, required this.customerLocations, required this.bikeLocations, required this.order});

  @override
  State<start_order_button> createState() => _start_order_buttonState();
}

class _start_order_buttonState extends State<start_order_button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
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
          ),
          child: Center(
            child: !loading ? Text(
              'Xác nhận đặt đơn',
              style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ) : CircularProgressIndicator(color: Colors.black,),
          ),
        ),
        onTap: () async {
          if (start_order_button_controller.check_if_fill_all_infomation(widget.customerLocations) && start_order_button_controller.check_if_fill_all_infomation(widget.bikeLocations)) {
            setState(() {
              loading = true;
            });
            List<catchOrderType3> custom_order_list = [];
            List<catchOrderType3> bike_order_list = [];
            //thêm đơn chở người
            for (int i = 0; i < widget.customerLocations.length; i++) {
              double money = await general_controller.getCost(widget.startLocation, widget.customerLocations[i]);
              catchOrderType3 orderType3 = catchOrderType3(
                  id: generateID(25),
                  locationSet: widget.startLocation,
                  locationGet: widget.customerLocations[i],
                  cost: money,
                  owner: finalData.user_account,
                  shipper: finalData.shipper_account,
                  status: 'A',
                  voucher: widget.order.voucher,
                  S1time: getCurrentTime(),
                  S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  costFee: finalData.bikeCost,
                  subFee: 0,
                  type: 1,
                  motherOrder: widget.order.id
              );
              custom_order_list.add(orderType3);
              widget.order.orderList.add(orderType3.id);
            }

            //thêm đơn lái xe hộ
            for (int i = 0; i < widget.bikeLocations.length; i++) {
              double money = await general_controller.getCost(widget.startLocation, widget.bikeLocations[i]);
              catchOrderType3 orderType3 = catchOrderType3(
                  id: generateID(25),
                  locationSet: widget.startLocation,
                  locationGet: widget.bikeLocations[i],
                  cost: money,
                  owner: finalData.user_account,
                  shipper: finalData.shipper_account,
                  status: 'A',
                  voucher: widget.order.voucher,
                  S1time: getCurrentTime(),
                  S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  costFee: finalData.bikeCost,
                  subFee: 0,
                  type: 2,
                  motherOrder: widget.order.id
              );
              orderType3.cost = orderType3.cost;
              bike_order_list.add(orderType3);
              widget.order.orderList.add(orderType3.id);
            }
            widget.order.locationSet.mainText = await fetchLocationName(widget.order.locationSet);
            start_order_button_controller.push_mother_order_data(widget.order);
            for (int i = 0; i < custom_order_list.length; i++) {
              await start_order_button_controller.push_child_order_data(custom_order_list[i]);
            }
            for (int i = 0; i < bike_order_list.length; i++) {
              await start_order_button_controller.push_child_order_data(bike_order_list[i]);
            }
            setState(() {
              loading = false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_three_bike_wait(id: widget.order.id)));
          } else {
            toastMessage('Bạn cần điền đủ vị trí');
          }
        },
      ),
    );
  }
}
