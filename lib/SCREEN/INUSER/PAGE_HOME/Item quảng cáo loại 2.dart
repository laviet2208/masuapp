import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../GENERAL/Ads/ADStype2.dart';

class ITEMadsType2 extends StatelessWidget {
  final double width;
  final ADStype2 adStype2;
  const ITEMadsType2({Key? key, required this.adStype2, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 249,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(adStype2.mainImage)
                )
              ),
            ),
          ),

          Positioned(
            top: width + 5,
            left: 4,
            child: Container(
              width: width - 8,
              height: width/5.5,
              child: AutoSizeText(
                adStype2.mainContent,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'arial',
                  fontSize: 100
                ),
                maxLines: 2,
              ),
            ),
          ),

          Positioned(
            top: width + 5 + width/5.5 + 3,
            left: 4,
            child: Container(
              width: width - 8,
              height: width/11,
              child: AutoSizeText(
                'Chỉ mất 1 phút đọc',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontFamily: 'arial',
                    fontSize: 100
                ),
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
