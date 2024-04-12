import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

class history_food_order_page extends StatefulWidget {
  const history_food_order_page({super.key});

  @override
  State<history_food_order_page> createState() => _history_food_order_pageState();
}

class _history_food_order_pageState extends State<history_food_order_page> {
  List<foodOrder> orderList = [];
  List<foodOrder> chosenList = [];
  final searchController = TextEditingController();

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('owner/id').equalTo(finalData.user_account.id).onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        if (value['timeList'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          orderList.add(order);
          chosenList.add(order);
          setState(() {sortbypushtime(chosenList);});
        }
      });

    });
  }

  void sortbypushtime(List<foodOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.timeList.first.year.compareTo(a.timeList.first.year) != 0
          ? b.timeList.first.year.compareTo(a.timeList.first.year)
          : (b.timeList.first.month.compareTo(a.timeList.first.month) != 0
          ? b.timeList.first.month.compareTo(a.timeList.first.month)
          : (b.timeList.first.day.compareTo(a.timeList.first.day) != 0
          ? b.timeList.first.day.compareTo(a.timeList.first.day)
          : (b.timeList.first.hour.compareTo(a.timeList.first.hour) != 0
          ? b.timeList.first.hour.compareTo(a.timeList.first.hour)
          : (b.timeList.first.minute.compareTo(a.timeList.first.minute) != 0
          ? b.timeList.first.minute.compareTo(a.timeList.first.minute)
          : b.timeList.first.second.compareTo(a.timeList.first.second)))));
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white ,Colors.yellow],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
        ),
      ),
      child: ListView(
        children: [
          Container(height: 20,),

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

          Container(height: 20,),


        ],
      ),
    );
  }
}
