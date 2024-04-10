import 'package:flutter/material.dart';

import '../../../../Data/OrderData/requestBuyOrderData/requestProduct.dart';

class item_request_product_wait extends StatefulWidget {
  final int index;
  final List<requestProduct> list;
  const item_request_product_wait({super.key, required this.index, required this.list});

  @override
  State<item_request_product_wait> createState() => _item_request_product_waitState();
}

class _item_request_product_waitState extends State<item_request_product_wait> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                Container(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                    size: 20,
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    height: 30,
                    width: width - 40 - 30 - 40 - 10,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.list[widget.index].name,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: '-Số lượng: ' + widget.list[widget.index].number.toStringAsFixed(0) + ' ' + widget.list[widget.index].unit,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontWeight: FontWeight.normal, // Để in đậm
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(height: 15,),
        ],
      ),
    );
  }
}
