import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/general_ingredient.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../general/search_location_dialog.dart';

class item_market_location_wait extends StatefulWidget {
  final List<Location> list;
  final int index;
  const item_market_location_wait({super.key, required this.index, required this.list,});

  @override
  State<item_market_location_wait> createState() => _item_market_location_waitState();
}

class _item_market_location_waitState extends State<item_market_location_wait> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/orangecircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    height: 30,
                    width: width - 40 - 30 - 50 - 10,
                    child: AutoSizeText(
                      'Điểm mua hàng ' + (widget.index + 1).toString(),
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 200,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 50, right: 10),
            child: general_ingredient.get_location_text(widget.list[widget.index].mainText + ', ' + widget.list[widget.index].secondaryText),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
