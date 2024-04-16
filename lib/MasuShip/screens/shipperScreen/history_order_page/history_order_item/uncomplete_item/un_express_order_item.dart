import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_express_order.dart';

class un_express_order_item extends StatefulWidget {
  final expressOrder order;
  const un_express_order_item({super.key, required this.order});

  @override
  State<un_express_order_item> createState() => _un_express_order_itemState();
}

class _un_express_order_itemState extends State<un_express_order_item> {
  String status = 'Đến lấy hàng nhé';

  @override
  Widget build(BuildContext context) {
    if (widget.order.status == 'B') {
      status = 'Đến lấy hàng nhé';
    }

    if (widget.order.status == 'C') {
      status = 'Giao cho khách';
    }

    double width = MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
                        'Lấy hàng tại',
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
                        'Giao hàng tới',
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
                  widget.order.locationGet.mainText + ',' + widget.order.locationGet.secondaryText,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'arial',
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
                    color: Colors.black
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
                          'Phí thu hộ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          getStringNumber(widget.order.codMoney) + '.đ',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal
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
                          'Bước tiếp theo',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          status,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.redAccent,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),

            Container(height: 15,),

          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_un_express_order(id: widget.order.id),),);
      },
    );
  }
}
