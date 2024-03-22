import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Policy.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

import 'SCREEN_MAIN/SCREENmain.dart';

class Dieukhoandichvu extends StatefulWidget {
  final int type;
  const Dieukhoandichvu({Key? key, required this.type}) : super(key: key);

  @override
  State<Dieukhoandichvu> createState() => _DieukhoandichvuState();
}

class _DieukhoandichvuState extends State<Dieukhoandichvu> {
  List<Policy> policyList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Policy').onValue.listen((event) {
      policyList.clear();
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        Policy policy = Policy.fromJson(value);
        policyList.add(policy);
        sortChosenListByCreateTime(policyList);
      }
      );
      setState(() {

      });
    });

  }

  void sortChosenListByCreateTime(List<Policy> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
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
                            if (widget.type == 1) {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                            }
                            if (widget.type == 2) {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
                            }

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
                            'Điều khoản dịch vụ',
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
                    itemCount: policyList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 10,),

                            Container(
                              child: Text(
                                policyList.reversed.toList()[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'arial',
                                    fontSize: 16
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),

                            Container(height: 10,),

                            Container(
                              child: Text(
                                policyList.reversed.toList()[index].content,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'arial',
                                    fontSize: 14
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),

                            Container(height: 15,),
                          ],
                        )
                      );
                    },
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
