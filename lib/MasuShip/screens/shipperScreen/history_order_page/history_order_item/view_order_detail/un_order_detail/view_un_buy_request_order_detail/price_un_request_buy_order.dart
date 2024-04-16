import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';

import '../../../../../../../Data/otherData/Tool.dart';

class price_un_request_buy_order extends StatelessWidget {
  final requestBuyOrder order;
  const price_un_request_buy_order({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: get_usually_decoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 20,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '   Thông tin thanh toán',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(height: 10,),

            Container(
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
                      child: general_ingredient.get_cost_title('Chi phí di chuyển(' + getDistanceOfBike(order.cost).toStringAsFixed(1) + 'Km)', Colors.black, FontWeight.bold, width),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: general_ingredient.get_cost_content(getStringNumber(order.cost) + '.đ', Colors.black, FontWeight.bold, width),
                  ),
                ],
              ),
            ),

            Container(height: 10,),

            Container(
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
                      child: general_ingredient.get_cost_title('Phụ thu thời tiết', Colors.black, FontWeight.bold, width),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: general_ingredient.get_cost_content(getStringNumber(order.subFee) + '.đ', Colors.black, FontWeight.bold, width),
                  ),
                ],
              ),
            ),

            Container(height: 10,),

            Container(
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
                      child: general_ingredient.get_cost_title('Phụ thu hàng hóa(' + order.productList.length.toString() + 'món)', Colors.black, FontWeight.bold, width),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: general_ingredient.get_cost_content(getStringNumber((10000 * ((order.productList.length/3).toInt()).toDouble())) + '.đ', Colors.black, FontWeight.bold, width),
                  ),
                ],
              ),
            ),

            Container(height: 10,),

            Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.black
              ),
            ),

            Container(height: 10,),

            Container(
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
                      child: general_ingredient.get_cost_title('Tổng thu của khách', Colors.black, FontWeight.bold, width),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: general_ingredient.get_cost_content(getStringNumber(order.cost + order.subFee - getVoucherSale(order.voucher, order.cost) + (10000 * ((order.productList.length/3).toInt()).toDouble())) + '.đ', Colors.black, FontWeight.bold, width),
                  ),
                ],
              ),
            ),

            Container(height: 10,),

            Container(
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
                      child: general_ingredient.get_cost_title('Shipper thực nhận', Colors.black, FontWeight.bold, width),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: general_ingredient.get_cost_content(getStringNumber(order.cost + order.subFee - (order.cost * order.costFee.discount/100) + (10000 * ((order.productList.length/3).toInt()).toDouble())) + '.đ', Colors.black, FontWeight.bold, width),
                  ),
                ],
              ),
            ),

            Container(height: 10,),
          ],
        ),
      ),
    );
  }
}
