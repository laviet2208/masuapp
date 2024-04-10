import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/cost_ingredient/cost_ingredient.dart';

import '../../../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../../../Data/otherData/Tool.dart';

class price_list_order_type_1 extends StatelessWidget {
  final CatchOrder order;
  const price_list_order_type_1({super.key, required this.order});

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
              color: Colors.grey.withOpacity(0.2), // màu của shadow
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

            Container(
              height: 30,
              child: Row(
                children: [
                  Container(
                    width: 10,
                  ),

                  Icon(
                    Icons.wallet,
                    size: 30,
                    color: Colors.orange,
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
                        'Thông tin thu nhập',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontSize: 200,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 10,
                  ),
                ],
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
                      cost_ingredient.left_title_cost(order.locationGet.longitude == 0 ? 'Chi phí vận chuyển' : 'Chi phí vận chuyển(' + getDistanceOfBike(order.cost).toStringAsFixed(1) + 'Km)', Colors.red, FontWeight.bold),
                      cost_ingredient.right_title_cost(order.locationGet.longitude != 0 ? (getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + '.đ') : 'Chưa tới nơi', Colors.red, FontWeight.bold),
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
                      cost_ingredient.left_title_cost('Tổng thu của khách', Colors.black, FontWeight.bold),
                      cost_ingredient.right_title_cost(getStringNumber(order.cost + order.subFee) + '.đ', Colors.black, FontWeight.bold),
                    ],
                  )
              ),
            ),

            Container(height: 15,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                  alignment: Alignment.centerLeft,
                  height: 16,
                  child: Stack(
                    children: <Widget>[
                      cost_ingredient.left_title_cost('Tài xế thực nhận', Colors.black, FontWeight.bold),
                      cost_ingredient.right_title_cost(getStringNumber(order.cost + order.subFee + getVoucherSale(order.voucher, order.cost) - ((order.cost + getVoucherSale(order.voucher, order.cost)) * (order.costFee.discount/100))) + '.đ', Colors.black, FontWeight.bold),
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
                      cost_ingredient.left_title_cost('Chiết khấu đơn', Colors.black, FontWeight.normal),
                      cost_ingredient.right_title_cost(getStringNumber((order.cost+getVoucherSale(order.voucher, order.cost)) * (order.costFee.discount/100)) + '.đ', Colors.black, FontWeight.normal),
                    ],
                  )
              ),
            ),

            Container(height: 15,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                  alignment: Alignment.centerLeft,
                  height: 16,
                  child: Stack(
                    children: <Widget>[
                      cost_ingredient.left_title_cost('Mã khuyến mãi', Colors.black, FontWeight.normal),
                      cost_ingredient.right_title_cost(getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ', Colors.black, FontWeight.normal),
                    ],
                  )
              ),
            ),

            Container(height: 15,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                  alignment: Alignment.centerLeft,
                  height: 16,
                  child: Stack(
                    children: <Widget>[
                      cost_ingredient.left_title_cost(order.subFee == 0 ? 'Phụ phí' : ('Phụ phí ' + finalData.weathercost.weatherTitle), Colors.black, FontWeight.normal),
                      cost_ingredient.right_title_cost(getStringNumber(order.subFee) + '.đ', Colors.black, FontWeight.normal),
                    ],
                  )
              ),
            ),

            Container(height: 15,),
          ],
        ),
      ),
    );
  }
}