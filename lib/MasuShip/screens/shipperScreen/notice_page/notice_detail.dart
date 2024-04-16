import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/noticeData/noticeData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/shipper_main_screen.dart';
import '../../../Data/otherData/Tool.dart';

class notice_detail extends StatefulWidget {
  final noticeData data;
  const notice_detail({super.key, required this.data});

  @override
  State<notice_detail> createState() => _notice_detailState();
}

class _notice_detailState extends State<notice_detail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [Colors.white ,Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
          child: ListView(
            children: [
              Container(height: 10,),

              GestureDetector(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.transparent
                  ),
                  child: Row(
                    children: [
                      Container(width: 10,),

                      Container(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                      ),

                      Container(width: 10,),

                      Padding(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        child: Container(
                          width: width - 70,
                          child: AutoSizeText(
                            'Quay về trang chủ',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  finalData.shipperIndexTempotary.intData = 2;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
                },
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Container(
                    child: Text(
                      widget.data.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'muli',
                        color: Colors.black,
                        decoration: TextDecoration.none,

                      ),
                    )
                ),
              ),

              Container(height: 8,),

              Padding(
                padding: EdgeInsets.only(left: 15,right: 10),
                child: Container(
                    height: 20,
                    child: AutoSizeText(
                      getAllTimeString(widget.data.send),
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'muli',
                        color:Colors.grey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    )
                ),
              ),

              Container(height: 8,),

              Padding(
                padding: EdgeInsets.only(left: 15,right: 10),
                child: Container(
                    child: Text(
                      widget.data.content,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'muli',
                        color:Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        finalData.shipperIndexTempotary.intData = 2;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
        return Future.value(false);
      },
    );
  }
}
