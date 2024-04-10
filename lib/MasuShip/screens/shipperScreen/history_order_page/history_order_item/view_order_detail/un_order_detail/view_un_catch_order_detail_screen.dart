import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_1_ingredient/price_list_order_type_1.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_1_ingredient/receive_button.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_1_ingredient/request_sub_fee_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../Data/costData/Cost.dart';
import '../../../../../../Data/historyData/historyTransactionData.dart';
import '../../../../../../Data/locationData/Location.dart';
import '../../../../../../Data/otherData/Tool.dart';
import '../../../../../../Data/voucherData/Voucher.dart';
import '../../../../main_screen/shipper_main_screen.dart';
import 'ingredient/catch_type_2_ingredient/general_info_order_type_2.dart';
import 'ingredient/catch_type_2_ingredient/location_order_type_2.dart';

class view_catch_order_detail_screen extends StatefulWidget {
  final String id;
  const view_catch_order_detail_screen({Key? key, required this.id}) : super(key: key);

  @override
  State<view_catch_order_detail_screen> createState() => _view_catch_order_detail_screenState();
}

class _view_catch_order_detail_screenState extends State<view_catch_order_detail_screen> {
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

  CatchOrder order = CatchOrder(id: '', locationSet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), S1time: getCurrentTime(), S2time: getCurrentTime(), S3time: getCurrentTime(), S4time: getCurrentTime(), costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0), subFee: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order').child(widget.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      order = CatchOrder.fromJson(data);
      setState(() {

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

  Future<void> change_order_status(String status) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(widget.id).child('status').set(status);
  }

  Future<void> change_order_time(String time) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(widget.id).child(time).set(getCurrentTime().toJson());
  }

  static Future<void> change_shipper_money() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account/' + finalData.shipper_account.id + '/money').set(finalData.shipper_account.money);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  //hàm đẩy lịch sử tiền nong
  static Future<void> push_history_data(historyTransactionData his) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(his.id).set(his.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
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
            decoration: get_usually_decoration_type_2_gradient(),
            child: ListView(
              children: [
                Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.4), // màu của shadow
                      //     spreadRadius: 5, // bán kính của shadow
                      //     blurRadius: 7, // độ mờ của shadow
                      //     offset: Offset(0, 3), // vị trí của shadow
                      //   ),
                      // ],
                      // color: Colors.white
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
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 60,
                        right: 60,
                        top: 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Quay về menu chính',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                fontFamily: 'muli',
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(height: 20,),

                general_info_order_type_2(order: order,),

                Container(height: 20,),

                location_info_order_type_2(order: order),

                Container(height: 20,),

                price_list_order_type_1(order: order),

                Container(height: 20,),

                receive_button(order: order),

                Container(height: 10,),

                request_sub_fee_button(order: order),

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
