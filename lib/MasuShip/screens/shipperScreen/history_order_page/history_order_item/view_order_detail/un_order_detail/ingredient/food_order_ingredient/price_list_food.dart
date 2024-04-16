import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/cost_ingredient/cost_ingredient.dart';
import '../../../../../../../../Data/OrderData/foodOrder/foodOrder.dart';

class price_list_food extends StatelessWidget {
  final foodOrder order;
  const price_list_food({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 15,),

              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    cost_ingredient.left_title_cost('Tổng thu của khách', Colors.black, FontWeight.bold),
                    cost_ingredient.right_title_cost(getStringNumber(order.cost - getVoucherSale(order.voucher, order.cost) + order.weatherFee + order.waitFee + history_controller.get_total_food_money(order.productList)) + '.đ', Colors.black, FontWeight.normal),
                  ],
                ),
              ),
              
              Container(height: 8,),

              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    cost_ingredient.left_title_cost('Phụ phí thời tiết', Colors.black, FontWeight.bold),
                    cost_ingredient.right_title_cost(getStringNumber(order.weatherFee) + '.đ', Colors.black, FontWeight.normal),
                  ],
                ),
              ),

              Container(height: 8,),

              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    cost_ingredient.left_title_cost('Phụ phí chờ món', Colors.black, FontWeight.bold),
                    cost_ingredient.right_title_cost(getStringNumber(order.waitFee) + '.đ', Colors.black, FontWeight.normal),
                  ],
                ),
              ),

              Container(height: 8,),

              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    cost_ingredient.left_title_cost('Tổng đưa nhà hàng', Colors.black, FontWeight.bold),
                    cost_ingredient.right_title_cost(getStringNumber(history_controller.get_total_food_money(order.productList) - history_controller.get_discount_cost_of_restaurant(order.shopList,order.productList, order.resCost.discount)) + '.đ', Colors.black, FontWeight.normal),
                  ],
                ),
              ),

              Container(height: 8,),

              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    cost_ingredient.left_title_cost('Tài xế thực nhận', Colors.black, FontWeight.bold),
                    cost_ingredient.right_title_cost(getStringNumber(order.cost * (1 - order.costFee.discount/100) + order.waitFee + order.weatherFee) + '.đ', Colors.black, FontWeight.normal),
                  ],
                ),
              ),

              Container(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
