import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/Item%20thay%20%C4%91%E1%BB%95i%20s%E1%BB%91%20d%C6%B0.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/historyTransaction.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

import '../Thông tin tài khoản/Nạp tiền.dart';
import '../Thông tin tài khoản/Rút tiền.dart';

class Pagevitien extends StatefulWidget {
  const Pagevitien({Key? key}) : super(key: key);

  @override
  State<Pagevitien> createState() => _PagevitienState();
}

class _PagevitienState extends State<Pagevitien> {
  List<historyTransaction> hisList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("historyTransaction").orderByChild('receiverId').equalTo(currentAccount.id).onValue.listen((event) {
      hisList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        historyTransaction his = historyTransaction.fromJson(value);
        hisList.add(his);
        setState(() {
          sortChosenListByCreateTime(hisList);
        });
      });
      setState(() {
        sortChosenListByCreateTime(hisList);
      });
    });
  }

  void sortChosenListByCreateTime(List<historyTransaction> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.transactionTime.year.compareTo(a.transactionTime.year) != 0
          ? b.transactionTime.year.compareTo(a.transactionTime.year)
          : (b.transactionTime.month.compareTo(a.transactionTime.month) != 0
          ? b.transactionTime.month.compareTo(a.transactionTime.month)
          : (b.transactionTime.day.compareTo(a.transactionTime.day) != 0
          ? b.transactionTime.day.compareTo(a.transactionTime.day)
          : (b.transactionTime.hour.compareTo(a.transactionTime.hour) != 0
          ? b.transactionTime.hour.compareTo(a.transactionTime.hour)
          : (b.transactionTime.minute.compareTo(a.transactionTime.minute) != 0
          ? b.transactionTime.minute.compareTo(a.transactionTime.minute)
          : b.transactionTime.second.compareTo(a.transactionTime.second)))));
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

    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(

          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // màu của shadow
                        spreadRadius: 5, // bán kính của shadow
                        blurRadius: 7, // độ mờ của shadow
                        offset: Offset(0, 3), // vị trí của shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: GestureDetector(
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
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
                          },
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        left: 70,
                        right: 70,
                        child: Container(
                          height: 20,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Ví tiền',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 100,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 105,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight - 105,
                  child: Column(
                    children: [
                      Container(height: 20,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.6)
                            )
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 20,
                                left: 10,
                                child: Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 30,
                                  color: Colors.redAccent,
                                ),
                              ),

                              Positioned(
                                top: 8,
                                left: 50,
                                child: Text(
                                  'Số dư hiện tại',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontFamily: 'roboto'
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 8,
                                left: 50,
                                child: Text(
                                  getStringNumber(currentAccount.totalMoney) + ' đ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: 15,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: Container(
                          height: 120,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 0,
                                child: GestureDetector(
                                  child: Container(
                                    height: 120,
                                    width: (screenWidth - 38)/2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1
                                      )
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.account_balance_outlined,
                                          color: Colors.blueAccent,
                                          size: 35,
                                        ),

                                        Container(height: 5,),

                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Nạp tiền',
                                            style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENnaptien()));
                                  },
                                ),
                              ),

                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  child: Container(
                                    height: 120,
                                    width: (screenWidth - 38)/2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1
                                        )
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.balance_outlined,
                                          color: Colors.redAccent,
                                          size: 35,
                                        ),

                                        Container(height: 5,),

                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Rút tiền',
                                            style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder:(context) => ScreenRutTien()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child : Container(
                          width: screenWidth - 30,
                          height: screenHeight - 105 - 30 - 70 - 15 - 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3), // màu của shadow
                                  spreadRadius: 5, // bán kính của shadow
                                  blurRadius: 7, // độ mờ của shadow
                                  offset: Offset(0, 3), // vị trí của shadow
                                ),
                              ],
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: hisList.length,
                            itemBuilder: (context , index) {
                              return Itemthaydoisodu(width: screenWidth - 30, transaction: hisList[index]);
                            }
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
