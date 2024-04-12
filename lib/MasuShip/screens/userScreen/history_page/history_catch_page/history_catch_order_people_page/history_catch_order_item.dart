import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/type_two_bike_wait.dart';

import '../../../../../Data/otherData/Tool.dart';

class history_catch_order_item extends StatelessWidget {
  final CatchOrder order;
  const history_catch_order_item({super.key, required this.order});

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
                height: (order.status != 'E' && order.status != 'E1' && order.status != 'D') ? null : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25,
                      child: Row(
                        children: [
                          Container(width: 15,),

                          Icon(
                            Icons.start,
                            size: 25,
                            color: Colors.redAccent,
                          ),

                          Container(width: 10,),

                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Container(
                              width: width/2,
                              child: AutoSizeText(
                                'Đón bạn tại',
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
                          order.locationSet.mainText + ',' + order.locationSet.secondaryText,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 8,
                    ),
                  ],
                ),
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
                            'Chi phí vận chuyển',
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
                            order.locationGet.longitude != 0 ? (getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + 'đ') : 'Chưa tới nơi',
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
                            order.subFee == 0 ? 'Phụ phí thời tiết' : 'Phụ phí ' + finalData.weathercost.weatherTitle,
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
                            order.subFee != 0 ? (getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + 'đ') : 'Không có',
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
                            'Số tiền thực trả',
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
                            order.locationGet.longitude != 0 ? getStringNumber(order.cost + order.subFee) + 'đ' : 'Chưa tới nơi',
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

              Container(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (order.locationGet.longitude == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_two_bike_wait(orderId: order.id),),);
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_one_bike_wait(orderId: order.id),),);
        }
      },
    );
  }
}

