import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../GENERAL/ShopUser/accountShop.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../RESTAURANT/SCREENshopview.dart';
class ITEMnearsrestaurant extends StatelessWidget {
  final accountShop currentshop;
  final double distance;
  const ITEMnearsrestaurant({Key? key, required this.currentshop, required this.distance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 165,
        height: 249,
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
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
              left: 11,
              child: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/tickicon.png')
                    )
                ),
              ),
            ),

            Positioned(
              top: 170,
              left: 30,
              child: Container(
                width: 156,
                height: 18,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  compactString(13, currentshop.name),
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Color(0xff000000),
                      fontSize: 150,
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
                height: 14,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  'Quán siêu gần bạn',
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.deepOrange,
                      fontSize: 130,
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
            ),

            Positioned(
              top: 214,
              right: 10,
              child: Container(
                width: 70,
                height: 16,
                alignment: Alignment.centerRight,
                child: AutoSizeText(
                  distance.toStringAsFixed(2).toString() + ' Km',
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 130,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (currentshop.OpenStatus == 0) {
          toastMessage('Cửa hàng đang đóng cửa');
        } else {
          DateTime openTime = DateTime(2000,1,1,currentshop.openTime.hour,currentshop.openTime.minute);
          DateTime closeTime = DateTime(2000,1,1,currentshop.closeTime.hour,currentshop.closeTime.minute);
          if (isCurrentTimeInRange(openTime, closeTime)) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopview(currentShop: currentshop.id)));
          } else {
            toastMessage('Cửa hàng đã đóng cửa');
          }
        }
      },
    );
  }
}
