import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_step_2.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/search_location_dialog.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class type_one_bike_step_1 extends StatefulWidget {
  const type_one_bike_step_1({super.key});

  @override
  State<type_one_bike_step_1> createState() => _type_one_bike_step_1State();
}

class _type_one_bike_step_1State extends State<type_one_bike_step_1> {
  bool loading = false;
  String locationName = '';
  Location start_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
  Location end_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');

  Future<String> fetchLocationName(Location location) async {
    double latitude = location.latitude;
    double longitude = location.longitude;
    final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        locationName = data['results'][0]['formatted_address'];
        start_location.mainText = locationName;
        return data['results'][0]['formatted_address'];
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start_location = finalData.user_account.location;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
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
                                  text: 'Gọi xe ôm',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),

                                TextSpan(
                                  text: ' đi đến đâu',
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
                  height: width/3*2,
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

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return search_location_dialog(location: start_location, title: 'Chọn điểm đón', event: () {
                                                setState(() {

                                                });
                                              });
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: FutureBuilder(
                                  future: fetchLocationName(start_location),
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
                                              image: AssetImage('assets/image/redcircle.png')
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
                                          'Điểm đến',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    ),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return search_location_dialog(location: end_location, title: 'Chọn điểm đến', event: () {
                                              setState(() {

                                              });
                                            });
                                          }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      end_location.latitude == 0 ? 'Hãy chọn điểm đến nhé !' : (end_location.mainText + ' ' + end_location.secondaryText),
                                      style: TextStyle(
                                          fontFamily: 'muli',
                                          color: end_location.latitude == 0 ? Colors.red :Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  onTap: () {

                                  },
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
                          decoration: get_usually_decoration(),
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
                                      'Đặt xe chỉ với 2 bước',
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

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  child: Container(
                    height: end_location.longitude != 0 ? 45 : 0,
                    decoration: end_location.longitude != 0 ?  BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.yellow],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // màu của shadow
                          spreadRadius: 2, // bán kính của shadow
                          blurRadius: 7, // độ mờ của shadow
                          offset: Offset(0, 3), // vị trí của shadow
                        ),
                      ],
                    ) : null,
                    child: Center(
                      child: Text(
                        'Bước tiếp theo',
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (start_location.latitude != 0 && start_location.longitude != 0 && end_location.latitude != 0 && end_location.longitude != 0) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_one_bike_step_2(start_location: start_location, end_location: end_location),),);
                    } else {
                      toastMessage('Cần chọn điểm đón, trả');
                    }
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


