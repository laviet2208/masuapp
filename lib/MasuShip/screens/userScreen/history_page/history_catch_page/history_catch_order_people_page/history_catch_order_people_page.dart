import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_catch_page/history_catch_order_people_page/history_catch_order_item.dart';

import '../../../../../Data/OrderData/catchOrder.dart';

class history_catch_order_people_page extends StatefulWidget {
  const history_catch_order_people_page({super.key});

  @override
  State<history_catch_order_people_page> createState() => _history_catch_order_people_pageState();
}

class _history_catch_order_people_pageState extends State<history_catch_order_people_page> {
  List<CatchOrder> orderList = [];
  List<CatchOrder> chosenList = [];
  final searchController = TextEditingController();

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('owner/id').equalTo(finalData.user_account.id).onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        if (value['buyLocation'] == null && value['timeList'] == null && value['weightType'] == null && value['motherOrder'] == null && value['orderList'] == null) {
          CatchOrder catchOrder = CatchOrder.fromJson(value);
          orderList.add(catchOrder);
          chosenList.add(catchOrder);
          setState(() {sortbypushtime(chosenList);});
        }
      });

    });
  }

  void sortbypushtime(List<CatchOrder> chosenList) {
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

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = orderList
          .where((account) =>
      account.id.toLowerCase().contains(value.toLowerCase()) ||
          account.locationSet.mainText.toLowerCase().contains(value.toLowerCase()) ||
          account.locationSet.secondaryText.toLowerCase().contains(value.toLowerCase()) ||
          account.locationGet.mainText.toLowerCase().contains(value.toLowerCase()) ||
          account.locationGet.secondaryText.toLowerCase().contains(value.toLowerCase()) ||
          account.owner.name.toLowerCase().contains(value.toLowerCase()) ||
          account.owner.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.shipper.name.toLowerCase().contains(value.toLowerCase()) ||
          account.shipper.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: [
          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), // màu của shadow
                    spreadRadius: 5, // bán kính của shadow
                    blurRadius: 7, // độ mờ của shadow
                    offset: Offset(0, 3), // vị trí của shadow
                  ),
                ],
              ),
              child: Container(
                width: width - 80,
                child: Form(
                  child: TextFormField(
                    controller: searchController,
                    onChanged: onSearchTextChanged,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'muli',
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Tìm kiếm đơn hàng',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'muli',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: ListView.builder(
              itemCount: chosenList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: history_catch_order_item(order: chosenList[index]),
                );
              },
            ),
          ),

          Container(height: 50,),
        ],
      ),
    );
  }
}
