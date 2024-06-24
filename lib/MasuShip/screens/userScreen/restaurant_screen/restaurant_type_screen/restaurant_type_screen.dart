import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_directory_page/item_restaurant_in_directory.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_main_screen/restaurant_main_screen.dart';

import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../restaurant_view_screen/restaurant_view_screen.dart';

class restaurant_type_screen extends StatefulWidget {
  final String title;
  final int index;
  const restaurant_type_screen({super.key, required this.title, required this.index});

  @override
  State<restaurant_type_screen> createState() => _restaurant_type_screenState();
}

class _restaurant_type_screenState extends State<restaurant_type_screen> {
  List<ShopAccount> shopList = [];

  void get_shop_data() {
    final reference = FirebaseDatabase.instance.reference();
    if (widget.index == -1) {
      reference.child("Restaurant").onValue.listen((event) {
        shopList.clear();
        final dynamic orders = event.snapshot.value;
        orders.forEach((key, value) {
          ShopAccount account = ShopAccount.fromJson(value);
          if (account.lockStatus == 1) {
            shopList.add(account);
          }
        });
        setState(() {

        });
      });
    } else {
      reference.child("Restaurant").orderByChild('type').equalTo(widget.index).onValue.listen((event) {
        shopList.clear();
        final dynamic orders = event.snapshot.value;
        orders.forEach((key, value) {
          ShopAccount account = ShopAccount.fromJson(value);
          if (account.lockStatus == 1) {
            shopList.add(account);
          }
        });
        setState(() {

        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_shop_data();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 245, 245),
              gradient: LinearGradient(
                colors: [Colors.yellow , Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
              ),
            ),
            child: ListView(
              children: [
                Container(height: 20,),

                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Container(width: 10,),

                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => restaurant_main_screen()));
                        },
                      ),

                      Container(width: 10,),

                      Padding(
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        child: Container(
                          width: width - 70,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: AutoSizeText(
                            'Danh sách nhà hàng ' + widget.title,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: GridView.builder(
                      itemCount: shopList.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // số phần tử trên mỗi hàng
                        mainAxisSpacing: 10, // khoảng cách giữa các hàng
                        crossAxisSpacing: (width - 20 - 2*(width/2.5)), // khoảng cách giữa các cột
                        childAspectRatio: (width/2.5)/(width/2.5 * 1.4), // tỷ lệ chiều rộng và chiều cao
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 5, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            child: item_restaurant_in_directory(shopId: shopList[index].id),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => restaurant_view_screen(shopId: shopList[index].id, beforeWidget: this.widget)));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => restaurant_main_screen(),),);
          return Future.value(false);
        }
    );
  }
}
