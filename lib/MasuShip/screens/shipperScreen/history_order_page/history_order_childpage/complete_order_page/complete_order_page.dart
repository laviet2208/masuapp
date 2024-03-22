import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/complete_order_page/complete_buy_request_order_page.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/complete_order_page/complete_catch_order_page.dart';

import '../../history_order_item/complete_item/complete_buy_request_order_item.dart';

class complete_order_page extends StatefulWidget {
  const complete_order_page({Key? key}) : super(key: key);

  @override
  State<complete_order_page> createState() => _complete_order_pageState();
}

class _complete_order_pageState extends State<complete_order_page> {
  int orderType = 1;

  Widget get_body_widget(int index) {
    if (index == 1) {
      return complete_catch_order_page();
    }

    if (index == 2) {
      return complete_buy_request_order_page();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    width: 5,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: GestureDetector(
                      child: Container(
                        width: (width - 40)/2,
                        decoration: BoxDecoration(
                            color: orderType == 1 ? Colors.yellow : Colors.transparent,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            'Đơn xe ôm',
                            style: TextStyle(
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          orderType = 1;
                        });
                      },
                    ),
                  ),

                  Container(
                    width: 10,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: GestureDetector(
                      child: Container(
                        width: (width - 40)/2,
                        decoration: BoxDecoration(
                            color: orderType == 2 ? Colors.yellow : Colors.transparent,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            'Đơn mua hộ',
                            style: TextStyle(
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          orderType = 2;
                        });
                      },
                    ),
                  ),

                  Container(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 60,
            bottom: 10,
            left: 10,
            right: 10,
            child: get_body_widget(orderType),
          )
        ],
      ),
    );
  }
}
