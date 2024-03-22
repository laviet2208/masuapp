import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/Page%20v%C3%AD%20ti%E1%BB%81n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Th%C3%B4ng%20tin%20t%C3%A0i%20kho%E1%BA%A3n/yeucauruttien.dart';

import '../SCREEN_MAIN/SCREENmain.dart';

class SCREENnaptien extends StatefulWidget {
  const SCREENnaptien({Key? key}) : super(key: key);

  @override
  State<SCREENnaptien> createState() => _SCREENnaptienState();
}

class _SCREENnaptienState extends State<SCREENnaptien> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: 100,
                decoration: BoxDecoration(
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
                      bottom: 10,
                      left: 10,
                      child: GestureDetector(
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Pagevitien()));
                        },
                      ),
                    ),

                    Positioned(
                      bottom: 15,
                      left: 70,
                      right: 70,
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Hướng dẫn nạp tiền',
                          style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 100,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Positioned(
              top: 100,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight-100,
                child: ListView(
                  children: [
                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Cách 1 :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' nạp bằng cách chuyển khoản',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 15,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Bước 1 :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' Chuyển khoản vào số tài khoản 0777117333 , ngân hàng OCB , chủ tài khoản Trần Văn Tây',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 15,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Bước 2 :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' Đợi hệ thống cộng tiền',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(height: 30,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Cách 2 :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' Tới trụ sở công ty nạp trực tiếp',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
