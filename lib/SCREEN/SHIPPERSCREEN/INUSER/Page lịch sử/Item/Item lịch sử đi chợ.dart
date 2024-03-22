import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/foodOrder.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91i%20ch%E1%BB%A3/Chi%20ti%E1%BA%BFt%20%C4%91%C6%A1n%20%C4%91i%20ch%E1%BB%A3.dart';

import '../../../../../GENERAL/Tool/Tool.dart';
import '../../PAGE_HOME/Page đồ ăn/Chi tiết đơn đồ ăn.dart';

class ItemLichsudicho extends StatefulWidget {
  final foodOrder order;
  const ItemLichsudicho({Key? key, required this.order}) : super(key: key);

  @override
  State<ItemLichsudicho> createState() => _LichsudoanState();
}

class _LichsudoanState extends State<ItemLichsudicho> {
  String status = '';
  @override
  Widget build(BuildContext context) {
    if (widget.order.status == "C") {
      status = "Tới lấy hàng hóa";
    }

    if (widget.order.status == "D") {
      status = "Đang ship";
    }

    if (widget.order.status == "D1") {
      status = "Hoàn thành";
    }

    if (widget.order.status == "H") {
      status = "Đã hủy";
    }

    if (widget.order.status == "J") {
      status = "Đã hủy";
    }

    if (widget.order.status == "I") {
      status = 'Bị hủy';
    }

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
              spreadRadius: 5, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 10,),

            Container(
              height: 20,
              child: Row(
                children: [
                  Container(width: 15,),

                  Icon(
                    Icons.fastfood_outlined,
                    color: Colors.redAccent,
                    size: 20,
                  ),

                  Container(width: 5,),

                  Padding(
                    padding: EdgeInsets.only(top: 3,bottom: 3),
                    child: AutoSizeText(
                      widget.order.id,
                      style: TextStyle(
                          fontSize: 100,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'arial'
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(height: 5,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 15,
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'Nhận đơn lúc : ' + getAllTimeString(widget.order.S2time),
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontFamily: 'arial'
                  ),
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 10,),

                    Container(
                      height: 18,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 15,
                            right: 10,
                            bottom: 0,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                widget.order.productList[0].owner.name,
                                style: TextStyle(
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),


                          Positioned(
                            top: 0,
                            left: 15,
                            right: 15,
                            bottom: 0,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: AutoSizeText(
                                widget.order.productList.length.toString() + ' Món',
                                style: TextStyle(
                                    fontSize: 100,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(height: 10,),
                  ],
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              height: 30,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5,
                    bottom: 5,
                    left: 15,
                    right: 0,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Tổng cộng',
                        style: TextStyle(
                            fontSize: 100,
                            fontFamily: 'arial',
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 15,
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        child: AutoSizeText(
                          status,
                          style: TextStyle(
                              fontSize: 100,
                              fontFamily: 'arial',
                              color: Colors.white,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              height: 18,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 15,
                    right: 15,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        getStringNumber(widget.order.cost + widget.order.shipcost) + '.đ',
                        style: TextStyle(
                            fontSize: 100,
                            fontFamily: 'arial',
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(height: 10,),

            Container(height: 10,),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context) => Chitietdondicho(id: widget.order.id, diemdon: widget.order.locationSet, diemtra: widget.order.locationGet)));
      },
    );
  }
}
