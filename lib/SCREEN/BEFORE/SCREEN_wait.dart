import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masuapp/GENERAL/NormalUser/accountLocation.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/ITEM%20nh%C3%A0%20h%C3%A0ng%20g%E1%BA%A7n.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/Item%20qu%E1%BA%A3ng%20c%C3%A1o%20lo%E1%BA%A1i%201.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/Item%20qu%E1%BA%A3ng%20c%C3%A1o%20lo%E1%BA%A1i%202.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/T%C3%ADnh%20kho%E1%BA%A3ng%20c%C3%A1ch.dart';
import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/Ads/ADStype1.dart';
import '../../../GENERAL/Ads/ADStype2.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Order/catchOrder.dart';
import '../../../GENERAL/ShopUser/accountShop.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../../ITEM/ITEMrestaurant.dart';
import '../../GENERAL/Ads/Topbanner.dart';
import 'SCREEN_loginbyphonenum.dart';

class ScreenWait extends StatefulWidget {
  const ScreenWait({Key? key}) : super(key: key);

  @override
  State<ScreenWait> createState() => _PAGEhomeState();
}

class _PAGEhomeState extends State<ScreenWait> {
  final PageController _pageController =
  PageController(viewportFraction: 1, keepPage: true);
  Timer? _timer;
  int _currentPage = 0;
  final nameController = TextEditingController();
  final accountLocation diemdon = accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: '');
  final accountLocation diemtra = accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: '');
  bool iscar = false;

  bool loadingBike = false;
  bool loadingCar = false;

  Future<bool> getData(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('Order/catchOrder').once();
    bool ch = false;
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      catchOrderData.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == id) {
          catchOrder thisO = catchOrder.fromJson(value);
          if (thisO.status == 'A' || thisO.status == 'B' || thisO.status == 'C') {
            diemdon.Longitude = thisO.locationSet.Longitude;
            diemdon.Latitude = thisO.locationSet.Latitude;
            bikeGetLocation.Longitude = thisO.locationGet.Longitude;
            bikeGetLocation.Latitude = thisO.locationGet.Latitude;
            if (thisO.type == 1) {
              iscar = false;
            }
            if (thisO.type == 2) {
              iscar = true;
            }
            ch = true;
          }
        }
      }
      );
    }
    return ch;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Chưa cho phép vị trí');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        toastMessage('Để tiếp tục bạn cần cho phép truy cập vị trí của bạn');
        exit(0);
        return Future.error('Từ chối cho phép vị trí');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      toastMessage('Để tiếp tục bạn cần cho phép truy cập vị trí của bạn');
      exit(0);
      return Future.error('Bạn cần cho phép ứng dụng truy cập vào vị trí');
    }

    return await Geolocator.getCurrentPosition();
  }

  int ads1 = 0;
  String ads1text = "...";
  List<accountShop> shopList = [];
  List<ADStype1> ADStype1List = [];
  List<ADStype2> ADStype2List = [];
  List<Topbanner> TopbannerList = [];

  // Hàm sắp xếp danh sách nhà hàng dựa trên khoảng cách tới vị trí hiện tại
  void sortRestaurantsByDistance(List<accountShop> restaurants, double currentLat, double currentLon) {
    restaurants.sort((a, b) {
      double distanceA = CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(a.location)[0], CaculateDistance.parseDoubleString(a.location)[1], currentLat, currentLon);
      double distanceB = CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(b.location)[0], CaculateDistance.parseDoubleString(b.location)[1], currentLat, currentLon);
      return distanceA.compareTo(distanceB);
    });
  }

  void addAndSortRestaurant(List<accountShop> restaurants, accountShop newRestaurant, double currentLat, double currentLon) {
    restaurants.add(newRestaurant);
    sortRestaurantsByDistance(restaurants, currentLat, currentLon);
  }

  void getADStype1Data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADStype1").onValue.listen((event) {
      ADStype1List.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        ADStype1 acc = ADStype1.fromJson(value);
        ADStype1List.add(acc);
      });
      setState(() {

      });
    });
  }

  void getADStop() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("adsTOP").onValue.listen((event) {
      TopbannerList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        Topbanner acc = Topbanner.fromJson(value);
        TopbannerList.add(acc);
      });
      setState(() {

      });
    });
  }

  void getADStype2Data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADStype2").onValue.listen((event) {
      ADStype2List.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        ADStype2 acc = ADStype2.fromJson(value);
        ADStype2List.add(acc);
      });
      setState(() {

      });
    });
  }

  void getshopData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        accountShop acc = accountShop.fromJson(value);
        addAndSortRestaurant(shopList, acc, currentAccount.locationHis.Latitude, currentAccount.locationHis.Longitude);
      });
      setState(() {
        ads1 = get_randomnumber(0, shopList.length - 1);
        ads1text = shopList[ads1].name;
      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshopData();
    getADStop();
    getADStype1Data();
    getADStype2Data();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < TopbannerList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInSine,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),

        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight,
                child: ListView(
                  children: [
                    Container(
                      height: screenWidth/(1920/668) + 40,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            child: Container(
                              height: screenWidth/(1920/668),
                              width: screenWidth,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _pageController,
                                itemCount: TopbannerList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      height: screenWidth/(1920/668),
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(TopbannerList[index].URLimage)
                                        )
                                      ),
                                    ),
                                    onTap: () {

                                    },
                                  );
                                },
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 55,
                                width: screenWidth - 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3), // màu của shadow
                                      spreadRadius: 5, // bán kính của shadow
                                      blurRadius: 7, // độ mờ của shadow
                                      offset: Offset(0, 3), // vị trí của shadow
                                    ),
                                  ],
                                ),
                                child: Form(
                                  child: TextFormField(
                                    controller: nameController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Dmsan_regular',
                                    ),

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.search),
                                      hintText: 'Bạn cần gì trên Masu?',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Dmsan_regular',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      height: 30,
                    ),

                    //phần menu các tiểu mục
                    Container(
                      height: 76,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 15,
                          ),

                          //Mục đồ ăn
                          Container(
                            width: 56,
                            child: GestureDetector(
                              onTap: () {
                                getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                                                getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconfood.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 56,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Đồ ăn',
                                        style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: 25,
                          ),

                          //Mục Ô tô
                          Container(
                            width: 56,
                            child: GestureDetector(
                              onTap: () {
                                                                getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/icontransport.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 56,
                                      alignment: Alignment.center,
                                      child: loadingCar ? CircularProgressIndicator(strokeWidth: 4, color: Color.fromARGB(255, 255, 123, 64),) : Text(
                                        'Ô tô',
                                        style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: 25,
                          ),

                          //Mục Xe máy
                          Container(
                            width: 56,
                            child: GestureDetector(
                              onTap: () async {
                                                                getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconbike.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 56,
                                      alignment: Alignment.center,
                                      child: loadingBike ? CircularProgressIndicator(strokeWidth: 4, color: Color.fromARGB(255, 255, 123, 64),) : Text(
                                        'Xe máy',
                                        style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: 25,
                          ),

                          //Mục giao hàng
                          // Container(
                          //   width: 56,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENitemsend()));
                          //     },
                          //     child: Stack(
                          //       children: <Widget>[
                          //         Positioned(
                          //           top: 0,
                          //           left: 0,
                          //           child: Container(
                          //             width: 56,
                          //             height: 56,
                          //             alignment: Alignment.center,
                          //             decoration: BoxDecoration(
                          //               image: DecorationImage(
                          //                 fit: BoxFit.cover,
                          //                 image: AssetImage('assets/image/icondelivery.png'),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Positioned(
                          //           bottom: 0,
                          //           child: Container(
                          //             width: 56,
                          //             alignment: Alignment.center,
                          //             child: Text(
                          //               'Giao hàng',
                          //               style: TextStyle(
                          //                 fontFamily: 'arial',
                          //                 fontSize: 12,
                          //                 color: Colors.black,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          //Mục Đi chợ
                          Container(
                            width: 56,
                            child: GestureDetector(
                              onTap: () {
                                // Xử lý sự kiện click vào hình ảnh ở đây
                                print('Clicked on image');
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconmart.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 56,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Đi chợ',
                                        style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: 25,
                          ),

                          //Mục ưu đãi
                          Container(
                            width: 56,
                            child: GestureDetector(
                              onTap: () {
                                                                getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconoffer.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 56,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Ưu đãi',
                                        style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: 25,
                          ),

                          //mục mua sắm

                          Container(
                            width: 56,
                            child: GestureDetector(
                              onTap: () {
                                // Xử lý sự kiện click vào hình ảnh ở đây
                                print('Clicked on image');
                              },
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconbag.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 56,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Mua sắm',
                                        style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: 25,
                          ),

                        ],
                      ),
                    ),

                    Container(height: 20,),

                    Container(
                      height: 56,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 10,
                            child: Container(
                              width: (screenWidth - 20) / 2 - 10,
                              height: 56,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 249, 249, 249),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Text(
                                      'Mã khuyến mãi',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial'
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                     '0',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: 0,
                            right: 10,
                            child: Container(
                              width: (screenWidth - 20) / 2 - 10,
                              height: 56,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 249, 249, 249),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Text(
                                      'Điểm thưởng',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial'
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      'Comming',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
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
                        height: (screenWidth - 20)/(1200/630) + 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ADStype1List.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: ITEMadsType1(width: screenWidth - 20, height: (screenWidth - 20)/(300/188), adStype1: ADStype1List[index]),
                              onTap: () {
                                                                getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: 340,
                        decoration: BoxDecoration(

                        ),

                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                bottom: 312,
                                left: 0,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/fire.png')
                                      )
                                  ),
                                )
                            ),

                            Positioned(
                              bottom: 312,
                              left: 30,
                              child: Text(
                                "Quán ngon gần bạn",
                                style: TextStyle(
                                    fontFamily: 'DMSans_regu',
                                    color: Colors.black,
                                    fontSize: screenWidth/18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 312,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                                                  getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));

                                },
                                child: Text(
                                  'See all',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 99, 255, 1),
                                    fontFamily: 'Dmsan_regular',
                                    fontSize: screenWidth / 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),


                            Positioned(
                              top: 50,
                              left: 0,
                              child: Container(
                                width: screenWidth,
                                height: 248,
                                decoration: BoxDecoration(
                                    color: Colors.white
                                ),

                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: shopList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                                                          getCurrentLocation().then((value) {
                                  currentLocatio.Longitude = value.longitude;
                                  currentLocatio.Latitude = value.latitude;
                                  print(currentLocatio.toJson().toString());
                                });
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                                        },
                                        child: ITEMnearsrestaurant(currentshop: shopList[index], distance: CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(shopList[index].location)[0], CaculateDistance.parseDoubleString(shopList[index].location)[1], currentAccount.locationHis.Latitude, currentAccount.locationHis.Longitude),),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Container(
                        height: 92 + (ADStype2List.length / 2) * (((screenWidth/2) - 26)/4*5),
                        decoration: BoxDecoration(

                        ),

                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Text(
                                "Ưu đãi khác từ Masu",
                                style: TextStyle(
                                    fontFamily: 'DMSans_regu',
                                    color: Colors.black,
                                    fontSize: screenWidth/18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            Positioned(
                              top: 45,
                              left: 0,
                              child: Container(
                                  width: screenWidth,
                                  height: (ADStype2List.length % 2 == 0) ? (ADStype2List.length / 2) * (((screenWidth/2) - 15)/4*5) : ((ADStype2List.length / 2) + 1) * (((screenWidth/2) - 15)/4*5),
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),

                                  child: GridView.builder(
                                    itemCount: ADStype2List.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // số phần tử trên mỗi hàng
                                      mainAxisSpacing: 0, // khoảng cách giữa các hàng
                                      crossAxisSpacing: 0, // khoảng cách giữa các cột
                                      childAspectRatio: 0.8, // tỷ lệ chiều rộng và chiều cao
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 13.0),
                                        child: InkWell(
                                          onTap: () async {
                                            await _launchInBrowser(Uri.parse(ADStype2List[index].facebookLink));
                                          },
                                          child: ITEMadsType2(adStype2: ADStype2List[index], width: (screenWidth/2) - 26,),
                                        ),
                                      );
                                    },
                                  )
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 20,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  getCurrentLocation().then((value) {
                    currentLocatio.Longitude = value.longitude;
                    currentLocatio.Latitude = value.latitude;
                    print(currentLocatio.toJson().toString());
                  });
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlogin()));
                },
                child: Container(
                  width: screenWidth - 60,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 250, 241, 76),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellowAccent.withOpacity(0.4), // màu của shadow
                        spreadRadius: 2, // bán kính của shadow
                        blurRadius: 7, // độ mờ của shadow
                        offset: Offset(0, 3), // vị trí của shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Đăng nhập vào Masu',
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
