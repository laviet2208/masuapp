import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../ITEM/ITEMplaceAutoComplete.dart';
import '../FINAL/finalClass.dart';
import '../GENERAL/NormalUser/accountLocation.dart';
import '../GENERAL/models/autocomplate_prediction.dart';
import '../GENERAL/models/place_auto_complate_response.dart';
import '../SCREEN/RESTAURANT/Đặt đơn món ăn/SCREEN_LOCATION_FOOD.dart';
import '../SCREEN/RESTAURANT/Đặt đơn món ăn/SCREEN_LOCATION_FOOD1.dart';
import '../SCREEN/FEATURE/SCREEN_itemsend/SCREEN_LOCATION_ITEMSEND_ST2.dart';
class SCREENmappicker extends StatefulWidget {
  final int type;
  const SCREENmappicker({Key? key, required this.type}) : super(key: key);

  @override
  State<SCREENmappicker> createState() => _SCREENmappickerState();
}

class _SCREENmappickerState extends State<SCREENmappicker> {
  String buttonText = '20.9826103,105.7087642';
  accountLocation thislocation = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA");
  final textcontroller = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9826103,105.7087642),
    zoom: 14.4746,
  );
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

  Future<double> getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final String apiKey = 'AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA';
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$startLatitude,$startLongitude&destination=$endLatitude,$endLongitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final distanceInMeters = data['routes'][0]['legs'][0]['distance']['value'];
      final distanceInKm = distanceInMeters / 1000;
      print(distanceInKm.toString());
      return distanceInKm.toDouble();
    } else {
      throw Exception('Không thể lấy khoảng cách. Mã lỗi: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (CameraPosition newPosition) async {
                    thislocation.Longitude = newPosition.target.longitude;
                    thislocation.Latitude = newPosition.target.latitude;
                    buttonText = thislocation.Latitude.toString() + " , " + thislocation.Longitude.toString();
                    setState(() {

                    });
                  },
                ),

                Center(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 36,
                  ),
                ),

                Positioned(
                  top: 60,
                  left: 70,
                  child: Container(
                      height: 60,
                      width: screenWidth - 90,
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

                            },
                          );
                        },

                        onSuggestionSelected: (AutocompletePrediction suggestion) async {

                          textcontroller.text = suggestion.description.toString();
                          double? la = await getLati(suggestion.placeId.toString());
                          double? long = await getLongti(suggestion.placeId.toString());
                          LatLng _target = LatLng(
                            la!,long!
                          );
                          
                          CameraPosition newcam = CameraPosition(
                            target: _target,
                            zoom: 18,
                          );

                          final GoogleMapController controller = await _controller.future;
                          await controller.animateCamera(CameraUpdate.newCameraPosition(newcam));
                        },
                      )
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () async{
                      if (widget.type == 1) {
                        bikeSetLocation.Latitude = thislocation.Latitude;
                        bikeSetLocation.Longitude = thislocation.Longitude;
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest1()));
                      }

                      if (widget.type == 11) {
                        bikeGetLocation.Latitude = thislocation.Latitude;
                        bikeGetLocation.Longitude = thislocation.Longitude;
                        double distance = await getDistance(bikeSetLocation.Latitude, bikeSetLocation.Longitude, bikeGetLocation.Latitude, bikeGetLocation.Longitude);
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest2(Distance: distance,)));
                      }

                      if (widget.type == 2) {
                        bikeSetLocation.Latitude = thislocation.Latitude;
                        bikeSetLocation.Longitude = thislocation.Longitude;
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationcarst1()));
                      }

                      if (widget.type == 21) {
                        bikeGetLocation.Latitude = thislocation.Latitude;
                        bikeGetLocation.Longitude = thislocation.Longitude;
                        double distance = await getDistance(bikeSetLocation.Latitude, bikeSetLocation.Longitude, bikeGetLocation.Latitude, bikeGetLocation.Longitude);
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationcarst2(Distance: distance,)));
                      }

                      if (widget.type == 3) {
                        bikeSetLocation.Latitude = thislocation.Latitude;
                        bikeSetLocation.Longitude = thislocation.Longitude;
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst1()));
                      }

                      if (widget.type == 31) {
                        bikeGetLocation.Latitude = thislocation.Latitude;
                        bikeGetLocation.Longitude = thislocation.Longitude;
                        double distance = await getDistance(bikeSetLocation.Latitude, bikeSetLocation.Longitude, bikeGetLocation.Latitude, bikeGetLocation.Longitude);
                        currentReceiver.location = bikeGetLocation;
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst2(Distance: distance,)));
                      }

                      if (widget.type == 4) {
                        bikeGetLocation.Latitude = thislocation.Latitude;
                        bikeGetLocation.Longitude = thislocation.Longitude;
                        print(bikeSetLocation.toJson().toString());
                        setState(() {
                          startcontroller.text = bikeGetLocation.firstText;
                        });
                        double dis = await getDistance(bikeSetLocation.Latitude, bikeSetLocation.Longitude, bikeGetLocation.Latitude, bikeGetLocation.Longitude);
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationfood1(Distance: dis,)));
                      }
                    },

                    child: Container(
                      width: screenWidth - 40,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 177, 79),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontFamily: 'arial',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 65,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      //back về màn hình đặt xe máy
                      if (widget.type == 1 || widget.type == 11) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest1()));
                      }

                      //back về màn hình đặt ô tô
                      if (widget.type == 2 || widget.type == 21) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationcarst1()));
                      }

                      //back về màn hình giao hàng
                      if (widget.type == 3 || widget.type == 31) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst1()));
                      }

                      //back về màn hình đồ ăn
                      if (widget.type == 4) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationfood()));
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/backicon1.png'),
                        ),
                        color: Colors.white
                      ),
                    ),
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
