import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/Order/catchOrder.dart';
import '../../../../GENERAL/Order/foodOrder.dart';
import '../../../../GENERAL/Order/itemsendOrder.dart';
import '../../ITEM/ITEMcatchinhistory.dart';
import '../../ITEM/ITEMfoodinhistory.dart';
import '../../ITEM/ITEMsendinhistory.dart';

class SCREENhistory extends StatefulWidget {
  const SCREENhistory({Key? key}) : super(key: key);

  @override
  State<SCREENhistory> createState() => _SCREENhistoryState();
}

class _SCREENhistoryState extends State<SCREENhistory> {
  Color catchbutton = Colors.deepOrange;
  Color catchText = Colors.white;
  Color sendbutton = Color.fromARGB(100, 200, 225, 252);
  Color sendText = Colors.deepOrange;
  Color foodbutton = Color.fromARGB(100, 200, 225, 252);
  Color foodText = Colors.deepOrange;

  int itemcount = 0;
  int itemcount1 = 0;
  int itemcount2 = 0;
  int itemcount3 = 0;
  int typeIndex = 0;
  List<catchOrder> orderList = [];
  List<itemsendOrder> sendList = [];
  List<foodOrder> foodList = [];

  void getDatacatch() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("catchOrder").onValue.listen((event) {
      orderList.clear();
      itemcount1 = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        catchOrder catchorder = catchOrder.fromJson(value);
        // if (catchorder.status == "A" || (catchorder.status == 'B' && catchorder.shipper.id == currentAccount.id) || (catchorder.status == 'C' && catchorder.shipper.id == currentAccount.id)) {
        //   orderList.add(catchorder);
        // }

        if ((catchorder.status == 'B' || catchorder.status == 'C' || catchorder.status == 'D' || catchorder.status == 'F' || catchorder.status == 'G') && catchorder.shipper.id == currentAccount.id) {
          orderList.add(catchorder);
        }
      });
      itemcount1 = orderList.length;
      if (typeIndex == 0) {
        itemcount = itemcount1;
      }
      setState(() {

      });
    });
  }

  void getDatafood() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("foodOrder").onValue.listen((event) {
      foodList.clear();
      itemcount3 = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if ((foodorder.status == 'C' || foodorder.status == 'D' || foodorder.status == 'D1' || foodorder.status == 'H' || foodorder.status == 'I' || foodorder.status == 'J') && foodorder.shipper.id == currentAccount.id) {
          foodList.add(foodorder);
        }
      });
      itemcount3 = foodList.length;
      if (typeIndex == 3) {
        itemcount = itemcount3;
      }
      setState(() {

      });
    });
  }

  void getDatasend() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("itemsendOrder").onValue.listen((event) {
      sendList.clear();
      itemcount2 = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        itemsendOrder itemorder = itemsendOrder.fromJson(value);
        if ((itemorder.status == 'B' || itemorder.status == 'C' || itemorder.status == 'D' || itemorder.status == 'F' || itemorder.status == 'G' || itemorder.status == 'H') && itemorder.shipper.id == currentAccount.id) {
          sendList.add(itemorder);
        }
      });
      itemcount2 = sendList.length;
      if (typeIndex == 1) {
        itemcount = itemcount2;
      }
      setState(() {

      });
    });
  }

  Padding getPadding(int type , int index, double screenWidth) {
    //xe máy
    if (type == 0) {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20 , bottom: 20),
        child: InkWell(
          onTap: () {

          },
          child: ITEMcatchinhistory(order: orderList[index], width: screenWidth, height: 340),
        ),
      );
    }

    //giao hàng
    if (type == 1) {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20 , bottom: 20),
        child: InkWell(
          onTap: () {

          },
          child: ITEMsendhistory(order: sendList[index], width: screenWidth, height: 380),
        ),
      );
    }

    //đồ ăn
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20 , bottom: 20),
      child: InkWell(
        onTap: () {

        },
        child: ITEMfoodinhistory(order: foodList[index], width: screenWidth, height: 370),
      ),
    );
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),

        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                  width: screenWidth,
                  height: screenHeight/10,
                  decoration: BoxDecoration(
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        left: 5,
                        child: GestureDetector(
                          onTap: () {
                            catchbutton = Colors.deepOrange;
                            catchText = Colors.white;
                            sendbutton = Color.fromARGB(100, 200, 225, 252);
                            sendText = Colors.deepOrange;
                            foodbutton = Color.fromARGB(100, 200, 225, 252);
                            foodText = Colors.deepOrange;
                            typeIndex = 0;
                            itemcount = itemcount1;
                            setState(() {

                            });
                          },
                          child: Container(
                            height: screenHeight/17,
                            width: screenWidth/4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: catchbutton,
                                borderRadius: BorderRadius.circular(screenHeight/34)
                            ),
                            child: Text(
                              'Xe ôm',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'arial',
                                  fontSize: screenWidth/25,
                                  color: catchText
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 10,
                        left: 15 + screenWidth/4,
                        child: GestureDetector(
                          onTap: () {
                            sendbutton = Colors.deepOrange;
                            sendText = Colors.white;
                            catchbutton = Color.fromARGB(100, 200, 225, 252);
                            catchText = Colors.deepOrange;
                            foodbutton = Color.fromARGB(100, 200, 225, 252);
                            foodText = Colors.deepOrange;
                            typeIndex = 1;
                            itemcount = itemcount2;
                            setState(() {

                            });
                          },
                          child: Container(
                            height: screenHeight/17,
                            width: screenWidth/4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: sendbutton,
                                borderRadius: BorderRadius.circular(screenHeight/34)
                            ),
                            child: Text(
                              'Giao hàng',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'arial',
                                  fontSize: screenWidth/25,
                                  color: sendText
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 10,
                        left: 25 + screenWidth/2,
                        child: GestureDetector(
                          onTap: () {
                            foodbutton = Colors.deepOrange;
                            foodText = Colors.white;
                            catchbutton = Color.fromARGB(100, 200, 225, 252);
                            catchText = Colors.deepOrange;
                            sendbutton = Color.fromARGB(100, 200, 225, 252);
                            sendText = Colors.deepOrange;
                            typeIndex = 3;
                            itemcount = itemcount3;
                            setState(() {

                            });
                          },
                          child: Container(
                            height: screenHeight/17,
                            width: screenWidth/4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: foodbutton,
                                borderRadius: BorderRadius.circular(screenHeight/34)
                            ),
                            child: Text(
                              'Đồ ăn',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'arial',
                                  fontSize: screenWidth/25,
                                  color: foodText
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),

            Positioned(
              top: screenHeight/10,
              left: 0,
              child: Container(
                  height: screenHeight/1.5,
                  width: screenWidth,
                  child: ListView.builder(
                    itemCount: itemcount,
                    itemBuilder: (context, index) {
                      return getPadding(typeIndex, index, screenWidth);
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
