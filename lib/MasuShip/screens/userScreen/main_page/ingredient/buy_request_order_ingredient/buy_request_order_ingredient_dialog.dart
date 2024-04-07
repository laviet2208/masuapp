import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/request_buy_step_1.dart';

class buy_request_order_ingredient_dialog extends StatefulWidget {
  const buy_request_order_ingredient_dialog({super.key});

  @override
  State<buy_request_order_ingredient_dialog> createState() => _buy_request_order_ingredient_dialogState();
}

class _buy_request_order_ingredient_dialogState extends State<buy_request_order_ingredient_dialog> {
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
        height: (width - 60)/2,
        decoration: BoxDecoration(

        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
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
                                    image: AssetImage('assets/image/buy_request_type1.png')
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
                            'Mua hàng hộ',
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => request_buy_step_1(),),);
                },
              ),
            ),

            Positioned(
              top: 0,
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
