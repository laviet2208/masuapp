import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/Ads/ADStype1.dart';
import '../../HISTORY/SCREENhistorycatch.dart';
import '../../HISTORY/SCREENhistoryfood.dart';
import '../../HISTORY/SCREENhistorymarket.dart';
import '../../HISTORY/SCREENhistorysend.dart';
import '../../RESTAURANT/SCREENshopview.dart';
import '../PAGE_HOME/Item quảng cáo loại 1.dart';

class PAGEactivity extends StatefulWidget {
  const PAGEactivity({Key? key}) : super(key: key);

  @override
  State<PAGEactivity> createState() => _PAGEactivityState();
}

class _PAGEactivityState extends State<PAGEactivity> {
  List<ADStype1> ADStype1List = [];

  final PageController _pageController =
  PageController(viewportFraction: 1, keepPage: true);
  Timer? _timer;
  int _currentPage = 0;

  void getADStype1Data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADStype1").onValue.listen((event) {
      ADStype1List.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        ADStype1 acc = ADStype1.fromJson(value);
        if (acc.shop.Area == currentAccount.Area) {
          ADStype1List.add(acc);
        }

      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getADStype1Data();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < ADStype1List.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 20 + (screenWidth - 60)/2,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistorycatch()));
                },
                child: Container(
                  width: (screenWidth - 60)/2,
                  height: (screenWidth - 60)/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
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
                        top: 10,
                        left: (((screenWidth - 60)/2) - (((screenWidth - 60)/2)/3*1.8))/2,
                        child: Container(
                          width: ((screenWidth - 60)/2)/3*1.8,
                          height: ((screenWidth - 60)/2)/3*1.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/image/iconhoatdong/lsbatxe.png')
                            )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Container(
                          height: ((screenWidth - 60)/2) - 10 - (((screenWidth - 60)/2)/3*1.8) - 5 - 10,
                          width: ((screenWidth - 60)/2) - 16,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Lịch sử bắt xe',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 16,
                                color: Color.fromARGB(255, 32, 32, 32),
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 20 + (screenWidth - 60)/2,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistorymarket()));
                },
                child: Container(
                  width: (screenWidth - 60)/2,
                  height: (screenWidth - 60)/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
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
                        top: 10,
                        left: (((screenWidth - 60)/2) - (((screenWidth - 60)/2)/3*1.8))/2,
                        child: Container(
                          width: ((screenWidth - 60)/2)/3*1.8,
                          height: ((screenWidth - 60)/2)/3*1.8,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconhoatdong/lsdicho.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Container(
                          height: ((screenWidth - 60)/2) - 10 - (((screenWidth - 60)/2)/3*1.8) - 5 - 10,
                          width: ((screenWidth - 60)/2) - 16,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Lịch sử đi chợ',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 16,
                                color: Color.fromARGB(255, 32, 32, 32),
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistoryfood()));
                },
                child: Container(
                  width: (screenWidth - 60)/2,
                  height: (screenWidth - 60)/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
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
                        top: 10,
                        left: (((screenWidth - 60)/2) - (((screenWidth - 60)/2)/3*1.8))/2,
                        child: Container(
                          width: ((screenWidth - 60)/2)/3*1.8,
                          height: ((screenWidth - 60)/2)/3*1.8,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconhoatdong/lsdoan.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Container(
                          height: ((screenWidth - 60)/2) - 10 - (((screenWidth - 60)/2)/3*1.8) - 5 - 10,
                          width: ((screenWidth - 60)/2) - 16,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Lịch sử đồ ăn',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 16,
                                color: Color.fromARGB(255, 32, 32, 32),
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistorysend()));
                },
                child: Container(
                  width: (screenWidth - 60)/2,
                  height: (screenWidth - 60)/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
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
                        top: 10,
                        left: (((screenWidth - 60)/2) - (((screenWidth - 60)/2)/3*1.8))/2,
                        child: Container(
                          width: ((screenWidth - 60)/2)/3*1.8,
                          height: ((screenWidth - 60)/2)/3*1.8,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/iconhoatdong/lsgiaohang.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Container(
                          height: ((screenWidth - 60)/2) - 10 - (((screenWidth - 60)/2)/3*1.8) - 5 - 10,
                          width: ((screenWidth - 60)/2) - 16,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Lịch sử giao hàng',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 16,
                                color: Color.fromARGB(255, 32, 32, 32),
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 50,
              left: 0,
              child: Container(
                height:(screenWidth - 20)/(1200/630) + 100,
                width: screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: (screenWidth - 20)/(1200/630) + 100,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      itemCount: ADStype1List.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ITEMadsType1(width: screenWidth - 20, height: (screenWidth - 20)/(300/188), adStype1: ADStype1List[index]),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopview(currentShop: ADStype1List[index].shop.id)));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
