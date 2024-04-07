import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_catch_order_type_2_detail_screen.dart';

import '../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../Data/otherData/Tool.dart';

class un_catch_order_type_2_item extends StatefulWidget {
  final CatchOrder order;
  const un_catch_order_type_2_item({super.key, required this.order});

  @override
  State<un_catch_order_type_2_item> createState() => _un_catch_order_type_2_itemState();
}

class _un_catch_order_type_2_itemState extends State<un_catch_order_type_2_item> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
              height: 15,
            ),

            Container(
              height: 25,
              child: Row(
                children: [
                  Container(width: 15,),

                  Icon(
                    Icons.directions_bike_sharp,
                    size: 25,
                    color: Colors.redAccent,
                  ),

                  Container(width: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Container(
                      width: width/2,
                      child: AutoSizeText(
                        'Đón khách tại',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.grey,
                            fontFamily: 'arial'
                        ),
                      ),
                    ),
                  ),

                  Container(width: 10,),
                ],
              ),
            ),

            Container(height: 8,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.order.locationSet.mainText + ',' + widget.order.locationSet.secondaryText,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Container(
              height: 8,
            ),

            Container(
              height: 25,
              child: Row(
                children: [
                  Container(width: 15,),

                  Icon(
                    Icons.location_on,
                    size: 25,
                    color: Colors.green,
                  ),

                  Container(width: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Container(
                      width: width/2,
                      child: AutoSizeText(
                        'Khách tự chỉ đường',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.grey,
                            fontFamily: 'arial'
                        ),
                      ),
                    ),
                  ),

                  Container(width: 10,),
                ],
              ),
            ),

            Container(height: 15,),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => view_un_catch_order_type_2_detail_screen(id: widget.order.id)));
      },
    );
  }
}
