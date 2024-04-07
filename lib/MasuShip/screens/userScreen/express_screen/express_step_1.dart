import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'dart:convert';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Temporary.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/action/change_name_and_phone.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/express_step_2.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';

import '../general/search_location_dialog.dart';

class express_step_1 extends StatefulWidget {
  const express_step_1({super.key});

  @override
  State<express_step_1> createState() => _express_step_1State();
}

class _express_step_1State extends State<express_step_1> {
  int weightType = 0;
  final itemController = TextEditingController();
  final moneyController = TextEditingController();
  final noteController = TextEditingController();
  Temporary sendName = Temporary(stringData: '', intData: 0, doubleData: 0);
  Temporary sendPhone = Temporary(stringData: '', intData: 0, doubleData: 0);
  Temporary receiverName = Temporary(stringData: '', intData: 0, doubleData: 0);
  Temporary receiverPhone = Temporary(stringData: '', intData: 0, doubleData: 0);
  Location start_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
  Location end_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
  String chosenWeight = '';
  List<String> weightList = ['Dưới 10kg', 'Từ 10 - 25kg', 'Trên 25kg'];

  Future<String> fetchLocationName(Location location) async {
    double longitude = location.longitude;
    double latitude = location.latitude;
    final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        location.mainText = data['results'][0]['formatted_address'];
        return data['results'][0]['formatted_address'];
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  void dropdownWeight(String? selectedValue) {
    if (selectedValue is String) {
      chosenWeight = selectedValue;
      if (chosenWeight == 'Dưới 10kg') {
        weightType = 0;
      }

      if (chosenWeight == 'Từ 10 - 25kg') {
        weightType = 1;
      }

      if (chosenWeight == 'Trên 25kg') {
        weightType = 2;
      }
    }
    setState(() {

    });
  }

  bool check_fill_data() {
    if (itemController.text.isNotEmpty) {
      if (start_location.longitude != 0 && start_location.latitude != 0 && end_location.longitude != 0 && end_location.latitude != 0) {
        if (sendName.stringData != '' && sendPhone.stringData != '' && receiverName.stringData != '' && receiverPhone.stringData != '') {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenWeight = weightList.first;
    sendName.stringData = finalData.user_account.name;
    sendPhone.stringData = finalData.user_account.phone;
    start_location.longitude = finalData.user_account.location.longitude;
    start_location.latitude = finalData.user_account.location.latitude;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade700 , Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
          child: ListView(
            children: [
              Container(height: 20,),

              Container(
                height: 30,
                child: Row(
                  children: [
                    Container(width: 10,),

                    GestureDetector(
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
                      },
                    )
                  ],
                ),
              ),

              Container(height: 20,),

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
                        bottom: 0,
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
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 20),
                            children: [
                              Container(height: 15,),

                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Mặt hàng cần gửi',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black, width: 1)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Form(
                                        child: TextFormField(
                                          controller: itemController,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'muli',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Bạn muốn gửi mặt hàng gì vậy?',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'muli',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 15,),

                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Trọng lượng',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black, width: 1)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: DropdownButton<String>(
                                        items: weightList.map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e, style: TextStyle(fontFamily: 'muli'),),
                                        )).toList(),
                                        onChanged: (value) { dropdownWeight(value); },
                                        value: chosenWeight,
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                    Icons.add_box_outlined,
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
                                      'Thông tin kiện hàng cần gửi',
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

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 240,
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
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(1000)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
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
                                          'Người gửi',
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
                                              return change_name_and_phone(Nametemporary: sendName, Phonetemporary: sendPhone, event: () {setState(() {});}, type: 1);
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    sendName.stringData + ' - ' + (sendPhone.stringData[0] != '0' ? '0' + sendPhone.stringData : sendPhone.stringData),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 10,),

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
                                          'Điểm lấy hàng',
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
                                              return search_location_dialog(location: start_location, title: 'Chọn điểm lấy hàng', event: () {
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

                              Container(height: 20,),
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
                                    Icons.send_and_archive_outlined,
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
                                      'Thông tin người gửi',
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

              Container(height: 0,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 240,
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
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(1000)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
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
                                          'Người nhận',
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
                                              return change_name_and_phone(Nametemporary: receiverName, Phonetemporary: receiverPhone, event: () {setState(() {});}, type: 2);
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    receiverName.stringData == '' ? 'Thêm thông tin người nhận' : (receiverName.stringData + ' - ' + (receiverPhone.stringData[0] != '0' ? '0' + receiverPhone.stringData : receiverPhone.stringData)),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'muli',
                                        color: receiverName.stringData == '' ? Colors.red :Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 10,),

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
                                          'Điểm giao hàng',
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
                                              return search_location_dialog(location: end_location, title: 'Chọn điểm giao', event: () {
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
                                  future: fetchLocationName(end_location),
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
                                          'Hãy chọn vị trí giao hàng',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.redAccent,
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
                                          'Hãy chọn vị trí giao hàng',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.redAccent,
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

                              Container(height: 20,),
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
                                    Icons.emoji_people_sharp,
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
                                      'Thông tin người nhận',
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

              Container(height: 0,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 120,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
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
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                        child: Form(
                                          child: TextFormField(
                                            controller: moneyController,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'muli',
                                            ),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số và dấu chấm
                                            ],
                                            keyboardType: TextInputType.numberWithOptions(decimal: true), // Hiển thị bàn phím số với dấu chấm
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Số tiền thu hộ',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: 'muli',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 35,
                                right: 30,
                                child: Text(
                                  '.đ',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 16,
                                    color: Colors.black,
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
                                    Icons.monetization_on_outlined,
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
                                      'Thu hộ',
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

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 240,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
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
                          child: Padding(
                            padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                child: Form(
                                    child: TextFormField(
                                      maxLines: null,
                                      controller: noteController,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'muli',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Ghi chú đơn hàng(không bắt buộc)',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'muli',
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                            ),
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
                                    Icons.note_alt_outlined,
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
                                      'Ghi chú đơn hàng',
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
                    height: 45,
                    decoration: BoxDecoration(
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
                    ),
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
                    if (check_fill_data()) {
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (BuildContext context) => express_step_2(sendName: sendName, sendPhone: sendPhone, receiverName: receiverName, receiverPhone: receiverPhone, start_location: start_location, end_location: end_location, weightType: weightType, item: itemController.text.toString(), money: double.parse(moneyController.text.toString()), note: noteController.text.toString()),
                      ),
                      );
                    } else {
                      toastMessage('Bạn cần điền đủ thông tin');
                    }
                  },
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
