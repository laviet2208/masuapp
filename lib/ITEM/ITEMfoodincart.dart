import 'package:flutter/material.dart';

import '../GENERAL/Product/Product.dart';
import '../GENERAL/Tool/Tool.dart';


class ITEMfoodincart extends StatefulWidget {
  final Product food;
  final double width;
  final VoidCallback onTap;
  const ITEMfoodincart({Key? key, required this.food, required this.width, required this.onTap}) : super(key: key);

  @override
  State<ITEMfoodincart> createState() => _ITEMfoodincartState();
}

class _ITEMfoodincartState extends State<ITEMfoodincart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
            top: 10,
            left: 10,
            child: Text(
              compactString(20, widget.food.name),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'arial',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 10,
            child: Text(
              compactString(29, widget.food.owner.name),
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'arial',
                  color: Color.fromARGB(255, 244, 164, 84),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              'Giá tiền : ' + getStringNumber(widget.food.cost) + '.đ',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'arial',
                  color: Color.fromARGB(255, 244, 164, 84),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            top: 5,
            right: 45,
            child: Container(
              width: widget.width/4 - 20,
              height: widget.width/4 - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.food.imageList[0])
                )
              ),
            ),
          ),

          Positioned(
            top: (widget.width/4 - 40)/2,
            right: 5,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/garbageicon.png')
                    )
                ),
              ),
            ),
          ),

          Positioned(
            top: 15,
            right: 40,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.food.imageList)
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
