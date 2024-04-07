import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_directory_page/restaurant_directory_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_main_screen/shop_type_item.dart';
import '../../../../Data/accountData/shopData/shopDirectory.dart';
import '../../../../Data/adsData/restaurantAdsData.dart';
import '../food_order_screen/cart_screen/view_cart_screen.dart';

class restaurant_main_screen extends StatefulWidget {
  const restaurant_main_screen({super.key});

  @override
  State<restaurant_main_screen> createState() => _restaurant_main_screenState();
}

class _restaurant_main_screenState extends State<restaurant_main_screen> {
  String locationName = '';
  String areaName = '';
  List<restaurantAdsData> dataList = [];
  List<shopDirectory> directoryList = [];
  final PageController _pageController = PageController(viewportFraction: 1, keepPage: true);
  Timer? _timer;
  int _currentPage = 0;

  void get_ads_restaurant_page_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Ads").orderByChild('direction').equalTo(3).onValue.listen((event) {
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
    reference.child("RestaurantDirectory").orderByChild('area').equalTo(finalData.user_account.area).onValue.listen((event) {
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

  void fetchLocationName(double latitude, double longitude) async {
    final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        locationName = data['results'][0]['formatted_address'];
        setState(() {

        });
      });
    } else {
      throw Exception('Failed to load location');
    }
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
    fetchLocationName(finalData.user_account.location.latitude, finalData.user_account.location.longitude);
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
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 5,
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
                        top: 10,
                        left: 80,
                        right: 15,
                        child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'Giao tới\n',
                            style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: locationName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 15,
                        right: 15,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.4),
                            )
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                bottom: 10,
                                right: 10,
                                child: Icon(
                                  Icons.search_sharp,
                                  size: 30,
                                  color: Colors.redAccent,
                                ),
                              ),

                              Positioned(
                                left: 15,
                                top: 15,
                                bottom: 15,
                                right: 50,
                                child: Container(
                                  child: AutoSizeText(
                                    'Bạn muốn ăn gì hôm nay?',
                                    style: TextStyle(
                                      fontSize: 100,
                                      color: Colors.grey.withOpacity(0.6),
                                      fontFamily: 'roboto',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

              Positioned(
                top: 190,
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
                                    return shop_type_item(imagePath: finalData.restaurant_type_images[index], title: finalData.restaurant_type_names[index]);
                                  },
                                ),
                              ),
                            ),

                            Container(height: 20,),

                            Container(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: directoryList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 30),
                                      child: restaurant_directory_page(directory: directoryList[index]),
                                    ),
                                  );
                                },
                              ),
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
                    if (finalData.cartList.length == 0) {
                      toastMessage('Giỏ hàng trống');
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_cart_screen(beforewidget: restaurant_main_screen(),),),);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
