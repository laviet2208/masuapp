import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/T%C3%ADnh%20kho%E1%BA%A3ng%20c%C3%A1ch.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/NormalUser/accountLocation.dart';
import '../../../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../../../GENERAL/Order/Cost.dart';
import '../../../../../GENERAL/Order/foodOrder.dart';
import '../../../../../GENERAL/Product/Voucher.dart';
import '../../../../../GENERAL/Tool/Time.dart';
import '../../../../../GENERAL/Tool/Tool.dart';
import '../../../../../GENERAL/utils/utils.dart';
import '../../../../../OTHER/Button/Buttontype1.dart';
import '../../Page ví tiền/historyTransaction.dart';
import '../../SCREEN_MAIN/SCREENmain.dart';

class Chitietdondoan extends StatefulWidget {
  final String id;
  final accountLocation diemdon;
  final accountLocation diemtra;
  const Chitietdondoan({Key? key, required this.id, required this.diemdon, required this.diemtra}) : super(key: key);

  @override
  State<Chitietdondoan> createState() => _ChitietdondoanState();
}

class _ChitietdondoanState extends State<Chitietdondoan> {
  late GoogleMapController mapController;
  final vouchercontroller = TextEditingController();
  double _originLatitude = 0, _originLongitude = 0;
  double _destLatitude = 0, _destLongitude = 0;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA";
  bool Loading1 = false;
  double total = 0;
  foodOrder thiscatch = foodOrder(id: '', locationSet: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"), locationGet: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"), cost: -1, owner: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0), shipper: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0), status: 'o',shipcost: -1, voucher: Voucher(id: 'NA', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0), costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0), costBiker: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0), productList: [],
    S1time: getCurrentTime(), S2time: getCurrentTime(),S3time: getCurrentTime(), S4time: getCurrentTime(),S5time: getCurrentTime(),);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
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

  double getVoucherSale(Voucher voucher) {
    double money = 0;

    if(voucher.totalmoney < 100) {
      double mn = (thiscatch.shipcost + thiscatch.cost)/(1-(voucher.totalmoney/100))*(voucher.totalmoney/100);
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

  void getData(String id) {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order/foodOrder/' + widget.id).onValue.listen((event) {
      final dynamic catchorder = event.snapshot.value;
      foodOrder thisO = foodOrder.fromJson(catchorder);
      thiscatch.SetDataByAnother(thisO);
      setState(() {
        widget.diemdon.Latitude = CaculateDistance.parseDoubleString(thiscatch.productList[0].owner.location)[0];
        widget.diemdon.Longitude = CaculateDistance.parseDoubleString(thiscatch.productList[0].owner.location)[1];
        _originLatitude = CaculateDistance.parseDoubleString(thisO.productList[0].owner.location)[0];
        _originLongitude = CaculateDistance.parseDoubleString(thisO.productList[0].owner.location)[1];
        _destLatitude = thisO.locationGet.Latitude;
        _destLongitude = thisO.locationGet.Longitude;
        _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);

        _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
        _getPolyline();
      });

      setState(() {

      });
    });
  }

  Future<void> changeMoney(double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + thiscatch.shipper.id + '/totalMoney').set(money);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> changeShipper(accountNormal ship) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/foodOrder/' + thiscatch.id + '/shipper').set(ship.toJson());
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

  Future<void> changeStatus(String sta, String time) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/foodOrder/' + thiscatch.id + '/status').set(sta);
      databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/foodOrder/' + thiscatch.id + '/' + time).set(getCurrentTime().toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(currentAccount.id);
    _originLatitude = widget.diemdon.Latitude;
    _originLongitude = widget.diemdon.Longitude;
    _destLatitude = widget.diemtra.Latitude;
    _destLongitude = widget.diemtra.Longitude;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    ///Phần button
    //nút hủy đơn
    Color cancelbtnColor = Colors.white;
    Color acceptbtnColor = Color.fromARGB(255, 0, 177, 79);
    String cancelText = 'Hủy đơn';
    String acceptText = 'Nhận đơn';

    ///phần trạng thái
    String status = '';
    if (thiscatch.status == "B") {
      status = "Đang đợi tài xế nhận đơn";
      acceptText = 'Nhận đơn';
    }
    if (thiscatch.status == "C") {
      status = "Hãy tới nhà hàng lấy đồ ăn";
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Đã lấy món';
    }

    if (thiscatch.status == "D") {
      status = "Đang ship tới cho khách";
      cancelbtnColor = Colors.redAccent;
      cancelText = 'Khách không nhận';
      acceptText = 'Hoàn thành';
    }

    if (thiscatch.status == "D1") {
      status = "Đã hoàn thành";
      acceptText = 'Hoàn thành';
    }

    if (thiscatch.status == "H") {
      status = "Đã bị người dùng hủy";
      acceptText = 'Hoàn thành';
    }

    if (thiscatch.status == "J") {
      status = "Người nhận không nhận";
      acceptText = 'Hoàn thành';
    }

    if (thiscatch.status == "I") {
      status = 'Bị hủy bởi bạn';
      acceptText = 'Hoàn thành';
    }

    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
                              'Nhà hàng',
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
                              'Điểm giao',
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
                                    'Địa chỉ nhà hàng',
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
                              thiscatch.productList[0].owner.name,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                        Container(height: 5,),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.diemdon.Latitude.toString() + ',' + widget.diemdon.Longitude.toString(),
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal
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
                                    'Địa chỉ người nhận',
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
                                    'Trạng thái đơn hàng',
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
                              status,
                              textAlign: TextAlign.start,
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
                                      getStringNumber(thiscatch.shipcost + thiscatch.cost - getVoucherSale(thiscatch.voucher)) + 'đ',
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
                              height: 16,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Ship đưa nhà hàng',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(thiscatch.cost * (1-(thiscatch.costFee.discount/100))) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
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
                                      'Chi phí vận chuyển',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(thiscatch.shipcost) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
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
                                      'Mã khuyến mãi',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
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
                                          color: Colors.redAccent,
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
                              height: 16,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Giá trị món ăn',
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
                                      getStringNumber(thiscatch.cost) + 'đ',
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
                                      getStringNumber((thiscatch.shipcost) * (thiscatch.costBiker.discount/100)) + 'đ',
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
                                      getStringNumber(thiscatch.shipcost - ((thiscatch.shipcost) * (thiscatch.costBiker.discount/100))) + 'đ',
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
                    child: ButtonType1(Height: (thiscatch.status == 'B' ||thiscatch.status == 'C' || thiscatch.status == 'D') ? 40 : 0, Width: 1000, color: Colors.orange, radiusBorder: 15, title: acceptText, fontText: 'arial', colorText: Colors.white,
                        onTap: () async {
                          if (thiscatch.status == 'C') {
                            await changeStatus('D','S3time');
                          } else if (thiscatch.status == 'D') {
                            if (thiscatch.voucher.id != '') {
                              historyTransaction his = historyTransaction(id: generateID(10), senderId: '', receiverId: currentAccount.id, transactionTime: getCurrentTime(), type: 7, content: thiscatch.id, money: getVoucherSale(thiscatch.voucher), area: thiscatch.owner.Area);
                              await changeMoney(currentAccount.totalMoney + getVoucherSale(thiscatch.voucher));
                              await pushData(his);
                            }
                            await changeStatus('D1','S4time');
                          } else if (thiscatch.status == 'B') {
                            if (((thiscatch.cost * (thiscatch.costFee.discount/100)) + ((thiscatch.shipcost) * (thiscatch.costBiker.discount/100))) <= currentAccount.totalMoney) {
                              if (thiscatch.status == 'B') {
                                toastMessage('đang nhận đơn');
                                historyTransaction his1 = historyTransaction(id: generateID(10), senderId: '', receiverId: currentAccount.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn ' + thiscatch.id, money: ((thiscatch.cost * (thiscatch.costFee.discount/100)) + ((thiscatch.shipcost+getVoucherSale(thiscatch.voucher)) * (thiscatch.costBiker.discount/100))), area: currentAccount.Area);
                                await changeShipper(currentAccount);
                                await changeMoney(currentAccount.totalMoney - (thiscatch.cost * (thiscatch.costFee.discount/100)) - ((thiscatch.shipcost) * (thiscatch.costBiker.discount/100)));
                                await changeStatus('C','S2time');
                                toastMessage('đã nhận đơn');
                                await pushData(his1);
                              }
                            } else {
                              toastMessage('ví bạn không đủ tiền để nhận đơn này');
                            }
                          }
                        }),
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 0,
                    child: ButtonType1(Height: (thiscatch.status == 'C' || thiscatch.status == 'D') ? 35 : 0, Width: 1000, color: cancelbtnColor, radiusBorder: 15, title: cancelText, fontText: 'arial', colorText: Colors.white,
                        onTap: () async {
                          if (thiscatch.status == 'C') {
                            toastMessage('đang hủy đơn');
                            await changeStatus('I','S5time');
                            toastMessage('đã hủy đơn');
                          } else if (thiscatch.status == 'D') {
                            await changeStatus('J','S5time');
                          }
                        }),
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
      },
    );
  }
}
