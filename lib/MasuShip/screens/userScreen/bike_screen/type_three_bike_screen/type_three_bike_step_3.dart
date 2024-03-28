import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_step_1.dart';
import '../../../../Data/OrderData/catchOrder.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../general/voucher_select.dart';

class type_three_bike_step_3 extends StatefulWidget {
  final Location startLocation;
  final List<Location> customerLocations;
  final List<Location> bikeLocations;
  const type_three_bike_step_3({super.key, required this.customerLocations, required this.bikeLocations, required this.startLocation});

  @override
  State<type_three_bike_step_3> createState() => _type_three_bike_step_3State();
}

class _type_three_bike_step_3State extends State<type_three_bike_step_3> {

  Future<double> getDistance(Location end) async {
    double startLatitude = widget.startLocation.latitude;
    double startLongitude = widget.startLocation.longitude;
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

  Future<double> getCost(Location endLocation) async {
    double cost = 0;
    double distance = await getDistance(endLocation);
    if (distance >= finalData.bikeCost.departKM) {
      cost += finalData.bikeCost.departKM.toInt() * finalData.bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= finalData.bikeCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - finalData.bikeCost.departKM) * finalData.bikeCost.perKMcost);
    } else {
      cost += (distance * finalData.bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
    }
    //order.cost = cost;
    return cost;
  }

  Future<double> get_total() async {
    double cost = 0;
    for (Location location in widget.customerLocations) {
      cost = cost + await getCost(location);
    }
    for (Location location in widget.bikeLocations) {
      cost = cost + await getCost(location);
    }
    //order.cost = cost;
    return cost;
  }

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
      costFee: finalData.bikeCost
  );
  
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
              Container(height: 10,),

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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_three_bike_step_1()));
                      },
                    ),
                  ],
                ),
              ),

              Container(width: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 86 * widget.customerLocations.length + 40,
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
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 25),
                            shrinkWrap: true,
                            itemCount: widget.customerLocations.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            child: FutureBuilder(
                                              future: getDistance(widget.customerLocations[index]),
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
                                                  height: 60,
                                                  width: (width - 40 - 20)/2,
                                                  child: Text(
                                                    'Chi phí đưa khách về ' + widget.customerLocations[index].mainText + ' (' + snapshot.data!.toStringAsFixed(1) + ' Km)',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontSize: 12,
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
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            alignment: Alignment.centerRight,
                                            child: FutureBuilder(
                                              future: getCost(widget.customerLocations[index]),
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
                                                  height: 60,
                                                  width: (width - 40 - 20)/2,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    getStringNumber(double.parse(snapshot.data.toString())) + '.đ',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontSize: 13,
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

                                  Padding(
                                    padding: EdgeInsets.only(left: 50, right: 50),
                                    child: Container(
                                      height: index == widget.customerLocations.length - 1 ? 0 : 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  Container(height: 5,)
                                ],
                              );
                            },
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
                                      'Hóa đơn chở khách',
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
                child: Container(
                  height: 86 * widget.bikeLocations.length + 40,
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
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 25),
                            shrinkWrap: true,
                            itemCount: widget.bikeLocations.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            child: FutureBuilder(
                                              future: getDistance(widget.bikeLocations[index]),
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
                                                  height: 60,
                                                  width: (width - 40 - 20)/2,
                                                  child: Text(
                                                    'Chi phí lái xe về ' + widget.bikeLocations[index].mainText + ' (' + snapshot.data!.toStringAsFixed(1) + ' Km)',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontSize: 12,
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
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            alignment: Alignment.centerRight,
                                            child: FutureBuilder(
                                              future: getCost(widget.bikeLocations[index]),
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
                                                  height: 60,
                                                  width: (width - 40 - 20)/2,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    getStringNumber(double.parse(snapshot.data.toString())) + '.đ',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontSize: 13,
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

                                  Padding(
                                    padding: EdgeInsets.only(left: 50, right: 50),
                                    child: Container(
                                      height: index == widget.bikeLocations.length - 1 ? 0 : 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  Container(height: 5,)
                                ],
                              );
                            },
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
                                      'Hóa đơn lái xe hộ',
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
                child: Container(
                  height: 250,
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
                                        child: Container(
                                          height: 30,
                                          width: (width - 40 - 20)/2,
                                          child: AutoSizeText(
                                            'Tổng hóa đơn',
                                            style: TextStyle(
                                                fontFamily: 'muli',
                                                color: Colors.black,
                                                fontSize: 200,
                                                fontWeight: FontWeight.bold
                                            ),
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
                                        child: FutureBuilder(
                                          future: get_total(),
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
                                                text: "0.đ",
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
                                          future: get_total(),
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
                                    Icons.money,
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
                                      'Tổng hóa đơn của tôi',
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
                      child: Text(
                        'Xác nhận đặt xe',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {

                  },
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
