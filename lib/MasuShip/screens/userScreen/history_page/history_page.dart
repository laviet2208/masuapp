import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_catch_page/history_catch_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_express_page/history_express_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_food_order_page/history_food_order_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_request_page/history_request_page.dart';

class history_page extends StatefulWidget {
  const history_page({super.key});

  @override
  State<history_page> createState() => _history_pageState();
}

class _history_pageState extends State<history_page> with SingleTickerProviderStateMixin {
  int indexPage = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Widget get_body_widget() {
    if (indexPage == 0) {
      return history_catch_page();
    }
    if (indexPage == 1) {
      return history_express_page();
    }
    if (indexPage == 2) {
      return history_food_order_page();
    }
    if (indexPage == 3) {
      return history_request_page();
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
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.yellow,
              ),
              tabs: [
                Tab(text: 'Đặt xe'),
                Tab(text: 'Express'),
                Tab(text: 'Đồ ăn'),
                Tab(text: 'Mua hộ'),
              ],
            ),
          ],

        ),
      ),
      body: get_body_widget(),
    );
  }
}
