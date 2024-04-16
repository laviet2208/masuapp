import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_food_order_detail/view_un_food_order_detail.dart';

import '../../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../Data/otherData/Tool.dart';

class complete_food_order_item extends StatelessWidget {
  final foodOrder order;
  const complete_food_order_item({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String get_restaurant_list(List<ShopAccount> list) {
      String data = '';
      for (ShopAccount account in list) {
        data = data + account.name +', ';
      }
      return data.substring(0, data.length - 2);
    }

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
                    get_restaurant_list(order.shopList),
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
                    order.locationGet.longitude == 0 ? 'Chưa tới nơi' : (order.locationGet.mainText + ',' + order.locationGet.secondaryText),
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
                  height: 0.7,
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
                            'Mã đơn',
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
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Text(
                            getAllTimeString(order.timeList[1]),
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
                            order.productList.length.toString() + ' Món',
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
                            'Trạng thái đơn',
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
                            (order.status == 'A' || order.status == 'B' || order.status == 'C' || order.status == 'D' || order.status == 'E') ? 'Đơn chưa hoàn thành' : (order.status == 'F' ? 'Đơn đã hoàn thành' : 'Đơn bị hủy'),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                color: (order.status == 'A' || order.status == 'B' || order.status == 'C' || order.status == 'D' || order.status == 'E') ? Colors.redAccent : (order.status == 'F' ? Colors.green : Colors.orange),
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
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_un_food_order_detail(id: order.id),),);
      },
    );  }
}
