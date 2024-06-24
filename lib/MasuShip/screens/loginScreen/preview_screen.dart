import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/login_screen.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../Data/adsData/restaurantAdsData.dart';
import '../userScreen/main_page/ingredient/feature_button_in_main_page.dart';

class preview_screen extends StatefulWidget {
  const preview_screen({Key? key}) : super(key: key);

  @override
  State<preview_screen> createState() => _preview_screenState();
}

class _preview_screenState extends State<preview_screen> {
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
        if (int.parse(value['status'].toString()) == 1) {
          restaurantAdsData data = restaurantAdsData.fromJson(value);
          dataList.add(data);
          setState(() {

          });
        }
      }
      );
      setState(() {

      });
    });
  }

  void get_area_name() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child('ineSi92oGc1ZDlBBlddo').onValue.listen((event) {
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

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
      //return Future.error('Chưa cho phép vị trí');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        toastMessage('Nên cho phép vị trí để tăng cường trải nghiệm');
        return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
        // exit(0);
        // return Future.error('Từ chối cho phép vị trí');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      toastMessage('Nên cho phép vị trí để tăng cường trải nghiệm');
      return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
      // exit(0);
      // return Future.error('Bạn cần cho phép ứng dụng truy cập vào vị trí');
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Start tracking location changes
      // startLocationTracking();
      return await Geolocator.getCurrentPosition();
    }


    return Position(longitude: 106.4204177, latitude: 10.5375044, timestamp: DateTime(2024), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final player = AudioPlayer();
    player.play(AssetSource('volume/chaomung.mp3'), volume: 200);
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
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
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
                                getCurrentLocation().then((value) {

                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));                              },
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
                              child: GestureDetector(
                                child: feature_button_in_main_page(title: 'Gọi xe máy, lái xe hộ', imageUrl: 'assets/image/iconbike10.png'),
                                onTap: () {
                                  getCurrentLocation().then((value) {

                                  });
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
                                },
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 15 + (((width - 60)/3))/2,
                              child: GestureDetector(
                                child: feature_button_in_main_page(title: 'Nhà hàng, ăn uống', imageUrl: 'assets/image/iconfood1.png'),
                                onTap: () {
                                  getCurrentLocation().then((value) {

                                  });
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
                                },
                              ),
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
                                child: feature_button_in_main_page(title: 'Giao Express Hỏa tốc', imageUrl: 'assets/image/iconmart1.png'),
                                onTap: () {
                                  getCurrentLocation().then((value) {

                                  });
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
                                },
                              ),
                            ),

                            Positioned(
                              top: 0,
                              left: (width - ((width - 60)/3))/2,
                              child: GestureDetector(
                                child: feature_button_in_main_page(title: 'Cửa hàng, Mua sắm', imageUrl: 'assets/image/iconstore1.png'),
                                onTap: () {
                                  getCurrentLocation().then((value) {

                                  });
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
                                },
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 15,
                              child: GestureDetector(
                                child: feature_button_in_main_page(title: 'Mua hàng hộ theo yêu cầu', imageUrl: 'assets/image/iconbag1.png'),
                                onTap: () {
                                  getCurrentLocation().then((value) {

                                  });
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
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
              ),

              Positioned(
                bottom: 10,
                left: 15,
                right: 15,
                child: GestureDetector(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // màu của shadow
                          spreadRadius: 5, // bán kính của shadow
                          blurRadius: 7, // độ mờ của shadow
                          offset: Offset(0, 3), // vị trí của shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Đăng nhập vào Masu Ship',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    getCurrentLocation().then((value) {

                    });
                    Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
                  },
                ),
              ),
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
