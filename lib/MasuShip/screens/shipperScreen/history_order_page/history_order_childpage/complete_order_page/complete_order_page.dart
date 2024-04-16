import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/complete_order_page/complete_buy_request_order_page.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/complete_order_page/complete_catch_order_page.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/complete_order_page/complete_express_order_page.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_childpage/complete_order_page/complete_food_order_page.dart';

import '../../history_order_item/complete_item/complete_buy_request_order_item.dart';

class complete_order_page extends StatefulWidget {
  const complete_order_page({Key? key}) : super(key: key);

  @override
  State<complete_order_page> createState() => _complete_order_pageState();
}

class _complete_order_pageState extends State<complete_order_page> with SingleTickerProviderStateMixin {
  int indexPage = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Widget get_body_widget(int index) {
    if (index == 0) {
      return complete_catch_order_page();
    }

    if (index == 1) {
      return complete_buy_request_order_page();
    }

    if (index == 2) {
      return complete_express_order_page();
    }

    if (index == 3) {
      return complete_food_order_page();
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
              padding: EdgeInsets.only(left: 5, right: 5,),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.yellow,
              ),
              tabs: [
                Tab(text: 'Xe ôm'),
                Tab(text: 'Mua hộ'),
                Tab(text: 'Express'),
                Tab(text: 'Đồ ăn'),
              ],
            ),
          ],

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.transparent
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: get_body_widget(indexPage),
            )
          ],
        ),
      ),
    );
  }
}
