import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/order_type_3_log_ingredient/order_type_3_log_ingredient.dart';

import '../../../../../Data/otherData/Tool.dart';

class general_info_order_type_3 extends StatelessWidget {
  final catchOrderType3 order;
  const general_info_order_type_3({super.key, required this.order});

  Container get_type_1_line(String title, IconData iconData, Color color, FontWeight weight, double width) {
    return Container(
      height: 30,
      child: Row(
        children: [
          Container(
            width: 10,
          ),

          Container(
            width: 30,
            height: 30,
            child: Icon(
              iconData,
              color: color,
              size: 27,
            ),
          ),

          Container(
            width: 10,
          ),

          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              height: 30,
              width: width - 40 - 30 - 30,
              child: AutoSizeText(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'muli',
                    color: color,
                    fontSize: 200,
                    fontWeight: weight
                ),
              ),
            ),
          ),

          Container(
            width: 10,
          ),
        ],
      ),
    );
  }

  Container get_type_2_line(String leftTitle, String rightTitle, double width,) {
    return Container(
      height: 30,
      child: Row(
        children: [
          Container(
            width: 10,
          ),

          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              height: 30,
              width: (width - 40 - 20)/2,
              child: AutoSizeText(
                leftTitle,
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              height: 30,
              width: (width - 40 - 20)/2,
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                rightTitle,
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 10,),

            get_type_1_line('Đơn về ' + order.locationGet.mainText, Icons.note_outlined, Colors.red, FontWeight.bold, width),

            Container(height: 10,),

            get_type_1_line('Đặt lúc : ' + getAllTimeString(order.S1time), Icons.history_sharp, Colors.black, FontWeight.normal, width),

            Container(height: 10,),

            get_type_1_line(order.type == 1 ? 'Masu chở người' : 'Masu lái hộ', Icons.motorcycle_rounded, Colors.black, FontWeight.normal, width),

            Container(height: 10,),

            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Xem hành trình',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 14,
                        color: Colors.blueAccent
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      title: Text('Hành trình đơn hàng', style: TextStyle(fontFamily: 'muli'),),
                      content: Container(
                        width: MediaQuery.of(context).size.width - 10,
                        child: order_log_type_3_ingredient(orderType3: order),
                      ),
                    );
                  },
                );
              },
            ),

            Container(height: 10,),
          ],
        ),
      ),
    );
  }
}