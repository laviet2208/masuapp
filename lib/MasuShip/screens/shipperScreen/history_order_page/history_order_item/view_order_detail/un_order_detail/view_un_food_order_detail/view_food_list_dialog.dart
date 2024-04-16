import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_food_order_detail/item_food_in_order.dart';

import '../../../../../../../Data/accountData/shopData/cartProduct.dart';

class view_food_list_dialog extends StatefulWidget {
  final foodOrder order;
  final int index;
  const view_food_list_dialog({super.key, required this.order, required this.index});

  @override
  State<view_food_list_dialog> createState() => _view_food_list_dialogState();
}

class _view_food_list_dialogState extends State<view_food_list_dialog> {
  List<cartProduct> list = [];

  void add_to_list() {
    list.clear();
    for (cartProduct product in widget.order.productList) {
      if (product.product.owner == widget.order.shopList[widget.index].id) {
        list.add(product);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    add_to_list();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: MediaQuery.of(context).size.height/2,
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: item_food_in_order(product: list[index], order: widget.order,),
              );
            },
          ),
        ),
      ),
    );
  }
}
