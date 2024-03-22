import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Order/catchOrder.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../../OTHER/Button/Buttontype1.dart';


class ITEMcatchinhistory extends StatelessWidget {
  final catchOrder order;
  final double width;
  final double height;
  const ITEMcatchinhistory({Key? key, required this.order, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool accecpt = false;
    double height1 = height;
    Future<void> changeStatus(String sta, String time) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/catchOrder/' + order.id + '/status').set(sta);
        databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/catchOrder/' + order.id + '/' + time).set(getCurrentTime().toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeShipper(accountNormal ship) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/catchOrder/' + order.id + '/shipper').set(ship.toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text));
    }

    String imageType = '';
    if (order.type == 1) {
      imageType = 'assets/image/iconbike.png';
    } else {
      imageType = 'assets/image/icontransport.png';
    }

    String destination = '';
    destination = order.locationGet.firstText.toString() + ' , ' + order.locationGet.secondaryText.toString();

    String locationSet = '';
    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    locationSet = order.locationSet.firstText.toString() + ' , ' + order.locationSet.secondaryText.toString();

    ///Phần button
    //nút hủy đơn
    Color cancelbtnColor = Colors.white;
    Color acceptbtnColor = Color.fromARGB(255, 0, 177, 79);
    String acceptText = 'Nhận đơn';

    ///phần trạng thái
    String status = '';
    if (order.status == "B") {
      status = "Đang tới đón khách";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Đã đón khách';
    }

    if (order.status == "C") {
      status = "Hành trình bắt đầu";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      acceptText = 'Hoàn thành';
    }

    if (order.status == "D") {
      status = "Hoàn thành";
      acceptText = 'Đã hoàn thành';
      statusColor = Color.fromARGB(255, 0, 177, 79);
      height1 = 230;
    }

    if (order.status == "E" ||order.status == "F") {
      status = 'Bị hủy bởi khách hàng';
      cancelbtnColor = Colors.white;
      acceptText = 'đã bị hủy';
      acceptbtnColor = Colors.redAccent;
      statusColor = Colors.redAccent;
    }

    if (order.status == "G") {
      status = 'Bị hủy bởi bạn';
      cancelbtnColor = Colors.white;
      acceptText = 'đã bị hủy';
      acceptbtnColor = Colors.redAccent;
      statusColor = Colors.redAccent;
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
                      text: 'Điểm trả khách : ',
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
                      text: 'Điểm đón khách : ',
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
                      text: 'Số điện thoại : ',
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
                      text: 'Tên khách hàng : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: order.owner.name, // Phần còn lại viết bình thường
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
                      text: 'Giá trị đơn hàng : ',
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
                      text: 'Trạng thái : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: status, // Phần còn lại viết bình thường
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        color: statusColor,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            height: (order.status == 'B' || order.status == 'C') ? 20 : 0,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Container(
                height: (order.status == 'B' || order.status == 'C') ? 35 : 0,
                child: ButtonType1(Height: (order.status == 'B' || order.status == 'C') ? 35 : 0, Width: width-40, color: acceptbtnColor, radiusBorder: 5, title: acceptText, fontText: 'arial', colorText: Colors.white,
                    onTap: () async {
                      if (order.status == 'B') {
                        toastMessage('đã đón khách');
                        await changeStatus('C', 'S3time');
                      } else if (order.status == 'C') {
                        toastMessage('đã hoàn thành');
                        await changeStatus('D', 'S4time');
                      } else if (order.status == 'D') {
                        toastMessage('Đơn đã hoàn thành rồi');
                      }
                    }),
              ),
            ),
          ),

          Container(
            height: 5,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Container(
                child: ButtonType1(Height: order.status == 'B' ? 35 : 0, Width: width-40, color: cancelbtnColor, radiusBorder: 5, title: 'Hủy đơn', fontText: 'arial', colorText: Colors.white,
                    onTap: () async {
                      if (order.status == 'B') {
                        toastMessage('đang hủy đơn');
                        await changeShipper(currentAccount);
                        await changeStatus('G', 'S4time');
                        toastMessage('đã hủy đơn');
                      }
                    }),
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
                height: (order.status == 'B' || order.status == 'C') ? 35 : 0,
                child: Row(
                  children: [
                    GestureDetector(
                        child:Container(
                          width: (width - 65)/3,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Số điện thoại',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'arial',
                              color: Colors.white,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ),
                        onTap: () {
                          copyToClipboard((order.owner.phoneNum[0] == '0') ? order.owner.phoneNum : ('0' + order.owner.phoneNum));
                          toastMessage('đã copy số điện thoại');
                        }
                    ),

                    Container(width: 10,),

                    GestureDetector(
                        child:Container(
                          width: (width - 65)/3,
                          height: (order.status == 'B' || order.status == 'C') ? 35 : 0,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Điểm đón',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'arial',
                              color: Colors.white,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ),
                        onTap: () {
                          copyToClipboard(locationSet);
                          toastMessage('đã copy điểm đón');
                        }),


                    Container(width: 5,),

                    GestureDetector(
                        child:Container(
                          width: (width - 65)/3,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Điểm đến',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'arial',
                              color: Colors.white,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ),
                        onTap: () {
                          copyToClipboard(destination);
                          toastMessage('đã copy điểm đến');
                        }
                    ),
                  ],
                )
            ),
          ),

          Container(
            height: (order.status == 'B' || order.status == 'C') ? 20 : 0,
          ),
        ],
      ),
    );
  }
}
