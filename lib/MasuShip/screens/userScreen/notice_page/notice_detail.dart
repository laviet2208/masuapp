import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/noticeData/noticeData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/back_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';

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
    double height = MediaQuery.of(context).size.height;
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

              back_button_in_wait(),

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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return Future.value(false);
      },
    );
  }
}
