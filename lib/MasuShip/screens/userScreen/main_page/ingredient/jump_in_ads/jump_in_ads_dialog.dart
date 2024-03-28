import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/adsData/restaurantAdsData.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

class jump_in_ads_dialog extends StatefulWidget {
  const jump_in_ads_dialog({super.key});

  @override
  State<jump_in_ads_dialog> createState() => _jump_in_ads_dialogState();
}

class _jump_in_ads_dialogState extends State<jump_in_ads_dialog> {
  final PageController _pageController = PageController(viewportFraction: 1, keepPage: true);
  Timer? _timer;
  int _currentPage = 0;

  List<restaurantAdsData> dataList = [];

  void get_ads_jump_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Ads").orderByChild('direction').equalTo(1).onValue.listen((event) {
      final dynamic ads = event.snapshot.value;

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

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('Ads').child(imagePath);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ads_jump_data();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < dataList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 2000),
        curve: Curves.easeInSine,
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    double height = (MediaQuery.of(context).size.width - 40)/2 + 40;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              bottom: 10,
              left: 5,
              right: 5,
              child: dataList.length == 0 ? Container(alignment: Alignment.center, child: Text('Chưa có quảng cáo', style: TextStyle(fontFamily: 'muli'),),) : Container(
                child: PageView.builder(
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
            )
          ],
        ),
      ),
    );
  }
}
