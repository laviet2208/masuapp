import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Order/catchOrder.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/OTHER/Button/Buttontype1.dart';
import 'package:masuapp/SCREEN/FEATURE/SCREEN_CARORDER/SCREENcarorder.dart';
import 'package:masuapp/SCREEN/FEATURE/SCREEN_CARORDER/SCREEN_waitdriver.dart';

import '../../../GENERAL/NormalUser/accountLocation.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Product/Useruse.dart';
import '../../../GENERAL/Product/Voucher.dart';
import '../../../GENERAL/Tool/Time.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../VOUCHER/Khung chọn voucher.dart';
import '../../VOUCHER/SCREENvoucherchosen.dart';

class SCREENlocationcarst2 extends StatefulWidget {
  final double Distance;
  final accountLocation diemdon;
  final accountLocation diemtra;
  const SCREENlocationcarst2({Key? key, required this.Distance, required this.diemdon, required this.diemtra}) : super(key: key);

  @override
  State<SCREENlocationcarst2> createState() => _SCREENlocationcarst2State();
}

class _SCREENlocationcarst2State extends State<SCREENlocationcarst2> {
  late GoogleMapController mapController;
  double _originLatitude = 0, _originLongitude = 0;
  double _destLatitude = 0, _destLongitude = 0;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  final vouchercontroller = TextEditingController();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBsVQaVVMXw-y3QgvCWwJe02FWkhqP_wRA";
  bool Loading1 = false;
  double cost = 0;
  bool isLoading = false;
  final voucherController = TextEditingController();
  Voucher chosenVoucher = Voucher(id: '', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
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
    if (distance >= carCost.departKM) {
      cost += carCost.departKM.toInt() * carCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= carCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - carCost.departKM) * carCost.perKMcost).toInt();
    } else {
      cost += (distance * carCost.departCost).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  double getLastCost(double cost, Voucher voucher) {
    if (voucher.id != '') {
      if (voucher.type == 0) {
        cost = cost - voucher.totalmoney;
      } else {
        double sale = cost * (voucher.totalmoney.toDouble()/100);
        if (sale > voucher.maxSale) {
          return cost - voucher.maxSale;
        } else {
          return cost - sale;
        }
      }
    }
    return cost;
  }

  Future<void> pushCatchOrder(catchOrder catchorder) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder').child(catchorder.id).set(catchorder.toJson());
      if (mounted) {
        toastMessage('Đặt đơn thành công , vui lòng kiểm tra lịch sử');
        Navigator.push(context, MaterialPageRoute(builder: (context) => SCREENwaitdriver(diemdon: widget.diemdon, diemtra: widget.diemtra,)));
      }
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void VoucherChange() {
    if (chosenVoucher.id != '') {
      voucherController.text = (chosenVoucher.type == 0) ? (getStringNumber(chosenVoucher.totalmoney) + 'đ') : (getStringNumber(chosenVoucher.totalmoney) + '%');
    } else {
      voucherController.text = (chosenVoucher.type == 0) ? '0đ' : '0%';
    }
  }

  Future<void> pushUserCountData(String id, Voucher voucher) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child("VoucherStorage/" + id).set(voucher.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _originLatitude = widget.diemdon.Latitude;
    _originLongitude = widget.diemdon.Longitude;
    _destLatitude = widget.diemtra.Latitude;
    _destLongitude = widget.diemtra.Longitude;
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);

    _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    cost = getCost(widget.Distance).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
            body: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: screenHeight/1.5,
                      width: screenWidth,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(_originLatitude, _originLongitude), zoom: 12),
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
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: screenHeight/2.5,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 5,
                            left: 10,
                            child: Container(
                              height: 40,
                              width: screenWidth - 10,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage('assets/image/minicar.png')
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(width: 5,),

                                  Container(
                                    width: screenWidth - 10 - 10 - 40,
                                    height: 40,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      child: AutoSizeText(
                                        "Loại phương tiện",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "arial",
                                          fontWeight: FontWeight.normal,
                                          fontSize: 200,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: 50,
                            left: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight/10,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 237, 216)
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: (screenHeight/10 - screenHeight/14)/2,
                                    left: 10,
                                    child: Container(
                                      height: screenHeight/14,
                                      width: screenHeight/14,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/mainLogo.png')
                                          )
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: (screenHeight/10)/3,
                                    left: 10 + screenHeight/14 + 15,
                                    child: Container(
                                      child: Text(
                                        'Xe taxi 4 chỗ',
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight/2.5 - 50 - screenHeight/10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3), // màu của shadow
                                    spreadRadius: 5, // bán kính của shadow
                                    blurRadius: 7, // độ mờ của shadow
                                    offset: Offset(0, 3), // vị trí của shadow
                                  ),
                                ],
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    bottom: 20 + screenHeight/15 + 20 + 30,
                                    left: 20,
                                    child: Container(
                                      child: Text(
                                        'Tổng phí vận chuyển',
                                            style: TextStyle(
                                                fontFamily: 'arial',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                            ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 20 + screenHeight/15 + 20 + 30,
                                    right: 10,
                                    child: Text(
                                      getStringNumber(cost) + ".đ",
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 25 + screenHeight/15 + 20,
                                    left: 10,
                                    right: 10,
                                    child: Container(
                                      width: screenWidth,
                                      height: 18,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              width: screenWidth,
                                              height: 18,
                                              child: AutoSizeText(
                                                '  Mã khuyến mãi',
                                                style: TextStyle(
                                                    fontFamily: 'arial',
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 180
                                                ),
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: screenWidth-10,
                                              height: 18,
                                              child: AutoSizeText(
                                                "- " + voucherController.text,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontFamily: 'arial',
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 0 + screenHeight/15 + 20,
                                    left: 20,
                                    child: Container(
                                      child: Text(
                                        'Chi phí vận chuyển(' + double.parse(widget.Distance.toStringAsFixed(1)).toString() + "km)",
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 0 + screenHeight/15 + 20,
                                    right: 10,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: getStringNumber(getLastCost(cost, chosenVoucher)) + "đ",
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

                                  Positioned(
                                    top: screenHeight/19,
                                    left: 0,
                                    child: Container(
                                      width: screenWidth,
                                      height: 1,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                            255, 255, 217, 169)
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: screenWidth,
                                      height: screenHeight/19 - 1,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: screenWidth/2-0.5,
                                            height: screenHeight/19 - 1,
                                            child: Row(
                                              children: [
                                                Container(width: 5,),

                                                Container(
                                                  height: screenHeight/19 - 1,
                                                  width: screenHeight/19 - 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage('assets/image/ghichu.png')
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  height: screenHeight/19 - 1,
                                                  width: screenWidth/2-0.5 - 3 - screenHeight/19 - 1 - 10,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 13, bottom: 13),
                                                    child: AutoSizeText(
                                                      'Ghi chú',
                                                      style: TextStyle(
                                                        fontSize: 160,
                                                        fontFamily: 'roboto',
                                                        fontStyle: FontStyle.normal,
                                                        color: Colors.black
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: 8,bottom: 8),
                                            child: Container(
                                              width: 1,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),

                                          GestureDetector(
                                            child: Container(
                                              width: screenWidth/2-0.5,
                                              height: screenHeight/19 - 1,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(width: 5,),

                                                  Container(
                                                    height: screenHeight/19 - 1,
                                                    width: screenHeight/19 - 1,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: AssetImage('assets/image/khuyenmai.png')
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    height: screenHeight/19 - 1,
                                                    width: screenWidth/2-0.5 - 3 - screenHeight/19 - 1 - 10,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 13, bottom: 13),
                                                      child: AutoSizeText(
                                                        'Khuyến mãi',
                                                        style: TextStyle(
                                                            fontSize: 160,
                                                            fontFamily: 'roboto',
                                                            fontStyle: FontStyle.normal,
                                                            color: Colors.black
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return ChosenVoucherWhenOrder(screenHeight: screenHeight, chosenVoucher: chosenVoucher, screenWidth: screenWidth,
                                                      setstateEvent: () {
                                                        setState(() {
                                                          VoucherChange();
                                                          print(chosenVoucher.toJson().toString());
                                                        });
                                                      }, cost: cost, voucherController: voucherController, Otype: '1',);
                                                  },
                                                );
                                              }
                                          )
                                        ],
                                      )
                                    ),
                                  ),
                                  ///Nút đặt xe
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                      width: screenWidth - 20,
                                      height: screenHeight/15,
                                      child: ButtonType1(Height: screenHeight/10, Width: screenWidth/2 - 20, color: Color.fromARGB(255, 244, 164, 84), radiusBorder: 30, title: 'Đặt xe', fontText: 'arial', colorText: Colors.white,
                                        onTap: () async {
                                          setState(() {
                                            Loading1 = true;
                                          });
                                          accountNormal shipper = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0);

                                          catchOrder thiscatch = catchOrder(
                                              id: generateID(10),
                                              locationSet: widget.diemdon,
                                              locationGet: widget.diemtra,
                                              cost: getLastCost(cost, chosenVoucher),
                                              owner: currentAccount,
                                              shipper: shipper,
                                              status: 'A',
                                              S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                              S1time: getCurrentTime(),
                                              S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                              S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                              type: 2,
                                              voucher: chosenVoucher,
                                              costFee: bikeCost
                                          );

                                          if (chosenVoucher.id != '') {
                                            Useruse user = Useruse(id: '', count: 0);
                                            int index = -1;
                                            for(Useruse useruse in chosenVoucher.CustomList) {
                                              if (useruse.id == currentAccount.id) {
                                                user.id = useruse.id;
                                                user.count = useruse.count;
                                                index = chosenVoucher.CustomList.indexOf(useruse);
                                              }
                                            }

                                            if (user.id == '') {
                                              user.id = currentAccount.id;
                                              user.count = 1;
                                              chosenVoucher.CustomList.add(user);
                                              await pushUserCountData(chosenVoucher.id, chosenVoucher);
                                            } else {
                                              user.count = user.count + 1;
                                              chosenVoucher.CustomList[index].count = user.count;
                                              await pushUserCountData(chosenVoucher.id, chosenVoucher);
                                            }
                                          }

                                          await pushCatchOrder(thiscatch);
                                        }, loading: Loading1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),

                  ///Nút back
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENcarorder()));
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/image/backicon1.png'),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            )
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
