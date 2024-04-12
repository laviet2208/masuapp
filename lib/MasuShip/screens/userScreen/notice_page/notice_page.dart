import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/noticeData/noticeData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/notice_page/notice_item.dart';

class notice_page extends StatefulWidget {
  const notice_page({super.key});

  @override
  State<notice_page> createState() => _notice_pageState();
}

class _notice_pageState extends State<notice_page> {
  List<noticeData> list = [];

  void getNotification() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Notification").orderByChild('object').equalTo(0).onValue.listen((event) {
      list.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        noticeData notice = noticeData.fromJson(value);
        if (notice.object == 0 && notice.area == finalData.user_account.area) {
          list.add(notice);
        }
      });
      setState(() {
        sortbypushtime(list);
      });
    });
  }

  void sortbypushtime(List<noticeData> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.send.year.compareTo(a.send.year) != 0
          ? b.send.year.compareTo(a.send.year)
          : (b.send.month.compareTo(a.send.month) != 0
          ? b.send.month.compareTo(a.send.month)
          : (b.send.day.compareTo(a.send.day) != 0
          ? b.send.day.compareTo(a.send.day)
          : (b.send.hour.compareTo(a.send.hour) != 0
          ? b.send.hour.compareTo(a.send.hour)
          : (b.send.minute.compareTo(a.send.minute) != 0
          ? b.send.minute.compareTo(a.send.minute)
          : b.send.second.compareTo(a.send.second)))));
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [Colors.white ,Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: list.length,
            padding: EdgeInsets.only(top: 50),
            itemBuilder: (context, index) {
              return notice_item(data: list[index]);
            },
          ),
        )
      ),
    );
  }
}
