import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';

import '../../../Data/otherData/Tool.dart';

class item_voucher_select extends StatefulWidget {
  final Voucher voucher;
  final VoidCallback event;
  const item_voucher_select({super.key, required this.voucher, required this.event});

  @override
  State<item_voucher_select> createState() => _item_voucher_selectState();
}

class _item_voucher_selectState extends State<item_voucher_select> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    return Container(
      width: width,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
            color: Colors.black,
            width: 0.2
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 2, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 8,
          ),

          Container(
            height: 20,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 10,
                  child: Icon(
                    Icons.discount,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),

                Positioned(
                    top: 2,
                    left: 40,
                    child: Container(
                      height: 16,
                      width: width - 40 - 20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        widget.voucher.eventName,
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 200,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),

          Container(
            height: 8,
          ),

          Container(
            height: 0.5,
            decoration: BoxDecoration(
                color: Colors.grey
            ),
          ),

          Container(
            height: 8,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              height: 16,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                widget.voucher.id,
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 200,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey
                ),
              ),
            ),
          ),

          Container(
            height: 4,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                'Áp dụng cho đơn từ ' + getStringNumber(widget.voucher.mincost) + 'đ',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 200,
                    fontWeight: FontWeight.normal,
                    color: Colors.black
                ),
              ),
            ),
          ),

          Container(
            height: 2,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                'Giảm giá vào đơn ' + getStringNumber(widget.voucher.Money) + (widget.voucher.type == 0 ? '%' : 'đ') + (widget.voucher.type == 0 ? ' , tối đa ' + getStringNumber(widget.voucher.maxSale) + 'đ' : ''),
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 200,
                    fontWeight: FontWeight.normal,
                    color: Colors.black
                ),
              ),
            ),
          ),

          Container(
            height: 2,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 15,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  AutoSizeText(
                    'Hạn sử dụng ',
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 200,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey
                    ),
                  ),

                  AutoSizeText(
                    widget.voucher.endTime.day.toString() + '/' + widget.voucher.endTime.month.toString() + '/' + widget.voucher.endTime.year.toString(),
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 200,
                        fontWeight: FontWeight.normal,
                        color: Colors.redAccent
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 5,
          ),

          Container(
            height: 14,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 10,
                    child: GestureDetector(
                      child: Container(
                        height: 14,
                        width: width - 40 - 20,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Chọn voucher',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 200,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue
                          ),
                        ),
                      ),
                      onTap: widget.event,
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
