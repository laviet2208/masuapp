import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Page%20L%E1%BB%8Bch%20s%E1%BB%AD%20%C4%91i%20ch%E1%BB%A3.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Page%20l%E1%BB%8Bch%20s%E1%BB%AD%20%20g%E1%BB%8Di%20xe.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Page%20l%E1%BB%8Bch%20s%E1%BB%AD%20%C4%91%E1%BB%93%20%C4%83n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Page%20l%E1%BB%8Bch%20s%E1%BB%AD%20Giao%20h%C3%A0ng.dart';

class Pagelichsu extends StatefulWidget {
  const Pagelichsu({Key? key}) : super(key: key);

  @override
  State<Pagelichsu> createState() => _PagelichsuState();
}

class _PagelichsuState extends State<Pagelichsu> {
  int index = 0;
  
  Widget getWidget() {
    if (index == 0) {
      return Pagelichsugiaohang();
    }

    if (index == 1) {
      return Pagelichsudoan();
    }

    if (index == 2) {
      return Pagelichsugoixe();
    }

    if (index == 3) {
      return Pagelichsudicho();
    }

    return Container();
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 8,
              child: Container(
                width: screenWidth-16,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: Colors.red
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: (screenWidth-16-25-5)/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == 0 ? Colors.red : Colors.white
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Giao hàng',
                            style: TextStyle(
                              fontFamily: 'roboto',
                              color: index == 0 ? Colors.white : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),

                      Container(
                        width: 7,
                      ),

                      GestureDetector(
                        child: Container(
                          width: (screenWidth-16-25-5)/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == 1 ? Colors.red : Colors.white
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Đồ ăn',
                            style: TextStyle(
                                fontFamily: 'roboto',
                                color: index == 1 ? Colors.white : Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      ),

                      Container(
                        width: 7,
                      ),

                      GestureDetector(
                        child: Container(
                          width: (screenWidth-16-25-5)/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == 2 ? Colors.red : Colors.white
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Gọi xe',
                            style: TextStyle(
                                fontFamily: 'roboto',
                                color: index == 2 ? Colors.white : Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                      ),

                      Container(
                        width: 7,
                      ),

                      GestureDetector(
                        child: Container(
                          width: (screenWidth-16-25-5)/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == 3 ? Colors.red : Colors.white
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Đi chợ',
                            style: TextStyle(
                                fontFamily: 'roboto',
                                color: index == 3 ? Colors.white : Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 3;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            Positioned(
              top: 70,
              bottom: 10,
              left: 15,
              right: 15,
              child: getWidget(),
            )
          ],
        ),
      ),
    );
  }
}
