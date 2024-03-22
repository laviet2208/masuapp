import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/HISTORY/SCREENhistorycatch.dart';
import 'package:masuapp/SCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

import 'SCREENhistoryfood.dart';
import 'SCREENhistorymarket.dart';
import 'SCREENhistorysend.dart';

class SCREENhistory extends StatefulWidget {
  const SCREENhistory({Key? key}) : super(key: key);

  @override
  State<SCREENhistory> createState() => _SCREENhistoryState();
}

class _SCREENhistoryState extends State<SCREENhistory> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 50,
                    left: 10,
                    child: GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/backicon1.png')
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 5, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                      },
                    ),
                  ),

                  Positioned(
                    top: 100,
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
                    top: 100,
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
                    top: 110 + (screenWidth - 60)/2,
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
                    top: 110 + (screenWidth - 60)/2,
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
                ],
              )
          ),
        ),
        onWillPop: () async {
          return false;
        }
    );
  }
}
