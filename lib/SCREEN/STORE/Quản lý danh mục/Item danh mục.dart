import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';

import '../../RESTAURANT/Quản lý danh mục/Danh mục.dart';
import '../SCREENstoreview.dart';
import 'Item nhà hàng trong danh mục.dart';

class Itemdanhmuccuahang extends StatefulWidget {
  final double width;
  final double height;
  final RestaurantDirectory restaurantDirectory;
  const Itemdanhmuccuahang({Key? key, required this.width, required this.height, required this.restaurantDirectory}) : super(key: key);

  @override
  State<Itemdanhmuccuahang> createState() => _ItemdanhmucchinhState();
}

class _ItemdanhmucchinhState extends State<Itemdanhmuccuahang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width - 20,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.restaurantDirectory.mainIcon)
                    )
                ),
              )
          ),

          Positioned(
              top: 35,
              left: 10,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.restaurantDirectory.subIcon)
                    )
                ),
              )
          ),

          Positioned(
            top: 5,
            left: 30,
            child: Text(
              compactString(20, widget.restaurantDirectory.mainContent),
              style: TextStyle(
                  fontFamily: 'DMSans_regu',
                  color: Colors.black,
                  fontSize: widget.width/18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 30,
            child: Text(
              compactString(38, widget.restaurantDirectory.subContent),
              style: TextStyle(
                  fontFamily: 'DMSans_regu',
                  color: Colors.grey,
                  fontSize: widget.width/30,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {

              },
              child: Text(
                'See all',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color.fromRGBO(0, 99, 255, 1),
                  fontFamily: 'Dmsan_regular',
                  fontSize: widget.width / 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
          ),

          Positioned(
            top: 65,
            left: 0,
            child: Container(
              width: widget.width - 20,
              height: 248,
              decoration: BoxDecoration(
                  color: Colors.white
              ),

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.restaurantDirectory.shopList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: ITEMrestaurantIndirect(id: widget.restaurantDirectory.shopList[index]),);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
