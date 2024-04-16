import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

import '../../../../../../../Data/otherData/Tool.dart';
import '../../../../../../userScreen/request_buy_screen/ingredient/item_request_product_wait.dart';

class product_in__un_request_buy_order extends StatelessWidget {
  final requestBuyOrder order;
  const product_in__un_request_buy_order({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
                '     Danh sách sản phẩm cần mua',
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: order.productList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return item_request_product_wait(index: index, list: order.productList,);
                },
              ),
            ),

            Container(height: 10,),
          ],
        ),
      ),
    );
  }
}
