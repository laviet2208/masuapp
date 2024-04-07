import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:http/http.dart' as http;
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/food_order_step_1/item_food_view.dart';
import 'dart:convert';
import '../../../../../Data/locationData/Location.dart';
import '../../../general/search_location_dialog.dart';

class food_order_step_1 extends StatefulWidget {
  final Widget beforeWidget;
  const food_order_step_1({super.key, required this.beforeWidget});

  @override
  State<food_order_step_1> createState() => _food_order_step_1State();
}

class _food_order_step_1State extends State<food_order_step_1> {
  bool loading = false;
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
        location.mainText = data['results'][0]['formatted_address'];
        return data['results'][0]['formatted_address'];
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  Future<Location> get_restaurant_location(String id) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    DatabaseEvent dataSnapshot = await reference.child('Restaurant').child(id).child('location').once();
    final dynamic values = dataSnapshot.snapshot.value;
    start_location =  Location.fromJson(values);
    return Location.fromJson(values);
  }

  Future<double> getDistance(Location start, Location end) async {
    start = await get_restaurant_location(finalData.cartList.first.product.owner);
    double startLatitude = start.latitude;
    double startLongitude = start.longitude;
    double endLatitude = end.latitude;
    double endLongitude = end.longitude;
    final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z");


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final distance = data['rows'][0]['elements'][0]['distance']['value'];
        return distance.toDouble()/1000;
      } else {
        throw Exception('Lỗi khi gửi yêu cầu tới Goong API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  Future<double> getCost() async {
    double cost = 0;
    double distance = await getDistance(start_location,end_location);
    if (distance >= finalData.bikeCost.departKM) {
      cost += finalData.bikeCost.departKM.toInt() * finalData.bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= finalData.bikeCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - finalData.bikeCost.departKM) * finalData.bikeCost.perKMcost);
    } else {
      cost += (distance * finalData.bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
    }

    return cost;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    end_location = finalData.user_account.location;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
                      },
                    ),

                  ],
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: height/5,
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
                                          'Điểm nhận đồ ăn',
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
                                              return search_location_dialog(location: end_location, title: 'Chọn điểm nhận hàng', event: () {
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
                                      'Vị trí nhận đồ ăn',
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
                  height: 80 * finalData.cartList.length.toDouble() + 50,
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
                            padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
                            child: Container(
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 20),
                                itemCount: finalData.cartList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: item_food_view(product: finalData.cartList[index],),
                                  );
                                },
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
                                    Icons.fastfood_outlined,
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
                                      'Danh sách món ăn',
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
                  height: 310,
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Giá tiền món ăn',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: getStringNumber(get_total_cart_money()) + '.đ',
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Phụ thu thêm điểm(' + get_number_restaurant(finalData.cartList).toString() + ' điểm)',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: getStringNumber((get_number_restaurant(finalData.cartList) - 1).toDouble() * 5000) + '.đ',
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Phụ thu thời tiết',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: getStringNumber(0) + '.đ',
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: FutureBuilder(
                                          future: getDistance(start_location, end_location),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Text('Chi phí di chuyển(...km)', style: TextStyle(color: Colors.black, fontSize: 15),);
                                            }

                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return Text('Lỗi vị trí, vui lòng thử lại', style: TextStyle(color: Colors.black, fontSize: 15),);
                                            }

                                            if (!snapshot.hasData) {
                                              return Text('Lỗi vị trí, vui lòng thử lại', style: TextStyle(color: Colors.black, fontSize: 15),);
                                            }

                                            return Container(
                                              height: 30,
                                              width: (width - 40 - 20)/2,
                                              child: AutoSizeText(
                                                'Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + ' Km)',
                                                style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 200,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: getCost(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Đang tính toán giá tiền",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            return Container(
                                              height: 30,
                                              width: (width - 40 - 20)/2,
                                              child: AutoSizeText(
                                                getStringNumber(double.parse(snapshot.data.toString())) + '.đ',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 200,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),



                              Container(height: 10,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Tổng thanh toán',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: getCost(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Đang tính toán giá tiền",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            return AutoSizeText(
                                              getStringNumber(double.parse(snapshot.data.toString()) + get_total_cart_money() + ((get_number_restaurant(finalData.cartList) - 1).toDouble() * 5000)) + '.đ',
                                              style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontSize: 200,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),
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
                                      'Thông tin thanh toán',
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
