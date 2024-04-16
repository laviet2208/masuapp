import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/view_com_catch_order_detail_screen.dart';

import '../../../../../../Data/otherData/Tool.dart';
import '../../view_order_detail/un_order_detail/view_un_catch_order_detail_screen.dart';

class complete_catch_order_people_item extends StatelessWidget {
  final CatchOrder order;
  const complete_catch_order_people_item({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // màu của shadow
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
                          'Điểm đến',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.grey,
                              fontFamily: 'muli'
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
                    order.locationGet.longitude == 0 ? 'Chưa tới nơi' : (order.locationGet.mainText + ',' + order.locationGet.secondaryText),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'muli',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Container(height: 10,),

              Container(
                height: 25,
                child: Row(
                  children: [
                    Container(width: 15,),

                    Icon(
                      Icons.directions_bike,
                      size: 25,
                      color: Colors.redAccent,
                    ),

                    Container(width: 10,),

                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Container(
                        width: width/2,
                        child: AutoSizeText(
                          'Đơn xe ôm thường',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.grey,
                              fontFamily: 'muli'
                          ),
                        ),
                      ),
                    ),

                    Container(width: 10,),
                  ],
                ),
              ),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 0.5,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
              ),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 17,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            'Mã đơn',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Text(
                            order.id,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 17,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            'Nhận đơn lúc',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Text(
                            getAllTimeString(order.S2time),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 17,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            'Trạng thái đơn',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Text(
                            order.status == 'D' ? 'Đã hoàn thành' : 'Đơn bị hủy',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                color: order.status == 'D' ? Colors.green : Colors.redAccent,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),

              Container(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => view_catch_order_detail_screen(id: order.id)));
      },
    );
  }
}
