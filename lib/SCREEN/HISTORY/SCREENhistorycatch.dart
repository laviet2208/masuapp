import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/NormalUser/accountNormal.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/Order/catchOrder.dart';
import '../FEATURE/SCREEN_BIKEORDER/Chi tiết lịch sử.dart';
import '../FEATURE/SCREEN_BIKEORDER/SCREEN_waitbiker.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'ITEM/ITEMhistorycatch.dart';

class SCREENhistorycatch extends StatefulWidget {
  const SCREENhistorycatch({Key? key}) : super(key: key);

  @override
  State<SCREENhistorycatch> createState() => _SCREENhistorycatchState();
}

class _SCREENhistorycatchState extends State<SCREENhistorycatch> {
  List<catchOrder> dataList = [];
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order/catchOrder').onValue.listen((event) {
      dataList.clear();
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == currentAccount.id) {
          catchOrder thisO = catchOrder.fromJson(value);
          dataList.add(thisO);
        }
      }
      );
      setState(() {
        sortChosenListByCreateTime(dataList);
      });
    });

  }

  void sortChosenListByCreateTime(List<catchOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.S1time.year.compareTo(a.S1time.year) != 0
          ? b.S1time.year.compareTo(a.S1time.year)
          : (b.S1time.month.compareTo(a.S1time.month) != 0
          ? b.S1time.month.compareTo(a.S1time.month)
          : (b.S1time.day.compareTo(a.S1time.day) != 0
          ? b.S1time.day.compareTo(a.S1time.day)
          : (b.S1time.hour.compareTo(a.S1time.hour) != 0
          ? b.S1time.hour.compareTo(a.S1time.hour)
          : (b.S1time.minute.compareTo(a.S1time.minute) != 0
          ? b.S1time.minute.compareTo(a.S1time.minute)
          : b.S1time.second.compareTo(a.S1time.second)))));
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: 100,
                decoration: BoxDecoration(

                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 15,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/backicon1.png')
                              )
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 22,
                      left: 60,
                      child: Text(
                        'Lịch sử đi lại',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                          fontFamily: 'arial',
                          color: Colors.black
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 100,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight - 100,
                child: ListView.builder(
                  itemCount: dataList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENwaitbikerHis(diemdon: dataList[index].locationSet,diemtra: dataList[index].locationGet, id: dataList[index].id,)));
                        },
                        child: ITEMhistorycatch(order: dataList[index], width: screenWidth, height: 120),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
