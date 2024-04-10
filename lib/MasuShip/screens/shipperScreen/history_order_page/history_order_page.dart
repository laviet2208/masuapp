import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import '../../../Data/finalData/finalData.dart';

class history_order_page extends StatefulWidget {
  const history_order_page({Key? key}) : super(key: key);

  @override
  State<history_order_page> createState() => _history_order_pageState();
}

class _history_order_pageState extends State<history_order_page> {
  int indexTab = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [finalData.shipper_account.onlineStatus == 1 ? Colors.yellow : Colors.black26,finalData.shipper_account.onlineStatus == 1 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      child: GestureDetector(
                        child: Container(
                          width: (width - 50)/2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: indexTab == 1 ? Colors.yellow : null
                          ),
                          child: Center(
                            child: Text(
                              'Đơn đang chạy',
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
                            indexTab = 1;
                          });
                        },
                      ),
                    ),

                    Positioned(
                      top: 5,
                      bottom: 5,
                      right: 10,
                      child: GestureDetector(
                        child: Container(
                          width: (width - 50)/2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: indexTab == 2 ? Colors.yellow : null
                          ),
                          child: Center(
                            child: Text(
                              'Đơn đã hoàn thành',
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
                            indexTab = 2;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 100,
              bottom: 0,
              left: 0,
              right: 0,
              child: history_controller.get_history_widget(indexTab),
            )
          ],
        ),
      ),
    );
  }
}
