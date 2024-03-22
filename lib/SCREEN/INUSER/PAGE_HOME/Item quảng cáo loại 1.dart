import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Ads/ADStype1.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';

class ITEMadsType1 extends StatelessWidget {
  final double width;
  final double height;
  final ADStype1 adStype1;
  const ITEMadsType1({Key? key, required this.width, required this.height, required this.adStype1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 25,
              width: width,
              child: AutoSizeText(
                compactString(30, adStype1.mainContent),
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 100,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Positioned(
            top: 35,
            left: 0,
            child: Container(
              width: width,
              height: width/(1200/630),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(adStype1.mainImage)
                )
              ),
            ),
          ),

          Positioned(
            top: 35 + width/(1200/630) + 10,
            left: 0,
            child: Container(
              width: width,
              height: 18,
              child: Container(
                height: 18,
                width: width,
                child: AutoSizeText(
                  adStype1.secondaryText,
                  style: TextStyle(
                      fontFamily: 'arial',
                      fontSize: 100,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
