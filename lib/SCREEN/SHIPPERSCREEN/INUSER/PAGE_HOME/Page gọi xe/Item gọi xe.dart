import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/catchOrder.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/Product/Voucher.dart';
import '../../../../../GENERAL/Tool/Tool.dart';
import '../../../../INUSER/PAGE_HOME/Tính khoảng cách.dart';

class Itemgoixe extends StatefulWidget {
  final double width;
  final catchOrder order;
  const Itemgoixe({Key? key, required this.width, required this.order}) : super(key: key);

  @override
  State<Itemgoixe> createState() => _ItemgoixeState();
}

class _ItemgoixeState extends State<Itemgoixe> {

  double getVoucherSale(Voucher voucher) {
    double money = 0;

    if(voucher.totalmoney < 100) {
      double mn = widget.order.cost/(1-(voucher.totalmoney/100))*(voucher.totalmoney/100);
      if (mn <= voucher.maxSale) {
        money = mn;
      } else {
        money = voucher.maxSale;
      }
    } else {
      money = voucher.totalmoney;
    }

    return money;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 15,),

          Container(
            height: 25,
            child: Row(
              children: [
                Container(width: 15,),

                Icon(
                  widget.order.type == 1 ? Icons.motorcycle_sharp : Icons.car_rental,
                  size: 25,
                  color: Colors.redAccent,
                ),

                Container(width: 10,),

                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  child: Container(
                    width: widget.width/2,
                    child: AutoSizeText(
                      'Đón khách tại',
                      style: TextStyle(
                          fontSize: 100,
                          color: Colors.grey,
                          fontFamily: 'arial'
                      ),
                    ),
                  ),
                ),

                Container(width: 10,),
              ],
            ),
          ),

          Container(height: 8,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.order.locationSet.firstText + ',' + widget.order.locationSet.secondaryText,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Container(height: 15,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Cách bạn ' + CaculateDistance.calculateDistance(widget.order.locationSet.Latitude, widget.order.locationSet.Longitude, currentLocatio.Latitude, currentLocatio.Longitude).toStringAsFixed(2) + 'km',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),


          Container(height: 15,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              height: 0.5,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),

          Container(height: 15,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
                alignment: Alignment.centerLeft,
                height: 15,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Chi phí vận chuyển',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        getStringNumber(widget.order.cost + getVoucherSale(widget.order.voucher)) + 'đ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),

          Container(height: 15,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
                alignment: Alignment.centerLeft,
                height: 15,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Chiết khấu',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        getStringNumber((widget.order.cost+getVoucherSale(widget.order.voucher)) * (widget.order.costFee.discount/100)) + '.đ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),

          Container(height: 15,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
                alignment: Alignment.centerLeft,
                height: 15,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Tài xế thực nhận',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        getStringNumber(widget.order.cost + getVoucherSale(widget.order.voucher) - ((widget.order.cost + getVoucherSale(widget.order.voucher)) * (widget.order.costFee.discount/100))) + '.đ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),

          Container(height: 15,),
        ],
      ),
    );
  }
}
