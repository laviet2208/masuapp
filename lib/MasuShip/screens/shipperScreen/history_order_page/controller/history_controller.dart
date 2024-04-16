import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/un_complete_order_page.dart';

import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../history_order_childpage/complete_order_page/complete_order_page.dart';

class history_controller {
  static Widget get_history_widget(int index) {
    switch (index) {
      case 0 :
        return finalData.shipper_account.onlineStatus == 0 ? Container(alignment: Alignment.center, child: Text('Hãy check-in để xem đơn chưa hoàn thành', style: TextStyle(color: Colors.black, fontFamily: 'roboto'),),) : un_complete_order_page();
      case 1 :
        return complete_order_page();
      default:
        return Container();
    }
  }

  static double get_total_food_money(List<cartProduct> list) {
    double money = 0;
    for(int i = 0; i < list.length; i++) {
      money = money + (list[i].number * list[i].product.cost);
    }
    return money;
  }

  static double get_discount_cost_of_restaurant(List<ShopAccount> shops, List<cartProduct> products, double discount) {
    double money = 0;
    ShopAccount accountS = shops.first;
    accountS.discount_type = 1;
    for (cartProduct product in products) {
      double total_food_money = product.product.cost * product.number.toDouble();
      ShopAccount account = shops.firstWhere((item) => item.id == product.product.owner, orElse: () => accountS);
      print(account.name);
      if (account.discount_type == 1) {
        money = money + total_food_money * discount/100;
      }
    }
    return money;
  }

  static double get_cost_pay_for_restaurant(ShopAccount account, List<cartProduct> products, double discount) {
    double money = 0;
    for (cartProduct product in products) {
      if (product.product.owner == account.id) {
        money = money + product.product.cost * product.number;
      }
    }
    if (account.discount_type == 1) {
      return money - money*discount/100;
    }
    return money;
  }
}