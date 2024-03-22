import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/ShopUser/accountShop.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/ITEM%20nh%C3%A0%20h%C3%A0ng%20g%E1%BA%A7n.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/T%C3%ADnh%20kho%E1%BA%A3ng%20c%C3%A1ch.dart';
import 'package:masuapp/SCREEN/RESTAURANT/SCREENshopmain.dart';

import '../SCREENstoremain.dart';
import '../SCREENstoreview.dart';

class SCREENviewTypestore extends StatefulWidget {
  final int Type;
  final String Title;
  const SCREENviewTypestore({Key? key, required this.Type, required this.Title}) : super(key: key);

  @override
  State<SCREENviewTypestore> createState() => _SCREENviewTypeshopState();
}

class _SCREENviewTypeshopState extends State<SCREENviewTypestore> {
  List<accountShop> shopList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Store").onValue.listen((event) {
      shopList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        accountShop acc = accountShop.fromJson(value);
        if (acc.Type == widget.Type) {
          shopList.add(acc);
          setState(() {});
        }
      });

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 244, 246)
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 35,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/image/backicon1.png'),
                                    )
                                ),
                              ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENstoremain()));
                            },
                          ),
                        ),

                        Positioned(
                          top: 20,
                          left: 60,
                          child: Container(
                            width: screenWidth - 70,
                            height: 20,
                            child: AutoSizeText(
                              widget.Title,
                              style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 95,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight - 100,
                      child: GridView.builder(
                        itemCount: shopList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // số phần tử trên mỗi hàng
                          mainAxisSpacing: 0, // khoảng cách giữa các hàng
                          crossAxisSpacing: 0, // khoảng cách giữa các cột
                          childAspectRatio: 0.73, // tỷ lệ chiều rộng và chiều cao
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: ITEMnearsrestaurant(currentshop: shopList[index], distance : CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(shopList[index].location)[0], CaculateDistance.parseDoubleString(shopList[index].location)[1], currentAccount.locationHis.Latitude, currentAccount.locationHis.Longitude)),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENstoreview(currentShop: shopList[index].id,)));
                            },
                          );
                        },
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
