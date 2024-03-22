import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/historyTransaction.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/NormalUser/accountLocation.dart';
import '../../../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../../../GENERAL/Order/Cost.dart';
import '../../../../../GENERAL/Order/Receiver.dart';
import '../../../../../GENERAL/Order/item_details.dart';
import '../../../../../GENERAL/Order/itemsendOrder.dart';
import '../../../../../GENERAL/Product/Voucher.dart';
import '../../../../../GENERAL/Tool/Time.dart';
import '../../../../../GENERAL/Tool/Tool.dart';
import '../../../../../GENERAL/utils/utils.dart';
import '../../../../../OTHER/Button/Buttontype1.dart';

class Pagechitietdongiaohang extends StatefulWidget {
  final String id;
  final accountLocation diemdon;
  final accountLocation diemtra;
  final int type;
  const Pagechitietdongiaohang({Key? key, required this.id, required this.diemdon, required this.diemtra, required this.type}) : super(key: key);

  @override
  State<Pagechitietdongiaohang> createState() => _PagechitietdongiaohangState();
}

class _PagechitietdongiaohangState extends State<Pagechitietdongiaohang> {
  late GoogleMapController mapController;
  double _originLatitude = 0, _originLongitude = 0;
  double _destLatitude = 0, _destLongitude = 0;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA";

  itemsendOrder thiscatch = itemsendOrder(
    id: '',
    cost: -1,
    owner: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0),
    shipper: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0), status: '',
    locationset: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"), receiver: Receiver(location: accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA"), locationNote: '', name: '', phoneNum: '', note: ''),
    itemdetails: item_details(weight: 0, type: '', codFee: 0),
    voucher: Voucher(id: 'NA', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0),
    costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0),S1time: getCurrentTime(), S2time: getCurrentTime(),S3time: getCurrentTime(), S4time: getCurrentTime(),);

  void getData(String id) {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order/itemsendOrder/' + widget.id).onValue.listen((event) {
      final dynamic catchorder = event.snapshot.value;
      itemsendOrder thisO = itemsendOrder.fromJson(catchorder);
      thiscatch.setDataFromJson(catchorder);
      setState(() {
        _originLatitude = thisO.locationset.Latitude;
        _originLongitude = thisO.locationset.Longitude;
        _destLatitude = thisO.receiver.location.Latitude;
        _destLongitude = thisO.receiver.location.Longitude;
        _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);

        _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
        _getPolyline();
      });

      setState(() {

      });
    });
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

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
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

    Future<void> changeStatus(String sta) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/itemsendOrder/' + thiscatch.id + '/status').set(sta);
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeTime(String data) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/itemsendOrder/' + thiscatch.id + '/' + data).set(getCurrentTime().toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeShipper(accountNormal ship) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order/itemsendOrder/' + thiscatch.id + '/shipper').set(ship.toJson());
      } catch (error) {
        print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    ///Phần button
    //nút hủy đơn
    Color cancelbtnColor = Colors.white;
    Color statusColor = Color.fromARGB(255, 0, 177, 79);
    String canceltext = 'Hủy đơn';
    Color acceptbtnColor = Colors.orange;
    String acceptText = 'Nhận đơn';

    ///phần trạng thái
    String status = '';
    if (thiscatch.status == "A") {
      status = "Đợi tài xế nhận đơn";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Nhận đơn';
    }

    if (thiscatch.status == "B") {
      status = "Di chuyển tới lấy hàng";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      cancelbtnColor = Colors.redAccent;
      acceptText = 'Đã lấy hàng';
    }

    if (thiscatch.status == "C") {
      status = "Đang giao tới người nhận";
      statusColor = Color.fromARGB(255, 0, 177, 79);
      acceptText = 'Hoàn thành';
      cancelbtnColor = Colors.redAccent;
      canceltext = 'Người nhận bom';
    }

    if (thiscatch.status == "D") {
      status = "Hoàn thành";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (thiscatch.status == "F") {
      status = 'Bị hủy bởi người đặt';
      statusColor = Colors.redAccent;
      cancelbtnColor = Colors.white;
      acceptText = 'Đã bị hủy';
      acceptbtnColor = Colors.redAccent;
    }

    if (thiscatch.status == "G") {
      status = 'Bị hủy bởi bạn';
      statusColor = Colors.redAccent;
      acceptText = 'Đã bị hủy';
      acceptbtnColor = Colors.redAccent;
      cancelbtnColor = Colors.white;
    }

    if (thiscatch.status == "H") {
      status = 'Người nhận không lấy';
      statusColor = Colors.redAccent;
      statusColor = Colors.redAccent;
      cancelbtnColor = Colors.white;
      acceptText = 'Đã bị bom';
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
                              'Điểm lấy',
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
                                    'Địa chỉ nhận hàng',
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
                              thiscatch.locationset.firstText + ',' + thiscatch.locationset.secondaryText,
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
                                    'Địa chỉ giao hàng',
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
                              thiscatch.receiver.phoneNum[0] == '0' ? thiscatch.receiver.phoneNum : '0' + thiscatch.receiver.phoneNum,
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
                            alignment: Alignment.centerLeft,
                            child: Text(
                              thiscatch.receiver.location.firstText + ',' + thiscatch.receiver.location.secondaryText,
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
                                Icons.add_box_outlined,
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
                                    'Thông tin hàng hóa',
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
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Khối lượng : ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold, // Để in đậm
                                    ),
                                  ),
                                  TextSpan(
                                    text: thiscatch.itemdetails.weight.toString() + 'kg', // Phần còn lại viết bình thường
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal, // Để viết bình thường
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Loại hàng hóa : ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold, // Để in đậm
                                    ),
                                  ),
                                  TextSpan(
                                    text: thiscatch.itemdetails.type.toString(), // Phần còn lại viết bình thường
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal, // Để viết bình thường
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Phí thu hộ : ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold, // Để in đậm
                                    ),
                                  ),
                                  TextSpan(
                                    text: getStringNumber(thiscatch.itemdetails.codFee) + 'đ', // Phần còn lại viết bình thường
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal, // Để viết bình thường
                                    ),
                                  ),
                                ],
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
                                      getStringNumber(thiscatch.itemdetails.codFee + thiscatch.cost) + 'đ',
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
                                      'Tài xế thực nhận',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber((thiscatch.cost + getVoucherSale(thiscatch.voucher)) - ((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100))) + 'đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.deepOrange,
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
                                          color: Colors.orange,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal
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
                                          color: Colors.orange,
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
                                      getStringNumber((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)) + 'đ',
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
                                      'Mã khuyến mãi',
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
                                      'Thu hộ',
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
                                      getStringNumber(thiscatch.itemdetails.codFee) + 'đ',
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

                Container(
                  height: ((thiscatch.status == 'A' ||thiscatch.status == 'B' || thiscatch.status == 'C') ? 10 : 0),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: ((thiscatch.status == 'A' ||thiscatch.status == 'B' || thiscatch.status == 'C') ? 40 : 0),
                    child: ButtonType1(Height: ((thiscatch.status == 'B' || thiscatch.status == 'C') ? 40 : 0), Width: 100, color: acceptbtnColor, radiusBorder: 5, title: acceptText, fontText: 'arial', colorText: Colors.white,
                        onTap: () async {
                          if (thiscatch.status == 'A') {
                              if (((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)) <= currentAccount.totalMoney) {
                                toastMessage('đang nhận đơn');
                                historyTransaction his = historyTransaction(id: generateID(10), senderId: '', receiverId: currentAccount.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn ' + thiscatch.id, money: ((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)), area: currentAccount.Area);
                                await changeShipper(currentAccount);
                                await changeMoney(currentAccount.totalMoney - ((thiscatch.cost + getVoucherSale(thiscatch.voucher)) * (thiscatch.costFee.discount/100)));
                                await changeStatus('B');
                                await changeTime('S2time');
                                toastMessage('đã nhận đơn');
                                await pushData(his);
                              } else {
                                toastMessage('ví bạn không đủ tiền để nhận đơn này');
                              }
                          } else if (thiscatch.status == 'B') {
                            toastMessage('đang bắt đầu');
                            await changeStatus('C');
                            await changeTime('S3time');
                          } else if (thiscatch.status == 'C') {
                            toastMessage('đang hoàn thành');
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
                              historyTransaction his = historyTransaction(id: generateID(10), senderId: '', receiverId: currentAccount.id, transactionTime: getCurrentTime(), type: 7, content: thiscatch.id, money: money, area: thiscatch.owner.Area);
                              await changeMoney(currentAccount.totalMoney + money);
                              await pushData(his);
                            }
                            await changeStatus('D');
                            await changeTime('S4time');
                          }
                        }),
                  ),
                ),

                Container(
                  height: ((thiscatch.status == 'A' ||thiscatch.status == 'B' || thiscatch.status == 'C') ? 10 : 0),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 0,
                    child: ButtonType1(Height: thiscatch.status == 'B' ? 40 : 0, Width: 100, color: cancelbtnColor, radiusBorder: 5, title: canceltext, fontText: 'arial', colorText: Colors.white,
                        onTap: () async {
                          if (thiscatch.status == 'B') {
                            toastMessage('đang hủy đơn');
                            await changeStatus('G');
                            await changeTime('S4time');
                            toastMessage('đã hủy đơn');
                          }

                          if (thiscatch.status == 'C') {
                            await changeStatus('H');
                            await changeTime('S4time');
                            toastMessage('đã hủy đơn');
                          }
                        }),
                  ),
                ),

                Container(height: 15,)
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
