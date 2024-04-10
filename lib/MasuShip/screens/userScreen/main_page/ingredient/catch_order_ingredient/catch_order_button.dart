import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/type_two_bike_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_page/ingredient/catch_order_ingredient/catch_order_ingredient_controller.dart';

import '../../../bike_screen/type_one_bike_screen/type_one_bike_wait.dart';
import 'catch_order_ingredient_dialog.dart';

class catch_order_button extends StatefulWidget {
  const catch_order_button({super.key});

  @override
  State<catch_order_button> createState() => _catch_order_buttonState();
}

class _catch_order_buttonState extends State<catch_order_button> {
  bool loading = false;
  bool loading1 = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: (width - 90)/2,
        height: (width - 90)/2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
              spreadRadius: 5, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              bottom: (width - 90)/6,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/image/iconbike.png')
                      )
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                height: (width - 90)/8 - 20,
                alignment: Alignment.center,
                child: !loading ? AutoSizeText(
                  'Gọi xe ôm',
                  style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 100,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ) : Container(width: (width - 90)/8 - 20, alignment: Alignment.center, child: CircularProgressIndicator(color: Colors.black,),),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        setState(() {
          loading = true;
        });
        if (await catch_order_ingredient_controller.check_if_no_have_order()) {
          showDialog(
            context: context,
            builder: (context) {
              return catch_order_ingredient_dialog();
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Bạn đã có đơn rồi', style: TextStyle(fontFamily: 'muli'),),
                content: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/image/bikeLogo1.png'),
                    )
                  ),
                  alignment: Alignment.center,
                ),
                actions: <Widget>[
                  !loading1 ? TextButton(
                    onPressed: () async {
                      setState(() {
                        loading1 = true;
                      });
                      String id = await catch_order_ingredient_controller.get_un_complete_order_id();
                      int type = await catch_order_ingredient_controller.get_un_complete_order_type(id);
                      setState(() {
                        loading1 = false;
                      });
                      if (type == 1) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_one_bike_wait(orderId: id)));
                      }
                      if (type == 2) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_two_bike_wait(orderId: id)));
                      }
                      if (type == 3) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_three_bike_wait(id: id)));
                      }
                    },
                    child: Text(
                      'Đi đến xem đơn',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: 'muli'
                      ),
                    ),
                  ) : CircularProgressIndicator(color: Colors.blueAccent,),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Đóng',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'muli'
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        setState(() {
          loading = false;
        });
      },
    );
  }
}
