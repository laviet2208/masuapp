import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_main_screen/shop_type_item.dart';

class restaurant_main_screen extends StatefulWidget {
  const restaurant_main_screen({super.key});

  @override
  State<restaurant_main_screen> createState() => _restaurant_main_screenState();
}

class _restaurant_main_screenState extends State<restaurant_main_screen> {
  String locationName = '';

  void fetchLocationName(double latitude, double longitude) async {
    final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLocationName(finalData.user_account.location.latitude, finalData.user_account.location.longitude);
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
                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: (width - 40)*3/4 + 60,
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
                      )
                    ],
                  ),
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
