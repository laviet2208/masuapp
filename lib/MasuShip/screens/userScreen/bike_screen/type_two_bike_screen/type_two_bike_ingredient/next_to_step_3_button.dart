import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/controller/type_two_wait_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/type_two_bike_wait.dart';

class next_to_step_3_button extends StatefulWidget {
  final Location startLocation;
  const next_to_step_3_button({super.key, required this.startLocation});

  @override
  State<next_to_step_3_button> createState() => _next_to_step_3_buttonState();
}

class _next_to_step_3_buttonState extends State<next_to_step_3_button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white , Colors.yellow],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4), // màu của shadow
                  spreadRadius: 5, // bán kính của shadow
                  blurRadius: 7, // độ mờ của shadow
                  offset: Offset(0, 3), // vị trí của shadow
                ),
              ],
              borderRadius: BorderRadius.circular(1000)
          ),
          child: Center(
            child: !loading ? Text(
              'Xác nhận vị trí và gọi tài xế',
              style: TextStyle(
                  fontFamily: 'mulibold',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15
              ),
            ) : CircularProgressIndicator(color: Colors.black,),
          ),
        ),
        onTap: () async {
          CatchOrder order = CatchOrder(
              id: generateID(25),
              locationSet: widget.startLocation,
              locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
              cost: 0,
              owner: finalData.user_account,
              shipper: finalData.shipper_account,
              status: 'A',
              voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
              S1time: getCurrentTime(),
              S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
              S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
              S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
              costFee: finalData.bikeCost,
              subFee: 0
          );
          setState(() {
            loading = true;
          });
          await type_two_wait_controller.push_new_order(order);
          setState(() {
            loading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_two_bike_wait(orderId: order.id),),);
        },
      ),
    );
  }
}
