import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masuapp/GENERAL/NormalUser/accountLocation.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/SCREEN/BEFORE/Page%20t%C3%ACm%20ki%E1%BA%BFm.dart';
import 'package:masuapp/SCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/NormalUser/Area.dart';
import '../../GENERAL/Order/Cost.dart';
import '../../GENERAL/models/autocomplate_prediction.dart';
import '../../GENERAL/models/place_auto_complate_response.dart';
import '../../ITEM/ITEMplaceAutoComplete.dart';

class SCREENselectLocation extends StatefulWidget {
  const SCREENselectLocation({Key? key}) : super(key: key);

  @override
  State<SCREENselectLocation> createState() => _SCREENselectLocationState();
}

class _SCREENselectLocationState extends State<SCREENselectLocation> {
  final textcontroller = TextEditingController();
  final List<Area> areaList = [];
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  var uuid = Uuid();

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        if (area.status == 0) {
          areaList.add(area);
        }
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(currentAccount.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
        Area areas= Area.fromJson(orders);
        area.name = areas.name;
        area.status = areas.status;
        area.id = areas.id;
      setState(() {

      });
    });
  }

  Future<double?> getLongti(String placeId) async {
    final baseUrl = "rsapi.goong.io";
    final path = "/Geocode";
    final queryParams = {
      "place_id": placeId,
      "api_key": 'npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z',
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
      "api_key": 'npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z',
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
    final url = Uri.parse('https://rsapi.goong.io/Place/AutoComplete?api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z&input=$query');

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

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? header}) async {
    try {
      final response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> pushData(accountLocation location) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + '/locationHis').set(location.toJson());
      toastMessage('Xác nhận vị trí thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData1(String id) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + '/Area').set(id);
      toastMessage('Xác nhận vị trí thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> getBikecost(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + id + '/Bike').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      Cost cost = Cost.fromJson(catchOrderData);
      bikeCost.discount = cost.discount;
      bikeCost.perKMcost = cost.perKMcost;
      bikeCost.departCost = cost.departCost;
      bikeCost.departKM = cost.departKM;
    }
  }

  Future<void> getCarcost(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + id + '/Car').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      Cost cost = Cost.fromJson(catchOrderData);
      carCost.discount = cost.discount;
      carCost.perKMcost = cost.perKMcost;
      carCost.departCost = cost.departCost;
      carCost.departKM = cost.departKM;
    }
  }

  Future<void> getFoodcost(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + id + '/Food').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      Cost cost = Cost.fromJson(catchOrderData);
      FoodCost.discount = cost.discount;
      FoodCost.perKMcost = cost.perKMcost;
      FoodCost.departCost = cost.departCost;
      FoodCost.departKM = cost.departKM;
    }
  }

  Future<void> getSendcost(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + id + '/Item').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      Cost cost = Cost.fromJson(catchOrderData);
      ItemCost.discount = cost.discount;
      ItemCost.perKMcost = cost.perKMcost;
      ItemCost.departCost = cost.departCost;
      ItemCost.departKM = cost.departKM;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String locationText = 'Chưa chọn vị trí';
    if (currentAccount.locationHis != null) {
      if (currentAccount.locationHis.Longitude != 0) {
        locationText = currentAccount.locationHis.firstText;
      }
    }

    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 50,
                  left: 10,
                  child: Container(
                    width: screenWidth - 50,
                    height: 50,
                    child: AutoSizeText(
                      'Chào bạn ! Bạn có còn ở đây không ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'arial',
                        fontSize: 100,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),

                Positioned(
                  top: 110,
                  left: 10,
                  child: Container(
                    width: screenWidth - 40,
                    height: 40,
                    child: AutoSizeText(
                      'Để thuận tiện cho việc giao hàng chính xác địa điểm. Vui lòng kiểm tra thông tin vị trí bên dưới',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontFamily: 'arial',
                        fontSize: 100,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),

                Positioned(
                  top: 175,
                  left: 10,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/locationRounditem.png')
                      )
                    ),
                ),
                ),

                Positioned(
                  top: 170,
                  left: 60,
                  child: Container(
                    width: screenWidth - 40,
                    height: 20,
                    child: AutoSizeText(
                      'Bạn muốn giao hàng đến đây',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontFamily: 'arial',
                        fontSize: 100,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),

                Positioned(
                  top: 195,
                  left: 60,
                  child: Container(
                    width: screenWidth - 80,
                    height: 25,
                    decoration: BoxDecoration(

                    ),
                    child: AutoSizeText(
                      locationText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'arial',
                        fontSize: 100,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: GestureDetector(
                    child: Container(
                        width: screenWidth - 40,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 244, 246)
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Chọn vị trí khác',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 100,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
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
                ),

                Positioned(
                  bottom: 85,
                  left: 20,
                  child: GestureDetector(
                    child: Container(
                      width: screenWidth - 40,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 244, 164, 84)
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Sử dụng vị trí này',
                          style: TextStyle(
                              fontFamily: 'arial',
                              fontSize: 100,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (currentAccount.locationHis.Longitude == 0) {
                        toastMessage('Bạn chưa chọn vị trí nào');
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // chọn khu vực
                              return AlertDialog(
                                title: Text('Chọn khu vực', style: TextStyle(fontFamily: 'arial', fontSize: 16),),
                                content: Container(
                                    height: 60,
                                    width: screenWidth,
                                    child: ListView(
                                      children: [
                                        Container(
                                          height: 20,
                                          child: AutoSizeText(
                                            'Bạn hiện đang ở khu vực',
                                            style: TextStyle(
                                                fontSize: 100,
                                                color: Color.fromARGB(255, 244, 164, 84),
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),

                                        Container(height: 6,),

                                        Container(
                                          height: 20,
                                          child: AutoSizeText(
                                            compactString(30, area.name),
                                            style: TextStyle(
                                                fontSize: 100
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Khu vực khác'),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Chọn khu vực'),
                                              content: Container(
                                                width: screenWidth - 40,
                                                height: 200,
                                                child: searchPageArea(list: areaList, area: area),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Chọn khu vực này'),
                                                  onPressed: () async {
                                                    await pushData1(area.id);
                                                    await pushData(currentAccount.locationHis);
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENmain(),),);
                                                  },
                                                ),
                                              ],
                                            );
                                          }
                                      );
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Tiếp tục'),
                                    onPressed: () async {
                                      await pushData(currentAccount.locationHis);
                                      await getBikecost(currentAccount.Area);
                                      await getCarcost(currentAccount.Area);
                                      await getFoodcost(currentAccount.Area);
                                      await getSendcost(currentAccount.Area);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENmain(),),);
                                    },
                                  ),
                                ],
                              );
                            }
                        );
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
        }
    );
  }
}
