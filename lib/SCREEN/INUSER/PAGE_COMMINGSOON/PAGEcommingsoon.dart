import 'package:flutter/material.dart';

class PAGEcommingsoon extends StatefulWidget {
  const PAGEcommingsoon({Key? key}) : super(key: key);

  @override
  State<PAGEcommingsoon> createState() => _PAGEcommingsoonState();
}

class _PAGEcommingsoonState extends State<PAGEcommingsoon> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white
      ),
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: screenHeight/3,
            left: (screenWidth-screenWidth/3.5)/2,
            child: Container(
              width: screenWidth/3.5,
              height: screenWidth/3.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/mainLogo.png"),
                  )
              ),
            ),
          ),

          Positioned(
            top: screenWidth/2.5 + screenHeight/3 + 10,
            left: 10,
            right: 10,
            child: Container(
              alignment: Alignment.center,
              width: screenWidth - 20,
              child: Text(
                'Tính năng đang được phát triển , vui lòng quay lại sau nhé , xin cảm ơn!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
