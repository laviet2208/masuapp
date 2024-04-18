import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import '../../../Data/finalData/finalData.dart';

class history_order_page extends StatefulWidget {
  const history_order_page({Key? key}) : super(key: key);

  @override
  State<history_order_page> createState() => _history_order_pageState();
}

class _history_order_pageState extends State<history_order_page> with SingleTickerProviderStateMixin {
  int indexTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  indexTab = index;
                });
              },
              labelStyle: TextStyle(fontFamily: 'muli', fontWeight: FontWeight.bold), // TextStyle của văn bản khi được chọn
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.yellow,
              ),
              tabs: [
                Tab(text: 'Đơn đang chạy'),
                Tab(text: 'Đã hoàn thành'),
              ],
            ),
          ],

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [finalData.shipper_account.onlineStatus == 1 ? Colors.yellow : Colors.black26,finalData.shipper_account.onlineStatus == 1 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: history_controller.get_history_widget(indexTab),
            )
          ],
        ),
      ),
    );
  }
}
