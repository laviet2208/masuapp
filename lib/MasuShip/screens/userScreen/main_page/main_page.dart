import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_page/ingredient/catch_order_ingredient/catch_order_ingredient_dialog.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_main_screen/restaurant_main_screen.dart';

class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  String areaName = '';

  void get_area_name() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(finalData.user_account.area).onValue.listen((event) {
      final dynamic area = event.snapshot.value;
      areaName = area['name'].toString();
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_name();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [Colors.yellow.withOpacity(0.8) ,Colors.yellowAccent.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                height: height/3 - 70,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
              ),
            ),

            Positioned(
              top: height/3,
              right: 10,
              child: Container(
                width: width/3*2,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow,
                  border: Border.all(
                    width: 0.7
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, top: 3, bottom: 3),
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),
                        
                        Container(width: 5,),
                        
                        Padding(
                          padding: EdgeInsets.only(top: 5.5, bottom: 5.5),
                          child: Container(
                            width: width/3*2 - 10 - 29 - 5,
                            child: AutoSizeText(
                              areaName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100
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
              top: height/3 + 55,
              left: 30,
              child: GestureDetector(
                child: Container(
                  width: (width - 90)/2,
                  height: (width - 90)/2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // màu của shadow
                        spreadRadius: 5, // bán kính của shadow
                        blurRadius: 7, // độ mờ của shadow
                        offset: Offset(0, 3), // vị trí của shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: (width - 90)/6,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('assets/image/iconbike.png')
                            )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: (width - 90)/8 - 20,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Gọi xe ôm',
                            style: TextStyle(
                              fontFamily: 'arial',
                              fontSize: 100,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return catch_order_ingredient_dialog();
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: height/3 + 55,
              right: 30,
              child: GestureDetector(
                child: Container(
                  width: (width - 90)/2,
                  height: (width - 90)/2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // màu của shadow
                        spreadRadius: 5, // bán kính của shadow
                        blurRadius: 7, // độ mờ của shadow
                        offset: Offset(0, 3), // vị trí của shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: (width - 90)/6,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/image/iconfood.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: (width - 90)/8 - 20,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Mua đồ ăn',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 100,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => restaurant_main_screen(),),);
                },
              ),
            ),

            Positioned(
              bottom: height/10,
              right: 30,
              child: GestureDetector(
                child: Container(
                  width: (width - 90)/2,
                  height: (width - 90)/2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // màu của shadow
                        spreadRadius: 5, // bán kính của shadow
                        blurRadius: 7, // độ mờ của shadow
                        offset: Offset(0, 3), // vị trí của shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: (width - 90)/6,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/image/iconbag.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: (width - 90)/8 - 20,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Mua hộ',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 100,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {

                },
              ),
            ),

            Positioned(
              bottom: height/10,
              left: 30,
              child: GestureDetector(
                child: Container(
                  width: (width - 90)/2,
                  height: (width - 90)/2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // màu của shadow
                        spreadRadius: 5, // bán kính của shadow
                        blurRadius: 7, // độ mờ của shadow
                        offset: Offset(0, 3), // vị trí của shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: (width - 90)/6,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/image/iconmart.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: (width - 90)/8 - 20,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Giao hàng nhanh',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 100,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
