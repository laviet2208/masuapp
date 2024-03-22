import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/itemsendOrder.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';

import '../../PAGE_HOME/Page giao hàng/Page chi tiết đơn giao hàng.dart';

class ItemLichsugiaohang extends StatefulWidget {
  final itemsendOrder order;
  const ItemLichsugiaohang({Key? key, required this.order}) : super(key: key);

  @override
  State<ItemLichsugiaohang> createState() => _ItemLichsugiaohangState();
}

class _ItemLichsugiaohangState extends State<ItemLichsugiaohang> {
  String status = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.status == "A") {
      status = "Đợi tài xế nhận đơn";
    }

    if (widget.order.status == "B") {
      status = "Mau tới lấy hàng";
    }

    if (widget.order.status == "C") {
      status = "Đang giao";
    }

    if (widget.order.status == "D") {
      status = "Hoàn thành";
    }

    if (widget.order.status == "F") {
      status = 'Bị hủy';
    }

    if (widget.order.status == "G") {
      status = 'Bị hủy';
    }

    if (widget.order.status == "H") {
      status = 'Bị bom';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Icons.delivery_dining_outlined,
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

            Container(height: 5,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 10,),

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
                                    image: AssetImage('assets/image/redlocation.png')
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
                              child: AutoSizeText(
                                'Địa chỉ giao hàng',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    color: Colors.black,
                                    fontSize: 200,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 10,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.order.receiver.phoneNum[0] == '0' ? (widget.order.receiver.phoneNum) : ('0' + widget.order.receiver.phoneNum),
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ),

                    Container(height: 5,),

                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.order.receiver.location.firstText + ',' + widget.order.receiver.location.secondaryText,
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    Container(height: 10,),
                  ],
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Container(
                height: 0.5,
                decoration: BoxDecoration(
                    color: Colors.grey
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
                        getStringNumber(widget.order.cost + widget.order.itemdetails.codFee) + '.đ',
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
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context) => Pagechitietdongiaohang(id: widget.order.id, diemdon: widget.order.locationset, diemtra: widget.order.receiver.location, type: 2,)));
      },
    );
  }
}
