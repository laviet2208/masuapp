import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/catchOrder.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/SCREEN/%C4%90%C3%A1nh%20gi%C3%A1/EvaluateDialog.dart';

import '../../../GENERAL/Evaluate.dart';
import '../../../GENERAL/utils/utils.dart';

class ITEMhistorycatch extends StatefulWidget {
  final catchOrder order;
  final double width;
  final double height;
  const ITEMhistorycatch({Key? key, required this.order, required this.width, required this.height}) : super(key: key);

  @override
  State<ITEMhistorycatch> createState() => _ITEMhistorycatchState();
}

class _ITEMhistorycatchState extends State<ITEMhistorycatch> {
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
    String imageType = '';
    if (widget.order.type == 1) {
      imageType = 'assets/image/iconbike.png';
    } else {
      imageType = 'assets/image/icontransport.png';
    }

    String destination = '';
    if (widget.order.locationGet.firstText == 'NA') {
      destination = 'Chuyến đi tới điểm ' + widget.order.locationGet.Latitude.toString() + ' , ' + widget.order.locationGet.Longitude.toString();
    } else {
      destination = 'Chuyến đi tới ' + widget.order.locationGet.firstText;
    }

    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    String status = '';
    if (widget.order.status == "A") {
      status = "Đang đợi tài xế nhận đơn";
      statusColor = Colors.orange;
    }

    if (widget.order.status == "B") {
      status = "Tài xế " + widget.order.shipper.phoneNum + " đang đến";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (widget.order.status == "C") {
      status = "Hành trình bắt đầu";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (widget.order.status == "D") {
      status = "Hoàn thành";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (widget.order.status == "G") {
      status = 'Bị hủy bởi tài xế';
      statusColor = Colors.redAccent;
    }

    if (widget.order.status == "E" ||widget.order.status == "F") {
      status = 'Bị hủy bởi bạn';
      statusColor = Colors.redAccent;
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
                      image: AssetImage(imageType)
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

