import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

class dash_board_container extends StatefulWidget {
  const dash_board_container({Key? key}) : super(key: key);

  @override
  State<dash_board_container> createState() => _dash_board_containerState();
}

class _dash_board_containerState extends State<dash_board_container> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width - 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 6),
              child: AutoSizeText(
                'Xin chào, ' + finalData.shipper_account.name,
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 100,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Container(height: 3,),

          Container(
            height: 15,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: AutoSizeText(
                'Ngày ' + getCurrentTime().day.toString() + ',tháng ' + getCurrentTime().month.toString() + ',năm ' + getCurrentTime().year.toString(),
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 100,
                ),
              ),
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
