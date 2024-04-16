import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';

import '../../../../../../../../Data/otherData/Tool.dart';

class general_info_express_order extends StatelessWidget {
  final expressOrder order;
  const general_info_express_order({super.key, required this.order});

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
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // màu của shadow
              spreadRadius: 2, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 10,),

            get_type_1_line('Đơn ' + order.id, Icons.note_outlined, Colors.red, FontWeight.bold, width),

            Container(height: 10,),

            get_type_1_line('Đặt lúc : ' + getAllTimeString(order.S1time), Icons.history_sharp, Colors.black, FontWeight.normal, width),

            Container(height: 10,),

            get_type_1_line('Masu Express', Icons.motorcycle_rounded, Colors.black, FontWeight.normal, width),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 0.5,
                decoration: BoxDecoration(
                    color: Colors.grey
                ),
              ),
            ),

            Container(height: 10,),

            get_type_2_line('Tổng cộng', order.locationGet.longitude != 0 ? (getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + 'đ') : 'Hiển thị khi tới nơi', width),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 0.5,
                decoration: BoxDecoration(
                    color: Colors.deepOrange
                ),
              ),
            ),

            Container(height: 10,),

            get_type_2_line('Chi phí di chuyển', order.locationGet.longitude != 0 ? (getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + "đ") : 'Hiển thị khi tới nơi', width),

            Container(height: 10,),
          ],
        ),
      ),
    );
  }
}
