import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/NormalUser/accountLocation.dart';
import '../../../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../../../GENERAL/Order/Cost.dart';
import '../../../../../GENERAL/Order/catchOrder.dart';
import '../../../../../GENERAL/Product/Voucher.dart';
import '../../../../../GENERAL/Tool/Time.dart';
import '../../../../../GENERAL/Tool/Tool.dart';
import '../../../../../GENERAL/utils/utils.dart';
import '../../../../../OTHER/Button/Buttontype1.dart';
import '../../Page ví tiền/historyTransaction.dart';

class Chitietdongoixe extends StatefulWidget {
  final accountLocation diemdon;
  final accountLocation diemtra;
  final String id;
  const Chitietdongoixe({Key? key, required this.diemdon, required this.diemtra, required this.id}) : super(key: key);

  @override
  State<Chitietdongoixe> createState() => _ChitietdongoixeState();
}

class _ChitietdongoixeState extends State<Chitietdongoixe> {
  late GoogleMapController mapController;
  double _originLatitude = 0, _originLongitude = 0;
  double _destLatitude = 0, _destLongitude = 0;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA";
  catchOrder thiscatch = catchOrder(
      id: '',
      locationSet: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"),
      locationGet: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"),
      cost: -1,
      owner: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0),
      shipper: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0),
      status: 'o',
      S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      type: 1,
      voucher: Voucher(id: 'NA', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0),
      costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0)
  );

  String startTime = "";
  String locationset = "";
  String locationget = "";
  String Tmoney = "";
  String status = "";

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Future<void> pushData(historyTransaction his) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(his.id).set(his.toJson());
      toastMessage('Đã chiết khấu');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }


  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  int getCost(double distance) {
    int cost = 0;
    if (distance >= 2.0) {
      cost += 20000; // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= 2.0; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - 2) * 5000).toInt();
    } else {
      cost += (distance * 10000).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  void getData(String id) {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order/catchOrder/' + widget.id).onValue.listen((event) {
      final dynamic catchorder = event.snapshot.value;
      catchOrder thisO = catchOrder.fromJson(catchorder);
      thiscatch.ChangeDataByAnother(thisO);

      setState(() {
        _originLatitude = thisO.locationSet.Latitude;
        _originLongitude = thisO.locationSet.Longitude;
        _destLatitude = thisO.locationGet.Latitude;
        _destLongitude = thisO.locationGet.Longitude;
        _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);

        _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
        _getPolyline();
        startTime = getAllTimeString(thisO.S1time);

        if (thisO.locationSet.firstText == "NA") {
          locationset = thisO.locationSet.Longitude.toString() + " , " + thisO.locationSet.Latitude.toString();
        } else {
          locationset = compactString(30, thisO.locationSet.firstText);
        }

        if (thisO.locationGet.firstText == "NA") {
          locationget = thisO.locationGet.Longitude.toString() + " , " + thisO.locationGet.Latitude.toString();
        } else {
          locationget = compactString(30, thisO.locationGet.firstText);
        }

        Tmoney = getStringNumber(thisO.cost) + "đ";

        if (thisO.status == 'A') {
          status = 'đang đợi tài xế nhận đơn';
        }
        if (thisO.status == 'B') {
          status = getAllTimeString(thisO.S2time) + ' .Tài xế ' + thisO.shipper.name + " - " + thisO.shipper.phoneNum + ' đang đến , bạn có thể hủy đơn nhưng nghĩ kỹ nhé!';
        }
        if (thisO.status == 'C') {
          status = 'Đã đón bạn , hành trình bắt đầu! đơn được nhận lúc' + getAllTimeString(thisO.S2time);
        }
      });
    });
  }

  Future<void> updateData(String status) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + thiscatch.id + "/status").set(status);
      databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + thiscatch.id + "/S4time").set(getCurrentTime().toJson());
      toastMessage('đã hủy đơn');
      Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> changeStatus(String sta, String time) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + widget.id + '/status').set(sta);
      databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + thiscatch.id + '/' + time).set(getCurrentTime().toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> changeShipper(accountNormal ship) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + thiscatch.id + '/shipper').set(ship.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> changeMoney(double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + '/totalMoney').set(money);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void openMaps(double destinationLatitude, double destinationLongitude) async {
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$destinationLatitude,$destinationLongitude';
    String appleMapsUrl = 'https://maps.apple.com/?q=$destinationLatitude,$destinationLongitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not launch Maps';
    }
  }

  double getVoucherSale(Voucher voucher) {
    double money = 0;

    if(voucher.totalmoney < 100) {
      double mn = thiscatch.cost/(1-(voucher.totalmoney/100))*(voucher.totalmoney/100);
      if (mn <= voucher.maxSale) {
        money = mn;
      } else {
        money = voucher.maxSale;
      }
    } else {
      money = voucher.totalmoney;
    }

    return money;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _originLatitude = widget.diemdon.Latitude;
    _originLongitude = widget.diemdon.Longitude;
    _destLatitude = widget.diemtra.Latitude;
    _destLongitude = widget.diemtra.Longitude;
    getData(currentAccount.id);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    ///Phần button
    //nút hủy đơn
    Color cancelbtnColor = Colors.white;
    String acceptText = 'Nhận đơn';

    ///phần trạng thái
    String status = '';
    if (thiscatch.status == "B") {
      status = "Đang tới đón khách";
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Đã đón khách';
    }

    if (thiscatch.status == "C") {
      status = "Hành trình bắt đầu";
      acceptText = 'Hoàn thành';
    }

    if (thiscatch.status == "D") {
      status = "Hoàn thành";
      acceptText = 'Đã hoàn thành';
    }

    if (thiscatch.status == "E" ||thiscatch.status == "F") {
      status = 'Bị hủy bởi khách hàng';
      cancelbtnColor = Colors.white;
      acceptText = 'đã bị hủy';
    }

    if (thiscatch.status == "G") {
      status = 'Bị hủy bởi bạn';
      cancelbtnColor = Colors.white;
      acceptText = 'đã bị hủy';
    }


    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245)
            ),
            child: ListView(
              children: [
                Container(
                  width: screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // màu của shadow
                          spreadRadius: 5, // bán kính của shadow
                          blurRadius: 7, // độ mờ của shadow
                          offset: Offset(0, 3), // vị trí của shadow
                        ),
                      ],
                      color: Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image/backicon1.png')
                                )
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                          bottom: 14,
                          left: 60,
                          child: Text(
                            widget.id,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: 'arial',
                                color: Colors.black
                            ),
                          )
                      ),
                    ],
                  ),
                ),

                Container(
                  height: screenHeight/2.5,
                  width: screenWidth,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: screenHeight/2.5,
                          width: screenWidth,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(_originLatitude, _originLongitude), zoom: 10),
                            myLocationEnabled: false,
                            tiltGesturesEnabled: true,
                            compassEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: false,
                            onMapCreated: _onMapCreated,
                            markers: Set<Marker>.of(markers.values),
                            polylines: Set<Polyline>.of(polylines.values),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: GestureDetector(
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Điểm đón',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'roboto'
                              ),
                            ),
                          ),
                          onTap: () {
                            openMaps(widget.diemdon.Latitude, widget.diemdon.Longitude);
                          },
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 120,
                        child: GestureDetector(
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Điểm trả',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'roboto'
                              ),
                            ),
                          ),
                          onTap: () {
                            openMaps(widget.diemtra.Latitude, widget.diemtra.Longitude);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 10,),

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
                                        image: AssetImage('assets/image/ghichu.png')
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
                                  width: screenWidth - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Đơn ' + widget.id,
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Color.fromARGB(255, 255, 123, 64),
                                        fontSize: 200,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 10,
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

                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/image/clock.png')
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
                                  width: screenWidth - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Đặt lúc : ' + getAllTimeString(thiscatch.S1time),
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.black,
                                        fontSize: 200,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 10,
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

                              Icon(
                                Icons.motorcycle_sharp,
                                color: Color.fromARGB(255, 255, 123, 64),
                                size: 30,
                              ),

                              Container(
                                width: 10,
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 7, bottom: 7),
                                child: Container(
                                  height: 30,
                                  width: screenWidth - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    thiscatch.type == 1 ? 'Xe ôm' : 'Taxi Masu',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Color.fromARGB(255, 255, 123, 64),
                                        fontSize: 200,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
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
                                color: Colors.grey
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
                                padding: EdgeInsets.only(top: 7, bottom: 7),
                                child: Container(
                                  height: 30,
                                  width: (screenWidth - 40 - 20)/2,
                                  child: AutoSizeText(
                                    'TỔNG CỘNG',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.grey,
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
                                  width: (screenWidth - 40 - 20)/2,
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    getStringNumber(thiscatch.cost + getVoucherSale(thiscatch.voucher)) + 'đ',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.black,
                                        fontSize: 200,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
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
                                padding: EdgeInsets.only(top: 7, bottom: 7),
                                child: Container(
                                  height: 30,
                                  width: (screenWidth - 40 - 20)/2,
                                  child: AutoSizeText(
                                    'Chi phí vận chuyển',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.grey,
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
                                  width: (screenWidth - 40 - 20)/2,
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: getStringNumber(thiscatch.cost + getVoucherSale(thiscatch.voucher)) + "đ",
                                          style: TextStyle(
                                            fontFamily: 'arial',
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
                      ],
                    ),
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 10,),

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
                                  width: screenWidth - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Điểm đón',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.black,
                                        fontSize: 200,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 10,
                              ),


                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              thiscatch.owner.phoneNum[0] == '0' ? thiscatch.owner.phoneNum : '0' + thiscatch.owner.phoneNum,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ),

                        Container(height: 5,),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            child: Text(
                              thiscatch.locationSet.firstText + ',' + thiscatch.locationSet.secondaryText,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                        Container(height: 15,),

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
                                        image: AssetImage('assets/image/redlocation.png')
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
                                  width: screenWidth - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Điểm đến',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.black,
                                        fontSize: 200,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 10,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            child: Text(
                              thiscatch.locationGet.firstText + ',' + thiscatch.locationGet.secondaryText,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                        Container(height: 20,),
                      ],
                    ),
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 10,),

                        Container(
                          height: 30,
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                              ),

                              Icon(
                                Icons.wallet,
                                size: 30,
                                color: Colors.orange,
                              ),

                              Container(
                                width: 10,
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 7, bottom: 7),
                                child: Container(
                                  height: 30,
                                  width: screenWidth - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Thông tin thu nhập',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        color: Colors.black,
                                        fontSize: 200,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 10,
                              ),


                            ],
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 15,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Chi phí vận chuyển',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(thiscatch.cost + getVoucherSale(thiscatch.voucher)) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 16,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Tổng thu của khách',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(thiscatch.cost) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 15,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Chiết khấu',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber((thiscatch.cost+getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 15,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Mã khuyễn mãi',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(getVoucherSale(thiscatch.voucher)) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 15,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Tài xế thực nhận',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(thiscatch.cost + getVoucherSale(thiscatch.voucher) - ((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100))) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),
                      ],
                    ),
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: (thiscatch.status == 'A' || thiscatch.status == 'B' || thiscatch.status == 'C') ? 40 : 0,
                      child: ButtonType1(Height: (thiscatch.status == 'A' || thiscatch.status == 'B' || thiscatch.status == 'C') ? 40 : 0, Width: 3000, color: Colors.orange, radiusBorder: 5, title: acceptText, fontText: 'arial', colorText: Colors.white,
                          onTap: () async {
                            if (thiscatch.status == 'A') {
                              if (((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)) <= currentAccount.totalMoney) {
                                toastMessage('đang nhận đơn');
                                historyTransaction his1 = historyTransaction(id: generateID(10), senderId: '', receiverId: currentAccount.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn ' + thiscatch.id, money: ((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)), area: currentAccount.Area);
                                await changeShipper(currentAccount);
                                await changeStatus('B','S2time');
                                await changeMoney(currentAccount.totalMoney - ((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)));
                                await pushData(his1);
                                toastMessage('đã nhận đơn');

                              } else {
                                toastMessage('Bạn không đủ tiền để nhận đơn');
                              }
                            } else if (thiscatch.status == 'B') {
                              toastMessage('đã đón khách');
                              await changeStatus('C', 'S3time');
                            } else if (thiscatch.status == 'C') {
                              toastMessage('đã hoàn thành');
                              if (thiscatch.voucher.id != '') {
                                double money = 0;
                                if (thiscatch.voucher.totalmoney <= 100) {
                                  money = (thiscatch.cost/(100-thiscatch.voucher.totalmoney))*thiscatch.voucher.totalmoney;
                                  if (money > thiscatch.voucher.maxSale) {
                                    money = thiscatch.voucher.maxSale;
                                  }
                                } else {
                                  money = thiscatch.voucher.totalmoney;
                                }
                                historyTransaction his = historyTransaction(id: generateID(10), senderId: '', receiverId: currentAccount.id, transactionTime: getCurrentTime(), type: 7, content: thiscatch.id, money: getVoucherSale(thiscatch.voucher), area: thiscatch.owner.Area);
                                await changeMoney(currentAccount.totalMoney + getVoucherSale(thiscatch.voucher));
                                await pushData(his);
                              }
                              await changeStatus('D', 'S4time');
                            } else if (thiscatch.status == 'D') {
                              toastMessage('Đơn đã hoàn thành rồi');
                            }
                          }),
                    ),
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 0,
                      child: ButtonType1(Height: thiscatch.status == 'B' ? 35 : 0, Width: 1000, color: cancelbtnColor, radiusBorder: 5, title: 'Hủy đơn', fontText: 'arial', colorText: Colors.white,
                          onTap: () async {
                            if (thiscatch.status == 'B') {
                              toastMessage('đang hủy đơn');
                              await changeShipper(currentAccount);
                              await changeStatus('G', 'S4time');
                              toastMessage('đã hủy đơn');
                            }
                          }),
                    ),
                  ),
                ),

                Container(height: 20,),


              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },);
  }
}
