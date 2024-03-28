import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:masuapp/GENERAL/models/autocomplate_prediction.dart';
import 'package:masuapp/GENERAL/models/place_auto_complate_response.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/SCREEN/RESTAURANT/SCREENfoodcart.dart';
import 'package:uuid/uuid.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/accountLocation.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../ITEM/ITEMplaceAutoComplete.dart';
import 'SCREEN_LOCATION_FOOD1.dart';

class SCREENlocationfood extends StatefulWidget {
  final accountLocation location;
  const SCREENlocationfood({Key? key, required this.location}) : super(key: key);

  @override
  State<SCREENlocationfood> createState() => _SCREENlocationitemsendst1State();
}

class _SCREENlocationitemsendst1State extends State<SCREENlocationfood> {
  final textcontroller = TextEditingController();
  var uuid = Uuid();

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

  Future<double> getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z");


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('đã oke rồi');
        final distance = data['rows'][0]['elements'][0]['distance']['value'];
        // Khoảng cách được trả về ở đơn vị mét, bạn có thể chuyển đổi thành đơn vị khác nếu cần.
        return distance.toDouble()/1000;
      } else {
        throw Exception('Lỗi khi gửi yêu cầu tới Goong API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
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

  final accountLocation diemnhahang = accountLocation(phoneNum: currentAccount.phoneNum, LocationID: '', Latitude: currentAccount.locationHis.Latitude, Longitude: currentAccount.locationHis.Longitude, firstText: currentAccount.locationHis.firstText, secondaryText: currentAccount.locationHis.secondaryText);
  final accountLocation diemtra = accountLocation(phoneNum: currentAccount.phoneNum, LocationID: currentAccount.locationHis.LocationID, Latitude: currentAccount.locationHis.Latitude, Longitude: currentAccount.locationHis.Longitude, firstText: currentAccount.locationHis.firstText, secondaryText: currentAccount.locationHis.secondaryText);



  @override
  void initState() {
    super.initState();
    diemnhahang.Latitude = widget.location.Latitude;
    diemnhahang.Longitude = widget.location.Longitude;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),

            child: ListView(
              children: [
                Container(
                  height: 310,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),

                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 200,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(255, 255, 217, 169), Color.fromARGB(255, 255, 123, 64)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                          ),

                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 50,
                                left: 20,
                                child: Text(
                                  "Giao đồ ăn",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),

                              Positioned(
                                  top: 80,
                                  left: 20,
                                  child: Container(
                                    width: screenWidth/2,
                                    child: Text(
                                      "Chúng tôi sẽ phục vụ món ở bất kỳ đâu!",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'arial',
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                              ),

                              Positioned(
                                  top: 50,
                                  right: 10,
                                  child: Container(
                                    width: 100,
                                    height: 436/5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/image/linhtinh1.png')
                                        )
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          height: 150,
                          width: screenWidth - 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 0,
                                child: GestureDetector(
                                  child: Container(
                                    height: 74,
                                    width: screenWidth - 20,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 25,
                                          left: 10,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/image/bluecircle.png')
                                                )
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 15,
                                          left: 46,
                                          child: Container(
                                            width: screenWidth - 56,
                                            height: 20,
                                            child: AutoSizeText(
                                              'Địa chỉ nhà hàng',
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  fontFamily: 'arial',
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 38,
                                          left: 46,
                                          child: Container(
                                            width: screenWidth - 56,
                                            height: 17,
                                            child: AutoSizeText(
                                              compactString(33, diemnhahang.Latitude.toString() + ' , ' + diemnhahang.Longitude.toString()),
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  fontFamily: 'arial',
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    textcontroller.clear();
                                    toastMessage('Bạn không thể thay đổi địa chỉ nhà hàng');
                                  },
                                ),
                              ),

                              Positioned(
                                top: 75,
                                left: 10,
                                child: Container(
                                  height: 1,
                                  width: screenWidth - 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 76,
                                left: 0,
                                child: GestureDetector(
                                  child: Container(
                                    height: 74,
                                    width: screenWidth - 20,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 25,
                                          left: 10,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage('assets/image/locationRounditem.png')
                                                )
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 15,
                                          left: 46,
                                          child: Container(
                                            width: screenWidth - 56,
                                            height: 20,
                                            child: AutoSizeText(
                                              'Điểm nhận đơn',
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  fontFamily: 'arial',
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 38,
                                          left: 46,
                                          child: Container(
                                            width: screenWidth - 56,
                                            height: 17,
                                            child: AutoSizeText(
                                              compactString(33, diemtra.firstText + " " + diemtra.secondaryText),
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  fontFamily: 'arial',
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    textcontroller.clear();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: Container(
                                            height: 70,
                                            width: MediaQuery.of(context).size.width - 20,
                                            child: Material(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              elevation: 24.0,
                                              child: Container(
                                                  child: TypeAheadField(
                                                    textFieldConfiguration: TextFieldConfiguration(
                                                      controller: textcontroller,
                                                      onTap: () {
                                                        textcontroller.clear();
                                                      },
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        hintText: 'Tìm kiếm điểm nhận',
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
                                                          diemtra.firstText = suggestion.structuredFormatting!.mainText!;
                                                          diemtra.secondaryText = suggestion.structuredFormatting!.secondaryText!;
                                                          textcontroller.text = suggestion.description.toString();
                                                          double? la = await getLati(suggestion.placeId.toString());
                                                          double? long = await getLongti(suggestion.placeId.toString());
                                                          diemtra.Longitude = long!;
                                                          diemtra.Latitude = la!;
                                                          diemtra.LocationID = suggestion.placeId.toString();
                                                          Navigator.of(context).pop();
                                                          setState(() {

                                                          });
                                                        },
                                                      );
                                                    },

                                                    onSuggestionSelected: (AutocompletePrediction suggestion) async {

                                                    },
                                                  )
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///Nút back
                      Positioned(
                        top: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodcart()));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
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
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/backicon1.png'),
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),

                Container(height: 30,),

                Padding(
                  padding: EdgeInsets.only(bottom: 0, right: screenWidth*2/3 - 10, left: 10),
                  child: GestureDetector(
                    child: Container(
                      width: screenWidth/3,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: (diemtra.Longitude != 0 && diemtra.Latitude != 0) ? Color.fromARGB(255, 255, 123, 64) : Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tiếp tục',
                          style: TextStyle(
                              fontFamily: 'arial',
                              fontSize: 100,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      double distance = await getDistance(diemnhahang.Latitude, diemnhahang.Longitude, diemtra.Latitude, diemtra.Longitude);
                      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationfood1(Distance: distance, diemlay: diemnhahang, diemtra: diemtra,)));

                    },
                  ),
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
