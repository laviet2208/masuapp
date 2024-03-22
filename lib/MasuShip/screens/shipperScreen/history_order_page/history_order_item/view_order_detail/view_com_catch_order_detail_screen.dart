import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/shipper_main_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../Data/costData/Cost.dart';
import '../../../../../Data/locationData/Location.dart';
import '../../../../../Data/otherData/Tool.dart';
import '../../../../../Data/voucherData/Voucher.dart';

class view_com_catch_order_detail_screen extends StatefulWidget {
  final String id;
  const view_com_catch_order_detail_screen({Key? key, required this.id}) : super(key: key);

  @override
  State<view_com_catch_order_detail_screen> createState() => _view_com_catch_order_detail_screenState();
}

class _view_com_catch_order_detail_screenState extends State<view_com_catch_order_detail_screen> {
  bool loading = false;

  late GoogleMapController mapController;
  double _originLatitude = 0, _originLongitude = 0;
  double _destLatitude = 0, _destLongitude = 0;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA";

  String startTime = "";
  String locationset = "";
  String locationget = "";
  String Tmoney = "";
  String status = "";
  String status_text_button = "";

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  CatchOrder order = CatchOrder(id: '', locationSet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0), S1time: getCurrentTime(), S2time: getCurrentTime(), S3time: getCurrentTime(), S4time: getCurrentTime(), costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0));

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order').child(widget.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      order = CatchOrder.fromJson(data);

      setState(() {
        _originLatitude = order.locationSet.latitude;
        _originLongitude = order.locationSet.longitude;
        _destLatitude = order.locationGet.latitude;
        _destLongitude = order.locationGet.longitude;
        _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);

        _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));

        startTime = getAllTimeString(order.S1time);

        Tmoney = getStringNumber(order.cost) + "đ";

        if (order.status == 'B') {
          status_text_button = 'Đã đón khách';
          status = 'Bạn hãy mau chóng tới đón khách';
        }
        if (order.status == 'C') {
          status_text_button = 'Đã hoàn thành';
          status = 'Hãy đưa khách đến điểm yêu cầu';
        }
      });
    });
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

  _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể gọi số điện thoại $phoneNumber';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                width: width,
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
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
                  height: height/2.5,
                  width: width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: height/2.5,
                          width: width,
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
                            openMaps(order.locationSet.latitude, order.locationSet.longitude);
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
                            openMaps(order.locationGet.latitude, order.locationGet.longitude);
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
                                  width: width - 40 - 30 - 30,
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
                                  width: width - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Đặt lúc : ' + getAllTimeString(order.S1time),
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
                                  width: width - 40 - 30 - 30,
                                  child: AutoSizeText(
                                    'Xe ôm Masu',
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
                                  width: (width - 40 - 20)/2,
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
                                  width: (width - 40 - 20)/2,
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + 'đ',
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
                                  width: (width - 40 - 20)/2,
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
                                  width: (width - 40 - 20)/2,
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + "đ",
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
                                  width: width - 40 - 30 - 30,
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
                              order.owner.phone[0] == '0' ? order.owner.phone : '0' + order.owner.phone,
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
                              order.locationSet.mainText + ',' + order.locationSet.secondaryText,
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
                                  width: width - 40 - 30 - 30,
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
                              order.locationGet.mainText + ',' + order.locationGet.secondaryText,
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
                                  width: width - 40 - 30 - 30,
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
                                      getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost)) + 'đ',
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
                                      getStringNumber(order.cost) + 'đ',
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
                                      getStringNumber((order.cost+getVoucherSale(order.voucher, order.cost)) * (order.costFee.discount/100)) + 'đ',
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
                                      getStringNumber(getVoucherSale(order.voucher, order.cost)) + 'đ',
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
                                      getStringNumber(order.cost + getVoucherSale(order.voucher, order.cost) - ((order.cost + getVoucherSale(order.voucher, order.cost)) * (order.costFee.discount/100))) + 'đ',
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
