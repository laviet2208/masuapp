import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masuapp/SCREEN/RESTAURANT/Qu%E1%BA%A3n%20l%C3%BD%20data.dart';
import '../../FINAL/finalClass.dart';
import '../../GENERAL/models/autocomplate_prediction.dart';
import '../../GENERAL/models/place_auto_complate_response.dart';
import '../../GENERAL/utils/utils.dart';
import '../../ITEM/ITEMplaceAutoComplete.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'Quản lý danh mục/Danh mục.dart';
import 'Quản lý danh mục/Item danh mục.dart';
import 'SCREENfoodcart.dart';
import 'Xem thể loại/SCREENviewTypeshop.dart';

class SCREENshopmain extends StatefulWidget {
  const SCREENshopmain({Key? key}) : super(key: key);

  @override
  State<SCREENshopmain> createState() => _SCREENshopmainState();
}

class _SCREENshopmainState extends State<SCREENshopmain> {
  List<RestaurantDirectory> directoryList = [];
  final textcontroller = TextEditingController();

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("RestaurantDirectory").onValue.listen((event) {
      directoryList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        RestaurantDirectory acc = RestaurantDirectory.fromJson(value);
        if (acc.Area == currentAccount.Area) {
          directoryList.add(acc);
        }

        setState(() {});
      });

    });
  }

  Future<double?> getLongti(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": '3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf',
    };

    final uri = Uri.https(baseUrl, path, queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK" && data["results"].length > 0) {
        final location = data["results"][0]["geometry"]["location"];
        return location["lng"];
      } else {
        print("Không tìm thấy địa điểm hoặc có lỗi khi truy vấn.");
        return null;
      }
    } else {
      print("Lỗi kết nối: ${response.statusCode}");
      return null;
    }
  }

  Future<double?> getLati(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": '3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf',
    };

    final uri = Uri.https(baseUrl, path, queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK" && data["results"].length > 0) {
        final location = data["results"][0]["geometry"]["location"];
        return location["lat"];
      } else {
        print("Không tìm thấy địa điểm hoặc có lỗi khi truy vấn.");
        return null;
      }
    } else {
      print("Lỗi kết nối: ${response.statusCode}");
      return null;
    }
  }

  Future<List<AutocompletePrediction>> placeAutocomplete(String query) async{
    List<AutocompletePrediction> placePredictions = [];
    final url = Uri.parse('https://rsapi.goong.io/Place/AutoComplete?api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf&input=$query');

    var response = await http.get(url);

    if (response != null) {
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response.body);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }

    return placePredictions;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
                              width: screenWidth,
                              height: 170,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: screenWidth,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.orangeAccent, Color.fromARGB(255, 255, 123, 64)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [0.0, 1.0],
                                        ),
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
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Dmsan_regular',
                                            ),

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(Icons.search),
                                              hintText: 'Bạn muốn ăn gì?',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'Dmsan_regular',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: GestureDetector(
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage('assets/image/backicon1.png')
                                            )
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                                      },
                                    ),
                                  ),

                                  Positioned(
                                    top: 55,
                                    left: 15,
                                    child: GestureDetector(
                                      child: Container(
                                        width: screenWidth - 60 - 20,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Giao tới\n',
                                                style: TextStyle(
                                                  fontFamily: 'arial',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: currentAccount.locationHis.firstText + ',' + currentAccount.locationHis.secondaryText,
                                                style: TextStyle(
                                                  fontFamily: 'arial',
                                                  color: Colors.white, // Đặt màu đỏ cho phần này
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        textcontroller.clear();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.only(
                                                  top: 16.0, // Điều chỉnh khoảng cách từ phía trên
                                                  right: 8.0,
                                                  bottom: 8.0,
                                                  left: 8.0,
                                                ),
                                                content: Container(
                                                    height: 60,
                                                    width: screenWidth,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 0),
                                                      child: Container(
                                                          height: 60,
                                                          width: screenWidth,
                                                          child: TypeAheadField(
                                                            textFieldConfiguration: TextFieldConfiguration(
                                                              controller: textcontroller,
                                                              onTap: () {
                                                                textcontroller.clear();
                                                              },
                                                              decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                hintText: 'Tìm kiếm',
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.white),
                                                                  borderRadius: BorderRadius.circular(25.7),
                                                                ),
                                                                enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.white),
                                                                  borderRadius: BorderRadius.circular(25.7),
                                                                ),
                                                              ),
                                                            ),

                                                            noItemsFoundBuilder: (context) => SizedBox.shrink(),


                                                            suggestionsCallback: (pattern) async {
                                                              return await placeAutocomplete(pattern);
                                                            },

                                                            itemBuilder: (context, suggestion) {
                                                              return ITEMplaceAutoComplete(location: suggestion, width: screenWidth,
                                                                onTap: () async {
                                                                  toastMessage('Vui lòng chờ, thử click lại nếu chưa được');
                                                                  currentAccount.locationHis.firstText = suggestion.structuredFormatting!.mainText!;
                                                                  currentAccount.locationHis.secondaryText = suggestion.structuredFormatting!.secondaryText!;
                                                                },
                                                              );
                                                            },

                                                            onSuggestionSelected: (AutocompletePrediction suggestion) async {

                                                              textcontroller.text = suggestion.description.toString();
                                                              double? la = await getLati(suggestion.placeId.toString());
                                                              double? long = await getLongti(suggestion.placeId.toString());
                                                              currentAccount.locationHis.Longitude = long!;
                                                              currentAccount.locationHis.Latitude = la!;
                                                              currentAccount.locationHis.LocationID = suggestion.placeId.toString();
                                                              setState(() {

                                                              });
                                                            },
                                                          )
                                                      ),
                                                    )
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(height: 10,),

                            Container(
                              height: ((screenWidth - 40)/4) * 3 + 15,
                              child: GridView.builder(
                                itemCount: 9,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, // số phần tử trên mỗi hàng
                                  mainAxisSpacing: 0, // khoảng cách giữa các hàng
                                  crossAxisSpacing: 0, // khoảng cách giữa các cột
                                  childAspectRatio: 1, // tỷ lệ chiều rộng và chiều cao
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: GestureDetector(
                                        child: Container(
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                  width: ((screenWidth - 40)/4) - 10,
                                                  height: (((screenWidth - 40)/4) - 10)/276*200,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(dataManager.dataList[index])
                                                      )
                                                  ),
                                                ),
                                              ),

                                              Positioned(
                                                top: (((screenWidth - 40)/4) - 10)/276*200 + 3,
                                                left: 0,
                                                child: Container(
                                                  height: 13,
                                                  width: ((screenWidth - 40)/4 - 10),
                                                  alignment: Alignment.center,
                                                  child: AutoSizeText(
                                                    dataManager.dataName[index],
                                                    style: TextStyle(
                                                        fontSize: 100,
                                                        fontFamily: 'arial',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENviewTypeshop(Type: index, Title: dataManager.dataName[index],)));
                                    },
                                  );
                                },
                              ),
                            ),

                            Container(height: 30,),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Container(
                                height: 340 * (directoryList.length.toDouble()),
                                decoration: BoxDecoration(

                                ),
                                child: ListView.builder(
                                  itemCount: directoryList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: InkWell(
                                        onTap: () {

                                        },
                                        child: Itemdanhmucchinh(width: screenWidth, height: 340, restaurantDirectory: directoryList[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                          ],
                        )
                    ),
                  ),

                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: () {
                          if (cartList.length == 0) {
                            toastMessage('Giỏ hàng chưa có sản phẩm nào');
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodcart()));
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/carticon.png')
                              )
                          ),

                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Text(
                                    cartList.length.toString(),
                                    style: TextStyle(
                                      fontFamily: 'arial',
                                      color: Colors.white,
                                      fontSize: 7,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            )
        ),
        onWillPop: () async {
          return false;
        },
    );
  }
}
