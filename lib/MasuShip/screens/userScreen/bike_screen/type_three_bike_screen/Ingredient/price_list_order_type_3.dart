import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/cost_ingredient/cost_ingredient.dart';

import '../../../../../Data/otherData/Tool.dart';

class price_list_order_type_3 extends StatelessWidget {
  final catchOrderType3 order;
  const price_list_order_type_3({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 15,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                  alignment: Alignment.centerLeft,
                  height: 17,
                  child: Stack(
                    children: <Widget>[
                      cost_ingredient.left_title_cost('Chi phí di chuyển(' + getDistanceOfBike(order.cost, order.costFee).toStringAsFixed(1) + 'Km)', Colors.red, FontWeight.bold),
                      cost_ingredient.right_title_cost((getStringNumber(order.cost) + '.đ'), Colors.red, FontWeight.bold),
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
                      cost_ingredient.left_title_cost('Phụ thu', Colors.black, FontWeight.normal),
                      cost_ingredient.right_title_cost(getStringNumber(order.subFee) + '.đ', Colors.black, FontWeight.normal),
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
                      cost_ingredient.left_title_cost('Mã giảm giá', Colors.black, FontWeight.normal),
                      cost_ingredient.right_title_cost(order.voucher.id == '' ? 'Không áp mã' : getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ', Colors.black, FontWeight.normal),
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
                      cost_ingredient.left_title_cost('Cần thanh toán', Colors.black, FontWeight.bold),
                      cost_ingredient.right_title_cost(getStringNumber(order.cost + order.subFee - getVoucherSale(order.voucher, order.cost)) + '.đ' , Colors.black, FontWeight.bold),
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