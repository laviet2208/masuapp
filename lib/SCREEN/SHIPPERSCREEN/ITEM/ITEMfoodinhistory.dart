import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Order/foodOrder.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../../OTHER/Button/Buttontype1.dart';


class ITEMfoodinhistory extends StatelessWidget {
  final foodOrder order;
  final double width;
  final double height;
  const ITEMfoodinhistory({Key? key, required this.order, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool accecpt = false;
    double height1 = height;
    Future<void> changeStatus(String sta, String time) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/foodOrder/' + order.id + '/status').set(sta);
        databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/foodOrder/' + order.id + '/' + time).set(getCurrentTime().toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeMoney(double money) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('normalUser/' + order.owner.id + '/totalMoney').set(money);
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    void copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text));
    }


    String destination = '';
    if (order.locationGet.firstText == 'NA') {
      destination = order.locationGet.Latitude.toString() + ' , ' + order.locationGet.Longitude.toString();
    } else {
      destination = order.locationGet.firstText;
    }

    String locationSet = '';
    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    if (order.locationSet.firstText == 'NA') {
      locationSet = order.locationSet.Latitude.toString() + ' , ' + order.locationSet.Longitude.toString();
    } else {
      locationSet = order.locationSet.firstText;
    }

    ///Phần button
    //nút hủy đơn
    Color cancelbtnColor = Colors.white;
    Color acceptbtnColor = Color.fromARGB(255, 0, 177, 79);
    String cancelText = 'Hủy đơn';
    String acceptText = 'Nhận đơn';

    ///phần trạng thái
    String status = '';
    if (order.status == "C") {
      status = "Hãy tới nhà hàng lấy đồ ăn";
      statusColor = Colors.orange;
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Đã lấy món';
    }

    if (order.status == "D") {
      status = "Đang ship tới cho khách";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      cancelbtnColor = Colors.redAccent;
      cancelText = 'Khách không nhận';
      acceptText = 'Hoàn thành';
    }

    if (order.status == "D1") {
      status = "Đã hoàn thành";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      height1 = 270;
      acceptText = 'Hoàn thành';
    }

    if (order.status == "H") {
      status = "Đã bị người dùng hủy";
      statusColor = Colors.redAccent;
      height1 = 270;
      acceptText = 'Hoàn thành';
    }

    if (order.status == "J") {
      status = "Người nhận không nhận";
      statusColor = Colors.redAccent;
      height1 = 270;
      acceptText = 'Hoàn thành';
    }

    if (order.status == "I") {
      status = 'Bị hủy bởi bạn';
      statusColor = Colors.redAccent;
      height1 = 270;
      acceptText = 'Hoàn thành';
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
          Container(height: 10,),

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
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(height: 10,),

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
                        color: Colors.black,
                        fontWeight: FontWeight.normal, // Để viết bình thường
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(height: 10,),

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
                      text: 'SĐT người nhận : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: (order.owner.phoneNum[0] == '0') ? order.owner.phoneNum : ('0' + order.owner.phoneNum), // Phần còn lại viết bình thường
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

          Container(height: 10,),

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
                      text: 'Nhà hàng : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: order.productList[0].owner.name, // Phần còn lại viết bình thường
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

          Container(height: 10,),

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
                      text: 'Giá trị hàng : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(order.cost) + '.đ', // Phần còn lại viết bình thường
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

          Container(height: 10,),

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
                      text: getStringNumber(order.shipcost) + '.đ'  + " (- " + getStringNumber(order.voucher.totalmoney) + (order.voucher.type == 1 ? '%)' : 'đ)'), // Phần còn lại viết bình thường
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

          Container(height: 10,),

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
                      text: getStringNumber(order.shipcost * (order.costBiker.discount/100)) + '.đ (chiết khấu ' + order.costBiker.discount.toInt().toString() + '%)', // Phần còn lại viết bình thường
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

          Container(height: 10,),

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
                      text: 'Trừ tạm thời : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(order.cost * (order.costFee.discount/100)) + '.đ (' + order.costFee.discount.toInt().toString() + '%)', // Phần còn lại viết bình thường
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

          Container(height: 10,),

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

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              child: ButtonType1(Height: (order.status == 'C' || order.status == 'D') ? 35 : 0, Width: width - 40, color: Color.fromARGB(255, 0, 177, 79), radiusBorder: 5, title: acceptText, fontText: 'arial', colorText: Colors.white,
                  onTap: () async {
                    if (order.status == 'C') {
                      await changeStatus('D','S3time');
                    }

                    if (order.status == 'D') {
                      await changeStatus('D1','S4time');
                    }
                  }),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              child: ButtonType1(Height: (order.status == 'C' || order.status == 'D') ? 35 : 0, Width: width-40, color: cancelbtnColor, radiusBorder: 5, title: cancelText, fontText: 'arial', colorText: Colors.white,
                  onTap: () async {
                    if (order.status == 'C') {
                      toastMessage('đang hủy đơn');
                      await changeStatus('I','S5time');
                      toastMessage('đã hủy đơn');
                    }

                    if (order.status == 'D') {
                      await changeStatus('J','S5time');
                    }
                  }),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
                height: (order.status == 'C' || order.status == 'D') ? 40 : 0,
                child: Row(
                  children: [
                    GestureDetector(
                        child:Container(
                          width: (width - 65)/3,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Nhà hàng',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'arial',
                              color: Colors.white,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ),
                        onTap: () {
                          copyToClipboard(order.productList[0].name);
                          toastMessage('đã copy nhà hàng');
                        }),


                    Container(width: 10,),

                    GestureDetector(
                        child:Container(
                          width: (width - 65)/3,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Điểm giao',
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
                          toastMessage('đã copy điểm giao');
                        }
                    ),
                  ],
                )
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
