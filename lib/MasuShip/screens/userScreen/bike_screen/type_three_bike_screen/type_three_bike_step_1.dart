import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_step_2.dart';
import '../../../../Data/locationData/Location.dart';
import '../../main_screen/user_main_screen.dart';
import 'dart:convert';

class type_three_bike_step_1 extends StatefulWidget {
  const type_three_bike_step_1({super.key});

  @override
  State<type_three_bike_step_1> createState() => _type_three_bike_screen_step_1State();
}

class _type_three_bike_screen_step_1State extends State<type_three_bike_step_1> {
  bool loading = false;
  String locationName = '';
  Location location_set = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');

  Future<String> fetchLocationName(double latitude, double longitude) async {
    final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        locationName = data['results'][0]['formatted_address'];
        location_set.mainText = locationName;
        return data['results'][0]['formatted_address'];
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  void change_to_next_step(int customer, int bike) {
    location_set.longitude = finalData.user_account.location.longitude;
    location_set.latitude = finalData.user_account.location.latitude;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_three_bike_step_2(beforeWidget: type_three_bike_step_1(), customer_number: customer, bike_number: bike, startLocation: location_set,),),);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: ListView(
            children: [
              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withOpacity(0.2), Colors.yellow],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: -70,
                                bottom: 0,
                                child: Container(

                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/bikeLogo1.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Bạn muốn\n',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),

                                  TextSpan(
                                    text: 'Tài xế lái hộ',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),

                                  TextSpan(
                                    text: ' về đâu',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 170,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/orangecircle.png')
                                          )
                                      ),
                                    ),

                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: width - 40 - 30 - 30 - 10,
                                        child: AutoSizeText(
                                          'Điểm đón',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: FutureBuilder(
                                  future: fetchLocationName(finalData.user_account.location.latitude, finalData.user_account.location.longitude),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Đang tải vị trí...',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Lỗi dữ liệu vị trí, vui lòng thoát ra thử lại',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }

                                    if (!snapshot.hasData) {
                                      print(snapshot.hasData.toString());
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Lỗi dữ liệu vị trí, vui lòng thoát ra thử lại',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }

                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Container(
                                width: 30,
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.add_location_alt_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Vị trí hiện tại của bạn',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Masu cung cấp tới quý khách gợi ý số người và xe lái hộ.',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 15,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 10,),

                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: GestureDetector(
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 6,
                                          bottom: 6,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                AutoSizeText(
                                                  'Lựa chọn 1: ',
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                AutoSizeText(
                                                  '1 người và 1 xe máy',
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 30,
                                            child: Icon(
                                              Icons.keyboard_double_arrow_right,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    change_to_next_step(1, 1);
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: Container(
                                  height: 5,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.3,
                                              color: Colors.black
                                          )
                                      )
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: GestureDetector(
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 6,
                                          bottom: 6,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                AutoSizeText(
                                                  'Lựa chọn 2: ',
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                AutoSizeText(
                                                  '2 người và 1 xe máy',
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 30,
                                            child: Icon(
                                              Icons.keyboard_double_arrow_right,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    change_to_next_step(2, 1);
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: Container(
                                  height: 5,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.3,
                                              color: Colors.black
                                          )
                                      )
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: GestureDetector(
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 6,
                                          bottom: 6,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                AutoSizeText(
                                                  'Lựa chọn 3: ',
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                AutoSizeText(
                                                  '2 người và 2 xe máy',
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 100,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 30,
                                            child: Icon(
                                              Icons.keyboard_double_arrow_right,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    change_to_next_step(2, 2);
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: Container(
                                  height: 5,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.3,
                                              color: Colors.black
                                          )
                                      )
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Hoặc liên hệ với tổng đài Masu Ship nếu muốn đặt nhiều hơn.',
                                    style: TextStyle(
                                        fontFamily: 'muli',
                                        fontSize: 15,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.people_outline,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Lựa chọn số xe và người',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),
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
