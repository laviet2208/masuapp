import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_step_1.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_step_1.dart';

import '../../../bike_screen/type_two_bike_screen/type_two_bike_step_1.dart';

class catch_order_ingredient_dialog extends StatefulWidget {
  const catch_order_ingredient_dialog({super.key});

  @override
  State<catch_order_ingredient_dialog> createState() => _catch_order_ingredient_dialogState();
}

class _catch_order_ingredient_dialogState extends State<catch_order_ingredient_dialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: Container(
        width: width - 60,
        height: (width - 90) + 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: (width - 90)/2 + 30,
              left: 0,
              child: GestureDetector(
                child: Container(
                  width: (width - 60 - 30)/2,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: (width - 90)/7,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage('assets/image/catchtype1.png')
                                )
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: (width - 90)/7 - 10,
                          child: Text(
                            'Đã biết điểm đến',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_one_bike_step_1(),),);
                },
              ),
            ),

            Positioned(
              top: 0,
              bottom: (width - 90)/2 + 30,
              right: 0,
              child: GestureDetector(
                child: Container(
                  width: (width - 60 - 30)/2,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: (width - 90)/7,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage('assets/image/catchtype2.png')
                                )
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: (width - 90)/7 - 10,
                          child: Text(
                            'Tự chỉ đường',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_two_bike_step_1(),),);
                },
              ),
            ),

            Positioned(
              top: (width - 90)/2 + 30,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                child: Container(
                  width: (width - 60 - 30)/2,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: (width - 90)/7,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage('assets/image/catchtype3.png')
                                )
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: (width - 90)/7 - 10,
                          child: Text(
                            'Lái xe về hộ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_three_bike_step_1(),),);
                },
              ),
            ),

            Positioned(
              top: (width - 90)/2 + 30,
              bottom: 0,
              right: 0,
              child: GestureDetector(
                child: Container(
                  width: (width - 60 - 30)/2,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: (width - 90)/7,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage('assets/image/catchtype4.png')
                                )
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: (width - 90)/7 - 10,
                          child: Text(
                            'Gọi hotline đặt xe',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
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
