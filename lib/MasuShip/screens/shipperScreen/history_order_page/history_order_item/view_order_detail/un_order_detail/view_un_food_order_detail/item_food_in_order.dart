import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';

import 'delete_food_dialog.dart';

class item_food_in_order extends StatelessWidget {
  final cartProduct product;
  final foodOrder order;
  const item_food_in_order({super.key, required this.product, required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50;
    return Container(
      child: Row(
        children: [
          Container(
            width: width - 30,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: product.product.name + '\n',
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Số lượng: ' + product.number.toString(),
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]
              ),
            )
          ),

          GestureDetector(
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_forever_sharp,
                color: Colors.red,
                size: 20,
              ),
            ),
            onTap: () {
              if (order.status == 'A' || order.status == 'B' || order.status == 'C' || order.status == 'D') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return delete_food_dialog(order: order, index: order.productList.indexOf(product));
                    }
                );
              } else {
                toastMessage('Không thể xóa');
              }
            },
          )
        ],
      ),
    );
  }
}
