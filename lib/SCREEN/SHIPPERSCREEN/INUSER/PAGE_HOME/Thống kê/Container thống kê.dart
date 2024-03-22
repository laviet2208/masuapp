import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/Order/catchOrder.dart';
import '../../../../../GENERAL/Order/foodOrder.dart';
import '../../../../../GENERAL/Order/itemsendOrder.dart';

class ContainerDash extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  const ContainerDash({Key? key, required this.screenWidth, required this.screenHeight}) : super(key: key);

  @override
  State<ContainerDash> createState() => _ContainerDashState();
}

class _ContainerDashState extends State<ContainerDash> {
  //Tổng số đơn hoàn thành trong ngày
  int totalCatch = 0;
  int totalItemSend = 0;
  int totalFood = 0;

  List<foodOrder> foodList = [];

  void getDatafood() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/foodOrder").onValue.listen((event) {
      foodList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if ((foodorder.status == 'C' || foodorder.status == 'D' || foodorder.status == 'D1' || foodorder.status == 'H' || foodorder.status == 'I' || foodorder.status == 'J') && foodorder.shipper.id == currentAccount.id) {
          if (foodorder.S3time.day == getCurrentTime().day && getCurrentTime().month == foodorder.S3time.month && foodorder.S3time.year == getCurrentTime().year) {
            foodList.add(foodorder);
          }
        }
      });
      setState(() {
        totalFood = foodList.length;
      });
    });
  }

  List<catchOrder> orderList = [];

  void getDatacatch() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/catchOrder").onValue.listen((event) {
      orderList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        catchOrder catchorder = catchOrder.fromJson(value);
        if ((catchorder.status == 'B' || catchorder.status == 'C' || catchorder.status == 'D' || catchorder.status == 'F' || catchorder.status == 'G') && catchorder.shipper.id == currentAccount.id) {
          if (catchorder.S2time.day == getCurrentTime().day && getCurrentTime().month == catchorder.S2time.month && catchorder.S2time.year == getCurrentTime().year) {
            orderList.add(catchorder);
          }
          setState(() {
            totalCatch = orderList.length;
          });
        }
      });
      setState(() {

      });
    });
  }

  List<itemsendOrder> sendList = [];
  void getDatasend() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/itemsendOrder").onValue.listen((event) {
      sendList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        itemsendOrder itemorder = itemsendOrder.fromJson(value);
        if ((itemorder.status == 'B' || itemorder.status == 'C' || itemorder.status == 'D' || itemorder.status == 'F' || itemorder.status == 'G' || itemorder.status == 'H') && itemorder.shipper.id == currentAccount.id) {
          if (itemorder.S2time.day == getCurrentTime().day && getCurrentTime().month == itemorder.S2time.month && itemorder.S2time.year == getCurrentTime().year) {
            sendList.add(itemorder);          }
        }
      });
      setState(() {
        totalItemSend = sendList.length;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatacatch();
    getDatafood();
    getDatasend();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 12,
            left: 15,
            child: Container(
              height: 20,
              width: widget.screenWidth-50,
              child: AutoSizeText(
                  'Tổng đơn hôm nay',
                  maxLines: 1,
                  style : TextStyle(
                      fontSize: 100,
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ),

          Positioned(
            bottom: 12,
            left: 15,
            child: Container(
              width: widget.screenWidth-50,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: (totalCatch + totalFood + totalItemSend).toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'arial',
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: ' đơn', // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'arial',
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
              bottom: 12,
              right: (widget.screenWidth-30)/2,
              child: Icon(
                Icons.delivery_dining_outlined,
                color: Colors.black,
                size: 25,
              )
          ),

          Positioned(
              bottom: 15,
              right: ((widget.screenWidth-30)/2) - 20,
              child: Text(
                totalItemSend.toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              )
          ),

          Positioned(
              bottom: 12,
              right: (widget.screenWidth-30)/2 - 70,
              child: Icon(
                Icons.sports_motorsports_outlined,
                color: Colors.black,
                size: 25,
              )
          ),

          Positioned(
              bottom: 15,
              right: ((widget.screenWidth-30)/2) - 90,
              child: Text(
                totalCatch.toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              )
          ),

          Positioned(
              bottom: 14,
              right: (widget.screenWidth-30)/2 - 140,
              child: Icon(
                Icons.fastfood_outlined,
                color: Colors.black,
                size: 25,
              )
          ),

          Positioned(
              bottom: 15,
              right: ((widget.screenWidth-30)/2) - 160,
              child: Text(
                totalFood.toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
        ],
      ),
    );
  }
}
