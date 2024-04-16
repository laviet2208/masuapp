import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_food_order_detail/view_un_food_order_detail.dart';

import '../../../../../Data/accountData/shopData/shopAccount.dart';

class un_food_order_item extends StatefulWidget {
  final foodOrder order;
  const un_food_order_item({super.key, required this.order});

  @override
  State<un_food_order_item> createState() => _un_food_order_itemState();
}

class _un_food_order_itemState extends State<un_food_order_item> {
  String status = '';

  String get_restaurant_list(List<ShopAccount> list) {
    String data = '';
    for (ShopAccount account in list) {
      data = data + account.name +', ';
    }
    return data.substring(0, data.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (widget.order.status == 'B') {
      status = 'Xác nhận với khách';
    }
    if (widget.order.status == 'C') {
      status = 'Xác nhận với nhà hàng';
    }
    if (widget.order.status == 'D') {
      status = 'Đến lấy món';
    }
    if (widget.order.status == 'E') {
      status = 'Giao cho khách';
    }

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
                    Icons.restaurant,
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
                  get_restaurant_list(widget.order.shopList),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                  widget.order.locationGet.longitude == 0 ? 'Chưa tới nơi' : (widget.order.locationGet.mainText + ',' + widget.order.locationGet.secondaryText),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                          'Số lượng món ăn',
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
                          widget.order.productList.length.toString() + ' Món',
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
                          'Số tiền đưa nhà hàng',
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
                          getStringNumber(history_controller.get_total_food_money(widget.order.productList) - history_controller.get_discount_cost_of_restaurant(widget.order.shopList,widget.order.productList, widget.order.resCost.discount)) + '.đ',
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

            Container(
              height: 15,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_un_food_order_detail(id: widget.order.id),),);
      },
    );
  }
}
