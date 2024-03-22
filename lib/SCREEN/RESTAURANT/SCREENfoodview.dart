import 'dart:math';

import 'package:flutter/material.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/Product/Product.dart';
import '../../GENERAL/Tool/Tool.dart';
import '../../GENERAL/utils/utils.dart';
import '../../OTHER/Button/Buttontype1.dart';
import 'SCREENshopmain.dart';
import 'SCREENshopview.dart';


class SCREENfoodview extends StatefulWidget {
  final Product product;
  const SCREENfoodview({Key? key, required this.product}) : super(key: key);

  @override
  State<SCREENfoodview> createState() => _SCREENfoodviewState();
}

class _SCREENfoodviewState extends State<SCREENfoodview> {
  String getRandomString() {
    final List<String> strings = [
      "assets/image/bgfood1.png",
      "assets/image/bgfood2.png",
      "assets/image/bgfood3.png"
    ];
    final random = Random();
    final index = random.nextInt(strings.length);
    return strings[index];
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 247, 247)
          ),

          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight/2,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),

                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: screenWidth/2,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(widget.product.imageList[0])
                            )
                          ),
                        ),
                      ),

                      Positioned(
                        top: screenWidth/2 + 10,
                        left: 10,
                        child: Container(
                          width: screenWidth/3*2,
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontFamily: 'arial',
                              color: Colors.black
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: screenWidth/2 + 10,
                        right: 10,
                        child: Container(
                          child: Text(
                            getStringNumber(widget.product.cost) + "đ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'arial',
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: screenWidth/2 + 80,
                        left: 10,
                        child: Container(
                          width: screenWidth-20,
                          child: Text(
                            compactString(400, widget.product.content),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'arial',
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 40,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/backicon1.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight/2 - 10,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 20,
                        left: 10,
                        child: ButtonType1(Height: 70, Width: screenWidth - 20, color: Color.fromARGB(255, 0, 177, 79), radiusBorder: 30, title: 'Thêm vào giỏ hàng', fontText: 'arial', colorText: Colors.white,
                            onTap: () {
                              if (cartList.isEmpty) {
                                cartList.add(widget.product);
                                toastMessage('Bạn đã thêm 1 ' + widget.product.name);
                                Navigator.of(context).pop();
                              } else {
                                if (widget.product.owner.id == cartList[0].owner.id) {
                                  cartList.add(widget.product);
                                  toastMessage('Bạn đã thêm ' + widget.product.name);
                                  Navigator.of(context).pop();
                                } else {
                                  toastMessage('Bạn không thể thêm món từ 2 nhà hàng khác nhau');
                                }
                              }

                            }),
                      )
                    ],
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
