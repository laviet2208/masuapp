import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/itemsendOrder.dart';

import '../../../GENERAL/Tool/Tool.dart';
import '../../Đánh giá/EvaluateDialog.dart';

class ITEMhistorysend extends StatefulWidget {
  final itemsendOrder order;
  final double width;
  final double height;
  final VoidCallback onTap;

  const ITEMhistorysend({Key? key, required this.order, required this.width, required this.height, required this.onTap}) : super(key: key);

  @override
  State<ITEMhistorysend> createState() => _ITEMhistorysendState();
}

class _ITEMhistorysendState extends State<ITEMhistorysend> {
  bool check = true;

  void getData(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('Evaluate').orderByChild('orderCode').equalTo(id).once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      print('Data :    ' + catchOrderData.toString());
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
    if (widget.order.receiver.location.firstText == 'NA') {
      destination = 'Giao tới điểm ' + widget.order.receiver.location.Latitude.toString() + ' , ' + widget.order.receiver.location.Longitude.toString();
    } else {
      destination = 'Giao tới ' + widget.order.receiver.location.firstText;
    }

    String receiver = '';
    receiver = "Người nhận : " + widget.order.receiver.name;

    Color buttonColor = Colors.redAccent;

    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    String status = '';
    if (widget.order.status == "A") {
      status = "Đang đợi tài xế nhận đơn";
      statusColor = Colors.orange;
      buttonColor = Colors.redAccent;
    }

    if (widget.order.status == "B") {
      status = "Tài xế " + widget.order.shipper.phoneNum + " đang đến";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.redAccent;
    }

    if (widget.order.status == "C") {
      status = "Tài xế đã nhận hàng từ bạn";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.white;
    }

    if (widget.order.status == "D") {
      status = "Hoàn thành";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      buttonColor = Colors.white;
    }

    if (widget.order.status == "G") {
      status = 'Bị hủy bởi shipper';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    if (widget.order.status == "E" ||widget.order.status == "F") {
      status = 'Bị hủy bởi bạn';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    if (widget.order.status == "H") {
      status = 'Người nhận không lấy hàng';
      statusColor = Colors.redAccent;
      buttonColor = Colors.white;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(

      ),
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
                      image: AssetImage('assets/image/linhtinh5.png')
                  )
              ),
            ),
          ),

          Positioned(
            top: 10,
            left: 70,
            child: Container(
              width: widget.width/2,
              height: 50,
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
                getStringNumber(widget.order.cost) + 'đ',
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
                compactString(25, receiver),
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
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
            right: 10,
            child: Container(
                height: (widget.order.status == 'D' && check) ? null : 0,
                child: TextButton(
                    onPressed: () {
                      showBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return EvaluateDialog(width: widget.width, height: widget.height, receiver: widget.order.shipper.id, orderCode: widget.order.id, type: 1,);
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

