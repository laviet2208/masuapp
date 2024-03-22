import 'package:flutter/material.dart';

import '../../../../../../../Data/OrderData/requestBuyOrderData/requestProduct.dart';
import '../../../../../../../Data/otherData/Tool.dart';

class item_product_in_order extends StatefulWidget {
  final double width;
  final requestProduct product;
  const item_product_in_order({Key? key, required this.width, required this.product}) : super(key: key);

  @override
  State<item_product_in_order> createState() => _item_product_in_orderState();
}

class _item_product_in_orderState extends State<item_product_in_order> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                width: 0.5,
                color: Colors.black
            ),

            top: BorderSide(
                width: 0.5,
                color: Colors.black
            ),
          )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  width: (widget.width - 60)/4,
                  child: Padding(
                    padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 30,
                  child: Padding(
                    padding: EdgeInsets.only(top: 3,left: 2, right: 3),
                    child: Text(
                      widget.product.number.toString(),
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ),
                ),

                Container(
                  width: (widget.width - 60)/4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: Text(
                      widget.product.unit,
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ),
                ),

                Container(
                  width: (widget.width - 60)/4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: Text(
                      getStringNumber(widget.product.cost),
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ),
                ),

                Container(
                  width: (widget.width - 60)/4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: Text(
                      getStringNumber(widget.product.number * widget.product.cost),
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  child: Container(
                    width: 30,
                  ),
                )
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: (widget.width - 60)/4,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: (widget.width - 60)/4 + 30,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 30 + (widget.width - 60)/2,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 30 + (widget.width - 60)/2 + (widget.width - 60)/4,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 30 + (widget.width - 60)/2 + (widget.width - 60)/2,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }
}
