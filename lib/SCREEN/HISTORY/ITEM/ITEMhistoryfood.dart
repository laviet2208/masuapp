import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../GENERAL/Order/foodOrder.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../Đánh giá/EvaluateDialog.dart';

class ITEMhistoryfood extends StatefulWidget {
  final foodOrder order;
  final double width;
  final double height;
  final VoidCallback onTap;
  const ITEMhistoryfood({Key? key, required this.order, required this.width, required this.height, required this.onTap}) : super(key: key);

  @override
  State<ITEMhistoryfood> createState() => _ITEMhistoryfoodState();
}

class _ITEMhistoryfoodState extends State<ITEMhistoryfood> {
  bool check = true;

  void getData(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('Evaluate').orderByChild('orderCode').equalTo(id).once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      check = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    String destination = '';
    if (widget.order.locationGet.firstText == 'NA') {
      destination = 'Chuyến đi tới điểm ' + widget.order.locationGet.Latitude.toString() + ' , ' + widget.order.locationGet.Longitude.toString();
    } else {
      destination = 'Chuyến đi tới ' + widget.order.locationGet.firstText;
    }

    Color buttonColor = Colors.redAccent;
    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    String status = '';
    if (widget.order.status == "A") {
      status = "Đang đợi nhà hàng xác nhận";
      statusColor = Colors.orange;
      buttonColor = Colors.redAccent;
    }

    if (widget.order.status == "B") {
      status = "Đã xác nhận , đợi tài xế lấy";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.redAccent;
    }

    if (widget.order.status == "C") {
      status = "Tài xế đã nhận đơn và tới quán";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.white;
    }

    if (widget.order.status == "D") {
      status = "Tài xế đã lấy đươc món ăn và đang tới";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.redAccent;
    }

    if (widget.order.status == "D1") {
      status = "Đơn hàng hoàn tất";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.white;
    }

    if (widget.order.status == "I") {
      status = 'Bị hủy bởi shipper';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    if (widget.order.status == "F") {
      status = 'Quán không xác nhận';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    if (widget.order.status == "E" || widget.order.status == "G" || widget.order.status == "H") {
      status = 'Bị hủy bởi bạn';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    if (widget.order.status == "J") {
      status = 'Bị bom bởi bạn';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    if (widget.order.status == "H1") {
      status = 'Bị hủy bởi Admin';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image/iconfood.png')
                  )
              ),
            ),
          ),

          Positioned(
            top: 10,
            left: 70,
            child: Container(
              width: widget.width/2,
              height: 60,
              decoration: BoxDecoration(

              ),
              child: Text(
                compactString(33, destination),
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87
                ),
              ),
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: widget.width/2 - 10 - 70,
              height: 60,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(

              ),
              child: Text(
                getStringNumber(widget.order.cost + widget.order.shipcost) + 'đ',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87
                ),
              ),
            ),
          ),

          Positioned(
            top: 63,
            left: 70,
            child: Container(
              width: widget.width/3*2,
              height: 20,
              decoration: BoxDecoration(

              ),
              child: Text(
                getAllTimeString(widget.order.S1time),
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey
                ),
              ),
            ),
          ),

          Positioned(
            top: 85,
            left: 70,
            child: Container(
              width: widget.width - 80,
              height: 20,
              decoration: BoxDecoration(

              ),
              child: Text(
                compactString(25, widget.order.productList[0].owner.name),
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 177, 79)
                ),
              ),
            ),
          ),

          Positioned(
            top: 110,
            left: 70,
            child: Container(
              width: widget.width - 80,
              height: 20,
              decoration: BoxDecoration(

              ),
              child: Text(
                status,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor
                ),
              ),
            ),
          ),

          Positioned(
              top: 110,
              left: widget.width -80,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  height: (widget.order.status == 'A' || widget.order.status == 'B') ? 20 : 0,
                  decoration: BoxDecoration(

                  ),
                  child: Text(
                    'Hủy đơn',
                    style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: buttonColor
                    ),
                  ),
                ),
              )
          ),

          Positioned(
            bottom: 0,
            left: 40,
            child: Container(
              width: widget.width - 80,
              height: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
                height: (widget.order.status == 'D1' && check) ? null : 0,
                child: TextButton(
                    onPressed: () {
                      showBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return EvaluateDialog(width: widget.width, height: widget.height, receiver: widget.order.productList[0].owner.id, orderCode: widget.order.id, type: 2,);
                        },
                      );
                    },
                    child: Text('Đánh giá', style: TextStyle(color: Colors.blue, fontSize: 16),)
                )
            ),
          ),
        ],
      ),
    );
  }
}

