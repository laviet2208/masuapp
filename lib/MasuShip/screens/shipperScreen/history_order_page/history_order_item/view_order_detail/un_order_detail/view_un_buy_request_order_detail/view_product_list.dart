import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestProduct.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_buy_request_order_detail/item_product_in_order.dart';

import '../../../../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../../../../../Data/otherData/Tool.dart';

class view_product_list extends StatefulWidget {
  final requestBuyOrder order;
  const view_product_list({Key? key, required this.order}) : super(key: key);

  @override
  State<view_product_list> createState() => _view_product_listState();
}

class _view_product_listState extends State<view_product_list> {
  double total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < widget.order.productList.length; i++) {
      total = total + widget.order.productList[i].number * widget.order.productList[i].cost;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    double height = MediaQuery.of(context).size.height/3*2;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            
            Positioned(
              top: 50,
              left: 5,
              right: 5,
              child: Container(
                height: 100,
                child: Text(
                  'Tên khách hàng: ' + widget.order.owner.name + '\n' + 'Số điện thoại: ' + widget.order.owner.phone,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Positioned(
              top: 100,
              left: 5,
              right: 5,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.3),
                    border: Border(
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
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: (width - 70)/4,
                              child: Padding(
                                padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                                child: Text(
                                  'Tên SP',
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
                                  'SL',
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: (width - 70)/4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 3, right: 3),
                                child: Text(
                                  'Đơn vị',
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: (width - 70)/4,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 3, right: 3),
                                child: Text(
                                  'Đơn giá(VNĐ)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: (width - 70)/4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 3, right: 3),
                                child: Text(
                                  'Thành tiền(VNĐ)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      left: (width - 70)/4,
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
                      left: (width - 70)/4+30,
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
                      left: 30 + (width - 70)/2,
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
                      left: 30 + (width - 70)/2 + (width - 70)/4,
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
                      left: 30 + (width - 70)/2 + (width - 70)/2,
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
              ),
            ),

            Positioned(
              top: 150,
              left: 0,
              right: 0,
              bottom: 30,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: widget.order.productList.length == 0 ? Text('Danh sách trống',style: TextStyle(color: Colors.grey, fontSize: 12),) : ListView.builder(
                    itemCount: widget.order.productList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: item_product_in_order(width: width-10, product: widget.order.productList[index])
                      );
                    },
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 5,
              right: 0,
              child: Container(
                height: 25,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tổng : ' + getStringNumber(total) + 'VNĐ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Đóng'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
