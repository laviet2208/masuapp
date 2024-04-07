import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/cart_screen/item_cart_product.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/food_order_step_1/food_order_step_1.dart';

import '../../../../../Data/otherData/Tool.dart';
import '../../../../../Data/otherData/utils.dart';

class view_cart_screen extends StatefulWidget {
  final Widget beforewidget;
  const view_cart_screen({super.key, required this.beforewidget});

  @override
  State<view_cart_screen> createState() => _view_cart_screenState();
}

class _view_cart_screenState extends State<view_cart_screen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.beforewidget));
                            },
                          ),

                          Container(width: 10,),

                          Container(
                            width: width - 20 - 80,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, bottom: 0),
                              child: Container(
                                height: 23,
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'Giỏ hàng của tôi',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 100,
                left: 10,
                right: 10,
                bottom: 80,
                child: Container(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: finalData.cartList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: item_cart_product(product: finalData.cartList[index], event: () {
                          setState(() {

                          });
                        }),
                      );
                    },
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            child: Container(
                              width: width - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [Colors.yellow.withOpacity(0.4), Colors.yellow],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: Container(
                                      width: width - 20 - 40,
                                      height: 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Giỏ hàng   |  ',
                                            ),
                                            TextSpan(
                                              text: finalData.cartList.length.toString() + ' món',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal, // Cài đặt FontWeight.normal cho "món"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      width: width - 20 - 40,
                                      height: 20,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        getStringNumber(get_total_cart_money()) + '.đ',
                                        style: TextStyle(
                                          fontFamily: 'muli',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (finalData.cartList.length == 0) {
                      toastMessage('Giỏ hàng chưa có sản phẩm nào');
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => food_order_step_1(beforeWidget: widget.beforewidget),),);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
