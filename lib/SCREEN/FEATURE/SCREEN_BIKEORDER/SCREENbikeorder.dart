import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masuapp/GENERAL/NormalUser/accountLocation.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/models/autocomplate_prediction.dart';
import '../../../GENERAL/models/place_auto_complate_response.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../../ITEM/ITEMplaceAutoComplete.dart';
import '../../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'SCREEN_LOCATION_BIKE_ST2.dart';

class SCREENbikeorder extends StatefulWidget {
  const SCREENbikeorder({Key? key}) : super(key: key);

  @override
  State<SCREENbikeorder> createState() => _SCREENbikeorderState();
}

class _SCREENbikeorderState extends State<SCREENbikeorder> {
  final textcontroller = TextEditingController();
  var uuid = Uuid();

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

  Future<double> getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf");


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

  final accountLocation diemdonkhach = accountLocation(phoneNum: currentAccount.phoneNum, LocationID: '', Latitude: currentAccount.locationHis.Latitude, Longitude: currentAccount.locationHis.Longitude, firstText: currentAccount.locationHis.firstText, secondaryText: currentAccount.locationHis.secondaryText);
  final accountLocation diemtrakhach = accountLocation(phoneNum: currentAccount.phoneNum, LocationID: '', Latitude: 0, Longitude: 0, firstText: 'Bạn muốn đi đến đâu ?', secondaryText: '');

  @override
  Widget build(BuildContext context) {
    String diemden = 'Bạn muốn đi đâu ?';
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
                                "Masu Bike",
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
                                    "Chúng tôi sẽ đưa bạn tới bất kỳ đâu!",
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
                                              'Điểm đón',
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
                                              compactString(33, diemdonkhach.firstText + ' , ' + diemdonkhach.secondaryText),
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
                                                        hintText: 'Tìm kiếm điểm đón',
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
                                                          diemdonkhach.firstText = suggestion.structuredFormatting!.mainText!;
                                                          diemdonkhach.secondaryText = suggestion.structuredFormatting!.secondaryText!;
                                                          textcontroller.text = suggestion.description.toString();
                                                          double? la = await getLati(suggestion.placeId.toString());
                                                          double? long = await getLongti(suggestion.placeId.toString());
                                                          diemdonkhach.Longitude = long!;
                                                          diemdonkhach.Latitude = la!;
                                                          diemdonkhach.LocationID = suggestion.placeId.toString();
                                                          Navigator.of(context).pop();
                                                          setState(() {

                                                          });
                                                        },
                                                      );
                                                    },
                                                    onSuggestionSelected: (AutocompletePrediction suggestion) async {},
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
                                              'Điểm đến',
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
                                              compactString(33, diemtrakhach.firstText + " " + diemtrakhach.secondaryText),
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
                                                        hintText: 'Tìm kiếm điểm đi',
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
                                                          diemtrakhach.firstText = suggestion.structuredFormatting!.mainText!;
                                                          diemtrakhach.secondaryText = suggestion.structuredFormatting!.secondaryText!;
                                                          textcontroller.text = suggestion.description.toString();
                                                          double? la = await getLati(suggestion.placeId.toString());
                                                          double? long = await getLongti(suggestion.placeId.toString());
                                                          diemtrakhach.Longitude = long!;
                                                          diemtrakhach.Latitude = la!;
                                                          diemtrakhach.LocationID = suggestion.placeId.toString();
                                                          Navigator.of(context).pop();
                                                          setState(() {

                                                          });
                                                        },
                                                      );
                                                    },

                                                    onSuggestionSelected: (AutocompletePrediction suggestion) async {
                                                      // textcontroller.text = suggestion.description.toString();
                                                      // double? la = await getLati(suggestion.placeId.toString());
                                                      // double? long = await getLongti(suggestion.placeId.toString());
                                                      // diemtrakhach.Longitude = long!;
                                                      // diemtrakhach.Latitude = la!;
                                                      // diemtrakhach.LocationID = suggestion.placeId.toString();

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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
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
                        color: (diemtrakhach.Longitude != 0 && diemtrakhach.Latitude != 0) ? Color.fromARGB(255, 255, 123, 64) : Colors.white
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
                    double distance = await getDistance(diemdonkhach.Latitude, diemdonkhach.Longitude, diemtrakhach.Latitude, diemtrakhach.Longitude);
                    Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest2(Distance: distance, diemdon: diemdonkhach, diemtra: diemtrakhach,)));
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
