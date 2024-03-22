import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/historyTransaction.dart';

class Itemthaydoisodu extends StatefulWidget {
  final double width;
  final historyTransaction transaction;
  const Itemthaydoisodu({Key? key, required this.width, required this.transaction}) : super(key: key);

  @override
  State<Itemthaydoisodu> createState() => _ItemthaydoisoduState();
}

class _ItemthaydoisoduState extends State<Itemthaydoisodu> {
  String moneyText = '';
  Color colorText = Colors.blueGrey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.transaction.type == 5 || widget.transaction.type == 8) {
      moneyText = '- ' + getStringNumber(widget.transaction.money) + 'đ';
      colorText = Colors.redAccent;
    } else {
      moneyText = '+ ' + getStringNumber(widget.transaction.money) + 'đ';
      colorText = Colors.lightGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
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
              width: widget.width-80,
              height: 17,
              decoration: BoxDecoration(

              ),
              child: AutoSizeText(
                widget.transaction.type == 5 ? 'Chiết khấu đơn hàng' : (widget.transaction.type == 6 ? 'Hoàn chiết khấu' : (widget.transaction.type == 7 ? 'Cộng tiền khuyến mãi' : (widget.transaction.type == 8 ? 'Trừ tiền đơn nhà hàng' : 'Hoàn tiền nhà hàng'))),
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
              width: widget.width-80,
              height: 17,
              decoration: BoxDecoration(

              ),
              child: AutoSizeText(
                widget.transaction.id,
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
              width: widget.width-80,
              height: 15,
              decoration: BoxDecoration(

              ),
              child: AutoSizeText(
                getAllTimeString(widget.transaction.transactionTime),
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
              width: widget.width-40,
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
