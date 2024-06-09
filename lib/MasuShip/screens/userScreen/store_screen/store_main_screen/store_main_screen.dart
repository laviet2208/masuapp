import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/product_order_screen/cart_screen/view_store_cart_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/store_directory_page/store_directory_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/store_type_screen/store_type_screen.dart';

import '../../../../Data/accountData/shopData/shopDirectory.dart';
import '../../../../Data/adsData/restaurantAdsData.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/otherData/utils.dart';
import '../../main_screen/user_main_screen.dart';
import '../../restaurant_screen/restaurant_main_screen/current_location_in_res_main.dart';
import '../../restaurant_screen/restaurant_main_screen/shop_type_item.dart';

class store_main_screen extends StatefulWidget {
  const store_main_screen({super.key});

  @override
  State<store_main_screen> createState() => _store_main_screenState();
}

class _store_main_screenState extends State<store_main_screen> {
  List<restaurantAdsData> dataList = [];
  List<shopDirectory> directoryList = [];
  final PageController _pageController = PageController(viewportFraction: 1, keepPage: true);
  Timer? _timer;
  int _currentPage = 0;

  void get_ads_restaurant_page_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Ads").orderByChild('direction').equalTo(4).onValue.listen((event) {
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

  void get_res_directory_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("StoreDirectory").orderByChild('area').equalTo(finalData.user_account.area).onValue.listen((event) {
      final dynamic ads = event.snapshot.value;
      directoryList.clear();
      ads.forEach((key, value) {
        shopDirectory data = shopDirectory.fromJson(value);
        directoryList.add(data);
        setState(() {

        });
      }
      );
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
    get_ads_restaurant_page_data();
    get_res_directory_data();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < dataList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 15,
                        left: 15,
                        child: Container(
                          height: 30,
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
                                },
                              ),

                              Container(width: 3,),

                              Icon(
                                Icons.location_on_rounded,
                                color: Colors.red,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 20,
                        left: 80,
                        right: 15,
                        child: FutureBuilder(
                          future: fetchLocationName(finalData.user_account.location),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return current_location_in_res_main(title: 'Đang tải vị trí...');
                            }

                            if (snapshot.hasError) {
                              print('Lỗi vị trí ' + snapshot.error.toString());
                              return current_location_in_res_main(title: 'Vui lòng chọn hoặc cho phép vị trí');
                            }

                            if (!snapshot.hasData) {
                              print('Lỗi vị trí ' + snapshot.error.toString());
                              return current_location_in_res_main(title: 'Vui lòng chọn hoặc cho phép vị trí');
                            }

                            return current_location_in_res_main(title: snapshot.data!.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 130,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: width/2,
                              alignment: Alignment.center,
                              child: dataList.length == 0 ? Container(
                                child: Text(
                                  'Chưa có quảng cáo',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 13,
                                      color: Colors.grey
                                  ),
                                ),
                              ) : PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _pageController,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      width: width - 10,
                                      height: height - 25,
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

                                          return Image.network(snapshot.data.toString(),fit: BoxFit.fill,);
                                        },
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => restaurant_view_screen(shopId: dataList[index].account.id, beforeWidget: restaurant_main_screen())));
                                    },
                                  );
                                },
                              ),
                            ),

                            Container(height: 10,),

                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: (width - 20 - 90)/4*3 + 20,
                                child: GridView.builder(
                                  itemCount: finalData.restaurant_type_images.length,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, // số phần tử trên mỗi hàng
                                    mainAxisSpacing: 10, // khoảng cách giữa các hàng
                                    crossAxisSpacing: 30, // khoảng cách giữa các cột
                                    childAspectRatio: 1, // tỷ lệ chiều rộng và chiều cao
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: shop_type_item(imagePath: finalData.store_type_images[index], title: finalData.store_type_names[index]),
                                      onTap: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => store_type_screen(title: finalData.store_type_names[index], index: index),),);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            Container(height: 20,),

                            Container(
                              alignment: Alignment.center,
                              child: directoryList.length != 0 ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: directoryList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 30),
                                      child: store_directory_page(directory: directoryList[index]),
                                    ),
                                  );
                                },
                              ) : Text('Danh sách trống', style: TextStyle(fontFamily: 'muli',fontSize: 14, color: Colors.black),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  child: Container(
                    height: width/6,
                    width: width/6,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
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
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                          ),
                        ),

                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(
                              child: Text(
                                finalData.cartList.length.toString(),
                                style: TextStyle(
                                  fontFamily: 'muli',
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (finalData.storeCartList.length == 0) {
                      toastMessage('Giỏ hàng trống');
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_store_cart_screen(beforewidget: store_main_screen(),),),);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return Future.value(false);
      },
    );
  }
}
