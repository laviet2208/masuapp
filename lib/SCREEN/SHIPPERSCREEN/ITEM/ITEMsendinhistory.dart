import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Order/itemsendOrder.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../../OTHER/Button/Buttontype1.dart';


class ITEMsendhistory extends StatelessWidget {
  final itemsendOrder order;
  final double width;
  final double height;
  const ITEMsendhistory({Key? key, required this.order, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool accecpt = false;
    Future<void> changeStatus(String sta) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/itemsendOrder/' + order.id + '/status').set(sta);
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeTime(String data) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/itemsendOrder/' + order.id + '/' + data).set(getCurrentTime().toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeShipper(accountNormal ship) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/itemsendOrder/' + order.id + '/shipper').set(ship.toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text));
    }


    String destination = '';
    destination = order.receiver.location.firstText.toString() + ' , ' + order.receiver.location.secondaryText.toString();


    String locationSet = '';
    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    locationSet = order.locationset.firstText.toString() + ' , ' + order.locationset.secondaryText.toString();


    double height1 = height;

    ///Phần button
    //nút hủy đơn
    Color cancelbtnColor = Colors.white;
    String canceltext = 'Hủy đơn';
    Color acceptbtnColor = Color.fromARGB(255, 0, 177, 79);
    String acceptText = 'Nhận đơn';

    ///phần trạng thái
    String status = '';
    if (order.status == "B") {
      status = "Di chuyển tới lấy hàng";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Đã lấy hàng';
    }

    if (order.status == "C") {
      status = "Đang giao tới người nhận";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      acceptText = 'Hoàn thành';
      cancelbtnColor = Colors.redAccent;
      canceltext = 'Người nhận bom';
    }

    if (order.status == "D") {
      status = "Hoàn thành";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      height1 = 265;
    }

    if (order.status == "F") {
      status = 'Bị hủy bởi người đặt';
      statusColor = Colors.redAccent;
      cancelbtnColor = Colors.white;
      acceptText = 'Đã bị hủy';
      acceptbtnColor = Colors.redAccent;
    }

    if (order.status == "G") {
      status = 'Bị hủy bởi bạn';
      statusColor = Colors.redAccent;
      acceptText = 'Đã bị hủy';
      acceptbtnColor = Colors.redAccent;
      cancelbtnColor = Colors.white;
      height1 = 265;
    }

    if (order.status == "H") {
      status = 'Người nhận không lấy';
      statusColor = Colors.redAccent;
      statusColor = Colors.redAccent;
      cancelbtnColor = Colors.white;
      acceptText = 'Đã bị bom';
      height1 = 265;
    }


    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          Container(
            height: 20,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Mã đơn : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: order.id, // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Lấy hàng tại : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: locationSet, // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Giao tới : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: destination, // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Số điện thoại người gửi : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: order.owner.phoneNum[0] == '0' ? order.owner.phoneNum : '0' + order.owner.phoneNum, // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Số điện thoại người nhận : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: order.receiver.phoneNum[0] == '0' ? order.receiver.phoneNum : '0' + order.receiver.phoneNum, // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Phí ship : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(order.cost) + 'đ' + " ( - " + getStringNumber(order.voucher.totalmoney) + (order.voucher.type == 1 ? '%)' : 'đ)'), // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Chiết khấu : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(order.cost * (order.costFee.discount/100)) + '.đ (chiết khấu ' + order.costFee.discount.toInt().toString() + '%)', // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Thu hộ : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(order.itemdetails.codFee) + '.đ', // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: ((order.status == 'B' || order.status == 'C') ? 10 : 0),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: width - 40,
              height: ((order.status == 'B' || order.status == 'C') ? 35 : 0),
              child: ButtonType1(Height: ((order.status == 'B' || order.status == 'C') ? 35 : 0), Width: width/4, color: acceptbtnColor, radiusBorder: 5, title: acceptText, fontText: 'arial', colorText: Colors.white,
                  onTap: () async {
                    if (order.status == 'B') {
                      toastMessage('đang bắt đầu');
                      await changeStatus('C');
                      await changeTime('S3time');
                    }

                    if (order.status == 'C') {
                      toastMessage('đang hoàn thành');
                      await changeStatus('D');
                      await changeTime('S4time');
                    }
                  }),
            ),
          ),

          Container(
            height: ((order.status == 'B' || order.status == 'C') ? 10 : 0),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: width - 40,
              height: order.status == 'B' ? 35 : 0,
              child: ButtonType1(Height: order.status == 'B' ? 35 : 0, Width: width/4, color: cancelbtnColor, radiusBorder: 5, title: canceltext, fontText: 'arial', colorText: Colors.white,
                  onTap: () async {
                    if (order.status == 'B') {
                      toastMessage('đang hủy đơn');
                      await changeStatus('G');
                      await changeTime('S4time');
                      toastMessage('đã hủy đơn');
                    }

                    if (order.status == 'C') {
                      await changeStatus('H');
                      toastMessage('đã hủy đơn');
                    }
                  }),
            ),
          ),

          Container(
            height: 10,
          ),
        ],
      ),
    );
  }
}
