import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import '../../../Data/locationData/Location.dart';
import '../../../Data/models/autocomplate_prediction.dart';
import '../../../Data/models/item_autocomplete.dart';
import '../../../Data/models/place_auto_complate_response.dart';

class search_location_dialog extends StatefulWidget {
  final Location location;
  final String title;
  final VoidCallback event;
  const search_location_dialog({super.key, required this.location, required this.event, required this.title});

  @override
  State<search_location_dialog> createState() => _search_location_dialogState();
}

class _search_location_dialogState extends State<search_location_dialog> {
  final locationText = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text(widget.title, style: TextStyle(fontFamily: 'muli', fontSize: 15),),
      content: Container(
        height: 70,
        width: MediaQuery.of(context).size.width - 30,
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Container(
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: locationText,
                  onTap: () {
                    locationText.clear();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Tìm kiếm địa điểm',
                    hintStyle: TextStyle(
                      fontFamily: 'muli'
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                  style: TextStyle(
                      fontFamily: 'muli'
                  ),
                ),

                noItemsFoundBuilder: (context) => SizedBox.shrink(),


                suggestionsCallback: (pattern) async {
                  return await placeAutocomplete(pattern);
                },

                itemBuilder: (context, suggestion) {
                  return item_autocomplete(location: suggestion, width: MediaQuery.of(context).size.width - 30,
                    onTap: () async {
                      widget.location.mainText = suggestion.structuredFormatting!.mainText!;
                      widget.location.secondaryText = suggestion.structuredFormatting!.secondaryText!;
                      locationText.text = suggestion.structuredFormatting!.mainText!;
                      double? la = await getLati(suggestion.placeId.toString());
                      double? long = await getLongti(suggestion.placeId.toString());
                      widget.location.longitude = long!;
                      widget.location.latitude = la!;
                      widget.location.placeId = suggestion.placeId.toString();
                      widget.event();
                      Navigator.of(context).pop();
                    }, loading: false,
                  );
                },
                onSuggestionSelected: (AutocompletePrediction suggestion) async {},
              )
          ),
        ),
      ),
    );
  }
}
