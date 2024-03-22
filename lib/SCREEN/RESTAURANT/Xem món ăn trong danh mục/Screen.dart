import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/ShopUser/accountShop.dart';
import 'package:masuapp/SCREEN/RESTAURANT/SCREENshopview.dart';
import 'package:masuapp/SCREEN/RESTAURANT/Xem%20m%C3%B3n%20%C4%83n%20trong%20danh%20m%E1%BB%A5c/Item.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/Product/Danh mục đồ ăn.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../STORE/SCREENstorecart.dart';
import '../../STORE/SCREENstoreview.dart';
import '../SCREENfoodcart.dart';

class Screenxemdanhmuc extends StatefulWidget {
  final String name;
  final accountShop shop;
  final FoodDirectory foodDirectory;
  final int type;
  const Screenxemdanhmuc({Key? key, required this.name, required this.shop, required this.type, required this.foodDirectory}) : super(key: key);

  @override
  State<Screenxemdanhmuc> createState() => _ScreenxemdanhmucState();
}

class _ScreenxemdanhmucState extends State<Screenxemdanhmuc> {
  String totalText = '0 .đ';
  double total1 = 0;

  void updateTotalText() {
    // Gọi setState để cập nhật giao diện
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    total1 = 0;
    if (widget.type == 1) {
      for (int i = 0 ; i < storeList.length ; i++) {
        total1 = total1 + storeList[i].cost;
      }
    } else {
      for (int i = 0 ; i < cartList.length ; i++) {
        total1 = total1 + cartList[i].cost;
      }
    }
    totalText = getStringNumber(total1) + ' .đ';

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: 100,
                    decoration: BoxDecoration(

                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 15,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              if (widget.type == 0) {
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopview(currentShop: widget.shop.id)));
                              }
                              if (widget.type == 1) {
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENstoreview(currentShop: widget.shop.id)));
                              }
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/image/backicon1.png')
                                  )
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                            bottom: 22,
                            left: 60,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 24,
                                  fontFamily: 'arial',
                                  color: Colors.black
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 110,
                  left: 10,
                  right: 10,
                  bottom: 90,
                  child: ListView.builder(
                    itemCount: widget.foodDirectory.foodList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Itemmonandoc(width: screenWidth, id: widget.foodDirectory.foodList[index], ontap: () {setState(() {
                          total1 = 0;
                          if (widget.type == 0) {
                            for (int i = 0 ; i < storeList.length ; i++) {
                              total1 = total1 + storeList[i].cost;
                            }
                          } else {
                            for (int i = 0 ; i < cartList.length ; i++) {
                              total1 = total1 + cartList[i].cost;
                            }
                          }
                          totalText = getStringNumber(total1) + ' .đ';
                        });}, Type: widget.type),
                      );
                    },
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    child: Container(
                      width: screenWidth,
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
                                width: screenWidth - 20,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 244, 164, 84),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 20,
                                      left: 20,
                                      child: Container(
                                        width: screenWidth - 20 - 40,
                                        height: 20,
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                              color: Colors.white,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Giỏ hàng   |  ',
                                              ),
                                              TextSpan(
                                                text: widget.type == 0 ? (cartList.length.toString() + ' món') : (storeList.length.toString() + ' món'),
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
                                        width: screenWidth - 20 - 40,
                                        height: 20,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          totalText,
                                          style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                            color: Colors.white,
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
                      if (cartList.length == 0) {
                        toastMessage('Giỏ hàng chưa có sản phẩm nào');
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => (widget.type == 0 ? SCREENfoodcart() : SCREENstorecart())));
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
        }
    );
  }
}
