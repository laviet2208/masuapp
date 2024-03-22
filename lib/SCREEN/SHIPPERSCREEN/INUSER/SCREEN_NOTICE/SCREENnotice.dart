import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Th%C3%B4ng%20tin%20t%C3%A0i%20kho%E1%BA%A3n/yeucauruttien.dart';

import '../../../INUSER/PAGE_NOTIFICATION/ItemNotification.dart';
import '../../../INUSER/PAGE_NOTIFICATION/Notification.dart';
import '../../../INUSER/PAGE_NOTIFICATION/Viewnotice.dart';
import '../SCREEN_MAIN/SCREENmain.dart';

class ScreenNotice extends StatefulWidget {
  const ScreenNotice({Key? key}) : super(key: key);

  @override
  State<ScreenNotice> createState() => _ScreenRutTienState();
}

class _ScreenRutTienState extends State<ScreenNotice> {
  List<notification> list = [];

  void getNotification() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Notification").onValue.listen((event) {
      list.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        notification notice = notification.fromJson(value);
        if (notice.object == 1 && notice.Area == currentAccount.Area) {
          list.add(notice);
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245)
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
                          'Danh sách thông báo',
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
              top: 110,
              child: Container(
                width: screenWidth,
                height: screenHeight - 190,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: ItemNotice(width: screenWidth, height: 0, notice: list[index],),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Viewnotice(notice: list[index], type: 2,)));
                        },
                      );
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
