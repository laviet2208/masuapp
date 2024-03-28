import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/cart_screen/item_cart_product.dart';

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
              )
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
