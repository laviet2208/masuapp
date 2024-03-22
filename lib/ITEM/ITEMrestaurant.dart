import 'package:flutter/material.dart';

import '../GENERAL/ShopUser/accountShop.dart';
import '../GENERAL/Tool/Tool.dart';


class ITEMrestaurant extends StatelessWidget {
  final accountShop currentshop;
  const ITEMrestaurant({Key? key, required this.currentshop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: 165,
      height: 249,
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 2, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 13,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(

              ),
              child: Image.network(currentshop.avatarID,fit: BoxFit.cover),
            ),
          ),

          Positioned(
            top: 170,
            left: 13,
            child: Container(
              width: 156,
              alignment: Alignment.centerLeft,

              child: Text(
                compactString(16, currentshop.name),
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Color(0xff000000),
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Positioned(
            top: 190,
            left: 13,
            child: Container(
              width: 156,
              alignment: Alignment.centerLeft,

              child: Text(
                'Quán ngon, bổ , rẻ',
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Colors.deepOrange,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Positioned(
            top: 214,
            left: 13,
            child: Container(
              width: 130,
              height: 17,
              alignment: Alignment.centerLeft,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 11,
                        height: 11,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/nowshopping-493ca.appspot.com/o/icon%2Fstar.png?alt=media&token=15f73b76-62ab-46fc-98f0-af7600f40936',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      left: 14,
                      child: Container(
                          child: Text(
                            "5.0",
                            style: TextStyle(
                                fontFamily: 'Dmsan_regular',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal
                            ),
                          )
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
