import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/ShopUser/accountShop.dart';
import '../../../GENERAL/Tool/Time.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../INUSER/PAGE_HOME/Tính khoảng cách.dart';
import '../SCREENstoreview.dart';
class ITEMrestaurantIndirect extends StatefulWidget {
  final String id;
  const ITEMrestaurantIndirect({Key? key, required this.id}) : super(key: key);

  @override
  State<ITEMrestaurantIndirect> createState() => _ITEMrestaurantIndirectState();
}

class _ITEMrestaurantIndirectState extends State<ITEMrestaurantIndirect> {
  final accountShop selectShop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Store/" + widget.id).onValue.listen((event) {
      final dynamic restaurant = event.snapshot.value;
        accountShop acc = accountShop.fromJson(restaurant);
        selectShop.openTime = acc.openTime;
        selectShop.closeTime = acc.closeTime;
        selectShop.createTime = acc.createTime;
        selectShop.phoneNum = acc.phoneNum;
        selectShop.id = acc.id;
        selectShop.location = acc.location;
        selectShop.status = acc.status;
        selectShop.name = acc.name;
        selectShop.avatarID = acc.avatarID;
        selectShop.isTop = acc.isTop;
        selectShop.Type = acc.Type;
      selectShop.OpenStatus = acc.OpenStatus;
        setState(() {});
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 165,
        height: 249,
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
              spreadRadius: 2, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),

        child: Stack(
          children: <Widget>[
            Positioned(
              top: 15,
              left: 13,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(

                ),
                child: Image.network(selectShop.avatarID,fit: BoxFit.cover),
              ),
            ),

            Positioned(
              top: 170,
              left: 11,
              child: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/tickicon.png')
                    )
                ),
              ),
            ),

            Positioned(
              top: 170,
              left: 30,
              child: Container(
                width: 156,
                height: 18,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  compactString(13, selectShop.name),
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Color(0xff000000),
                      fontSize: 150,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Positioned(
              top: 190,
              left: 13,
              child: Container(
                width: 156,
                height: 14,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  'Quán siêu gần bạn',
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.deepOrange,
                      fontSize: 130,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Positioned(
              top: 214,
              left: 13,
              child: Container(
                width: 130,
                height: 17,
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 11,
                          height: 11,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/nowshopping-493ca.appspot.com/o/icon%2Fstar.png?alt=media&token=15f73b76-62ab-46fc-98f0-af7600f40936',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 14,
                        child: Container(
                            child: Text(
                              "5.0",
                              style: TextStyle(
                                  fontFamily: 'Dmsan_regular',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 214,
              right: 10,
              child: Container(
                width: 70,
                height: 16,
                alignment: Alignment.centerRight,
                child: AutoSizeText(
                  CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(selectShop.location)[0], CaculateDistance.parseDoubleString(selectShop.location)[1], currentAccount.locationHis.Latitude, currentAccount.locationHis.Longitude).toStringAsFixed(2).toString() + ' Km',
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 130,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (selectShop.OpenStatus == 0) {
          toastMessage('Cửa hàng đang đóng cửa');
        } else {
          DateTime openTime = DateTime(2000,1,1,selectShop.openTime.hour,selectShop.openTime.minute);
          DateTime closeTime = DateTime(2000,1,1,selectShop.closeTime.hour,selectShop.closeTime.minute);
          if (isCurrentTimeInRange(openTime, closeTime)) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENstoreview(currentShop: widget.id,)));
          } else {
            toastMessage('Cửa hàng đã đóng cửa');
          }
        }
      },
    );
  }
}

