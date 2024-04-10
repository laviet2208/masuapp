import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_step_1.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/voucher_select.dart';

import '../../../../Data/otherData/Time.dart';
import '../../main_screen/user_main_screen.dart';

class type_one_bike_step_2 extends StatefulWidget {
  final Location start_location;
  final Location end_location;
  const type_one_bike_step_2({super.key, required this.start_location, required this.end_location});

  @override
  State<type_one_bike_step_2> createState() => _type_one_bike_step_2State();
}

class _type_one_bike_step_2State extends State<type_one_bike_step_2> {
  bool loading = false;
  double mainCost = 0;

  CatchOrder order = CatchOrder(
    id: generateID(25),
    locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    cost: 0,
    owner: finalData.user_account,
    shipper: finalData.shipper_account,
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    costFee: finalData.bikeCost,
    subFee: 0,
  );

  Future<double> getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
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
    double distance = await getDistance(widget.start_location.latitude, widget.start_location.longitude, widget.end_location.latitude, widget.end_location.longitude);
    if (distance >= finalData.bikeCost.departKM) {
      cost += finalData.bikeCost.departKM.toInt() * finalData.bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= finalData.bikeCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - finalData.bikeCost.departKM) * finalData.bikeCost.perKMcost);
    } else {
      cost += (distance * finalData.bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
    }
    order.cost = cost;
    return cost;
  }

  Future<void> push_new_catch_type_one_order(CatchOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  Container get_location_text(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    order.locationSet = widget.start_location;
    order.locationGet = widget.end_location;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button_in_wait(),

              Container(height: 10,),

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

                              location_title(type: 'start'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: get_location_text(widget.start_location.mainText),
                              ),

                              Container(
                                width: 30,
                              ),

                              location_title(type: 'end'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: get_location_text(widget.end_location.mainText + ' ' + widget.end_location.secondaryText),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.location_on_outlined, title: 'Thông tin điểm đón, trả'),
                      ),
                    ],
                  ),
                ),
              ),

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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: FutureBuilder(
                                          future: getDistance(widget.start_location.latitude, widget.start_location.longitude, widget.end_location.latitude, widget.end_location.longitude),
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
                                          'Phụ thu',
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
                                                text: getStringNumber(order.subFee) + ".đ",
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
                                          'Mã giảm giá',
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
                                      child: GestureDetector(
                                        child: Container(
                                          height: 30,
                                          width: (width - 40 - 20)/2,
                                          alignment: Alignment.centerRight,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: order.voucher.id == '' ? "Chọn mã giảm giá" : ('- ' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'),
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: order.voucher.id == '' ? 12 : 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return voucher_select(voucher: order.voucher, ontap: () {
                                                setState(() {

                                                });
                                              }, cost: order.cost);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

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
                                              getStringNumber(double.parse(snapshot.data.toString()) - getVoucherSale(order.voucher, order.cost)) + '.đ',
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

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  child: Container(
                    height: 50,
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
                      child: !loading ? Text(
                        'Xác nhận đặt xe',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ) : CircularProgressIndicator(color: Colors.white,),
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    order.S1time = getCurrentTime();
                    await push_new_catch_type_one_order(order);
                    setState(() {
                      loading = false;
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_one_bike_wait(orderId: order.id)));
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return true;
      },
    );
  }
}
