import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_NOTIFICATION/Notification.dart';

import '../../../INUSER/PAGE_NOTIFICATION/ItemNotification.dart';
import 'Viewnotice.dart';


class PageNotification extends StatefulWidget {
  const PageNotification({Key? key}) : super(key: key);

  @override
  State<PageNotification> createState() => _PageNotificationState();
}

class _PageNotificationState extends State<PageNotification> {
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

    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 244, 246)
      ),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ItemNotice(width: screenWidth, height: 0, notice: list[index],),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => Viewnotice(notice: list[index], type: 1,)));
              },
            );
          },
        )
    );
  }
}
