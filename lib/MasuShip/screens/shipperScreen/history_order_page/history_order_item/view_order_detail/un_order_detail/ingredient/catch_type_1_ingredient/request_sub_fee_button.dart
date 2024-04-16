import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_1_ingredient/accept_weather_sub_fee_dialog.dart';

class request_sub_fee_button extends StatefulWidget {
  final CatchOrder order;
  const request_sub_fee_button({super.key, required this.order});

  @override
  State<request_sub_fee_button> createState() => _request_sub_fee_buttonState();
}

class _request_sub_fee_buttonState extends State<request_sub_fee_button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: (widget.order.subFee == 0 && finalData.weathercost.available == 1 && (widget.order.status == 'A' || widget.order.status == 'B' || widget.order.status == 'C')) ? 45 : 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: !loading ? Text(
            'Yêu cầu phụ phí thời tiết',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ) : CircularProgressIndicator(color: Colors.black,),
        ),
      ),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return accept_weather_sub_fee_dialog(order: widget.order,);
          },
        );
      },
    );
  }
}
