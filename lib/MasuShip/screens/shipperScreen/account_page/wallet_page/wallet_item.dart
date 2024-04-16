import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/historyData/historyTransactionData.dart';

import '../../../../Data/otherData/Tool.dart';

class wallet_item extends StatefulWidget {
  final historyTransactionData data;
  const wallet_item({Key? key, required this.data}) : super(key: key);

  @override
  State<wallet_item> createState() => _wallet_itemState();
}

class _wallet_itemState extends State<wallet_item> {
  String moneyText = '';
  Color colorText = Colors.blueGrey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data.type == 5 || widget.data.type == 9) {
      moneyText = '- ' + getStringNumber(widget.data.money) + 'đ';
      colorText = Colors.redAccent;
    } else {
      moneyText = '+ ' + getStringNumber(widget.data.money) + 'đ';
      colorText = Colors.lightGreen;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    return Container(
      width: width,
      height: 80,
      decoration: BoxDecoration(

      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 25,
            left: 10,
            child: Icon(
              Icons.list_alt_sharp,
              size: 30,
              color: Colors.blueAccent,
            ),
          ),

          Positioned(
            top: 10,
            left: 50,
            child: Container(
              width: width-80,
              height: 17,
              decoration: BoxDecoration(

              ),
              child: AutoSizeText(
                widget.data.type == 5 ? 'Chiết khấu đơn hàng' : (widget.data.type == 6 ? 'Hoàn chiết khấu' : (widget.data.type == 7 ? 'Cộng tiền khuyến mãi' : (widget.data.type == 9 ? 'Trừ tiền đơn nhà hàng' : 'Hoàn tiền nhà hàng'))),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'arial',
                    fontSize: 140
                ),
              ),
            ),
          ),

          Positioned(
            top: 35,
            left: 50,
            child: Container(
              width: width-80,
              height: 17,
              decoration: BoxDecoration(

              ),
              child: AutoSizeText(
                widget.data.id,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontFamily: 'arial',
                    fontSize: 140
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            left: 50,
            child: Container(
              width: width-80,
              height: 15,
              decoration: BoxDecoration(

              ),
              child: AutoSizeText(
                getAllTimeString(widget.data.transactionTime),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontFamily: 'arial',
                    fontSize: 140
                ),
              ),
            ),
          ),

          Positioned(
              bottom: 5,
              right: 10,
              child: Text(
                moneyText,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    color: colorText,
                    fontWeight: FontWeight.normal
                ),
              )
          ),

          Positioned(
            bottom: 0,
            left: 20,
            child: Container(
              width: width-40,
              height: 0.7,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ],
      ),
    );
  }
}
