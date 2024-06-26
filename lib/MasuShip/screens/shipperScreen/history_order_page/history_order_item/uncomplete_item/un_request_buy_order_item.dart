import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

import '../../../../../Data/otherData/Tool.dart';
import '../view_order_detail/un_order_detail/view_un_buy_request_order_detail/view_un_buy_request_order_detail_screen.dart';

class un_request_buy_order_item extends StatefulWidget {
  final requestBuyOrder order;
  const un_request_buy_order_item({Key? key, required this.order}) : super(key: key);

  @override
  State<un_request_buy_order_item> createState() => _un_request_buy_order_itemState();
}

class _un_request_buy_order_itemState extends State<un_request_buy_order_item> {
  double totalmoney = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.order.productList.length; i++) {
      totalmoney = totalmoney + (widget.order.productList[i].number * widget.order.productList[i].cost);
    }
  }

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
                    Icons.shopping_cart_outlined,
                    size: 25,
                    color: Colors.redAccent,
                  ),

                  Container(width: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Container(
                      width: width/2,
                      child: AutoSizeText(
                        'Mua hàng tại',
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
                  widget.order.buyLocation.length.toString() + ' Điểm',
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

            Container(
              height: 8,
            ),

            Container(
              height: 25,
              child: Row(
                children: [
                  Container(width: 15,),

                  Icon(
                    Icons.add_box_outlined,
                    size: 25,
                    color: Colors.green,
                  ),

                  Container(width: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Container(
                      width: width/2,
                      child: AutoSizeText(
                        'Đơn mua hộ',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.black,
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
                  height: 15,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          'Chi phí vận chuyển',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          getStringNumber(widget.order.cost) + '.đ',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.redAccent,
                              fontFamily: 'arial',
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
                  height: 15,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          'Tài xế thực nhận',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          getStringNumber(widget.order.cost + widget.order.subFee + (10000 * ((widget.order.productList.length/3).toInt()).toDouble()) - getShipDiscount(widget.order.cost, widget.order.costFee)) + '.đ',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.redAccent,
                              fontFamily: 'arial',
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
      onTap: () {
        //view_un_buy_request_order_detail_screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => view_un_buy_request_order_detail_screen(id: widget.order.id,)));
      },
    );
  }
}
