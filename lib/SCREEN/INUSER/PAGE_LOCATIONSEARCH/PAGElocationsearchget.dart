import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/models/autocomplate_prediction.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../../ITEM/ITEMplaceAutoComplete.dart';
import '../../../MAPPICKER/SCREENmappicker.dart';
import '../../FEATURE/SCREEN_BIKEORDER/SCREEN_LOCATION_BIKE_ST2.dart';

class Pagelocationsearchget extends StatefulWidget {
  final List<AutocompletePrediction> placePredictions;
  const Pagelocationsearchget({Key? key, required this.placePredictions}) : super(key: key);

  @override
  State<Pagelocationsearchget> createState() => _PagelocationsearchgetState();
}

class _PagelocationsearchgetState extends State<Pagelocationsearchget> {

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
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top : 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            width: screenWidth-40,
                            height: screenHeight/2,
                            decoration: BoxDecoration(

                            ),
                            child: ListView.builder(
                                itemCount: widget.placePredictions.length,
                                padding: EdgeInsets.only(top: 0), // Loại bỏ khoảng trống ở đỉnh danh sách
                                itemBuilder: (context, index) {
                                  return ITEMplaceAutoComplete(location: widget.placePredictions[index], width: screenWidth,
                                    onTap: () async {
                                      bikeGetLocation.LocationID = widget.placePredictions[index].placeId.toString();
                                      bikeGetLocation.firstText = widget.placePredictions[index].description.toString();
                                      if (widget.placePredictions[index].structuredFormatting!.secondaryText.toString() != null) {
                                        bikeGetLocation.secondaryText = widget.placePredictions[index].structuredFormatting!.secondaryText.toString();
                                      } else {
                                        bikeGetLocation.secondaryText = 'NA';
                                      }
                                      bikeGetLocation.Longitude = (await getLongti(widget.placePredictions[index].placeId.toString()))!;
                                      bikeGetLocation.Latitude = (await getLati(widget.placePredictions[index].placeId.toString()))!;
                                      toastMessage('bạn đã chọn điểm đến là ' + bikeGetLocation.firstText);
                                      setState(() {
                                        endcontroller.text = bikeGetLocation.firstText;
                                      });
                                      print(bikeGetLocation.toJson().toString());
                                      chosenvoucher.id = 'NA';
                                      double distance = await getDistance(bikeSetLocation.Latitude, bikeSetLocation.Longitude, bikeGetLocation.Latitude, bikeGetLocation.Longitude);
                                      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest2(Distance: distance, diemdon: bikeGetLocation, diemtra: bikeSetLocation,)));
                                    },
                                  );
                                }
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmappicker(type: 11,)));
                          },

                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: screenWidth-40,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey
                                  )
                              ),

                              child: Text(
                                "Xem trong map",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'arial',
                                    fontSize: 13
                                ),
                              ),
                            ),
                          ),

                        ),
                      )
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}
