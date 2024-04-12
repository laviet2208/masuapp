import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_catch_page/history_catch_order_bike_page/history_catch_order_bike_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_catch_page/history_catch_order_people_page/history_catch_order_people_page.dart';

class history_catch_page extends StatefulWidget {
  const history_catch_page({super.key});

  @override
  State<history_catch_page> createState() => _history_catch_pageState();
}

class _history_catch_pageState extends State<history_catch_page> with SingleTickerProviderStateMixin {
  int indexPage = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget get_body_widget() {
    if (indexPage == 0) {
      return history_catch_order_people_page();
    }
    if (indexPage == 1) {
      return history_catch_order_bike_page();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Ẩn nút back
        backgroundColor: Colors.white,
        elevation: 0,
        title: SizedBox.shrink(),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.yellow,
              onTap: (index) {
                setState(() {
                  indexPage = index;
                });
              },
              labelStyle: TextStyle(fontFamily: 'muli', fontWeight: FontWeight.bold), // TextStyle của văn bản khi được chọn
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 2, top: 5),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.yellow,
              ),
              tabs: [
                Tab(text: 'Đặt xe'),
                Tab(text: 'Lái xe hộ'),
              ],
            ),
          ],

        ),
      ),
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
          padding: EdgeInsets.only(top: 10),
          child:  get_body_widget(),
        ),
      ),
    );
  }
}
