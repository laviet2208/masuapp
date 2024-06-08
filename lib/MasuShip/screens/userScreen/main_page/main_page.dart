import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_page/ingredient/feature_button_in_main_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/store_main_screen/store_main_screen.dart';
import '../../../Data/adsData/restaurantAdsData.dart';
import '../express_screen/express_step_1.dart';
import '../main_screen/user_main_screen.dart';
import '../restaurant_screen/restaurant_main_screen/restaurant_main_screen.dart';
import '../restaurant_screen/restaurant_view_screen/restaurant_view_screen.dart';
import 'ingredient/buy_request_order_ingredient/buy_request_button.dart';
import 'ingredient/catch_order_ingredient/catch_order_button.dart';

class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  String areaName = '';
  List<restaurantAdsData> dataList = [];
  final PageController _pageController = PageController(viewportFraction: 1, keepPage: true);
  Timer? _timer;
  int _currentPage = 0;

  void get_ads_main_page_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Ads").orderByChild('direction').equalTo(2).onValue.listen((event) {
      final dynamic ads = event.snapshot.value;
      dataList.clear();
      ads.forEach((key, value) {
        if (value['area'].toString() == finalData.user_account.area) {
          if (int.parse(value['status'].toString()) == 1) {
            restaurantAdsData data = restaurantAdsData.fromJson(value);
            dataList.add(data);
            setState(() {

            });
          }
        }
      }
      );
      setState(() {

      });
    });
  }

  void get_area_name() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(finalData.user_account.area).onValue.listen((event) {
      final dynamic area = event.snapshot.value;
      areaName = area['name'].toString();
      setState(() {

      });
    });
  }

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('Ads').child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_name();
    get_ads_main_page_data();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < dataList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 3000),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(height: 50,),

            Container(
              height: width/2,
              alignment: Alignment.center,
              child:dataList.length == 0 ? Container(alignment: Alignment.center, child: Text('Chưa có quảng cáo', style: TextStyle(fontFamily: 'muli'),),) : PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      width: width,
                      height: width/2,
                      alignment: Alignment.center,
                      child: FutureBuilder(
                        future: _getImageURL(dataList[index].id + '.png'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(color: Colors.black,),
                            );
                          }

                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Icon(Icons.image_outlined, color: Colors.black, size: 30,),
                            );
                          }

                          if (!snapshot.hasData) {
                            return Text('Image not found');
                          }

                          return Image.network(snapshot.data.toString(),fit: BoxFit.contain,);
                        },
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => restaurant_view_screen(shopId: dataList[index].account.id, beforeWidget: user_main_screen())));
                    },
                  );
                },
              ),
            ),

            Container(height: 30,),

            Padding(
              padding: EdgeInsets.only(right: 10, left: width/4),
              child: Container(
                width: width/3*2,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow,
                  border: Border.all(
                      width: 0.7
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, top: 3, bottom: 3),
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),

                        Container(width: 5,),

                        Padding(
                          padding: EdgeInsets.only(top: 5.5, bottom: 5.5),
                          child: Container(
                            width: width/3*2 - 10 - 29 - 5,
                            child: AutoSizeText(
                              areaName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'muli',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Container(height: 30,),

            Container(
              height: (width - 60)/3,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 15 + (((width - 60)/3))/2,
                    child: catch_order_button(),
                  ),

                  Positioned(
                    top: 0,
                    right: 15 + (((width - 60)/3))/2,
                    child: buy_request_button(),
                  ),
                ],
              ),
            ),

            Container(height: 30,),

            Container(
              height: (width - 60)/3,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 15,
                    child: GestureDetector(
                      child: feature_button_in_main_page(title: 'Giao hàng nhanh', imageUrl: 'assets/image/iconmart.png'),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => express_step_1(),),);
                      },
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: (width - ((width - 60)/3))/2,
                    child: GestureDetector(
                      child: feature_button_in_main_page(title: 'Mua sắm', imageUrl: 'assets/image/iconstore.png'),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => store_main_screen(),),);
                      },
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 15,
                    child: GestureDetector(
                      child: feature_button_in_main_page(title: 'Mua đồ ăn', imageUrl: 'assets/image/iconfood.png'),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => restaurant_main_screen(),),);
                      },
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 30,),
          ],
        ),
      ),
    );
  }
}
