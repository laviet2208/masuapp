import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_3_ingredient/receive_type_3_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Data/costData/Cost.dart';
import '../../../../../../Data/locationData/Location.dart';
import '../../../../../../Data/otherData/Tool.dart';
import '../../../../../../Data/voucherData/Voucher.dart';
import '../../../../main_screen/shipper_main_screen.dart';
import 'ingredient/catch_type_1_ingredient/price_list_order_type_1.dart';
import 'ingredient/catch_type_1_ingredient/receive_button.dart';
import 'ingredient/catch_type_1_ingredient/request_sub_fee_button.dart';
import 'ingredient/catch_type_2_ingredient/general_info_order_type_2.dart';
import 'ingredient/catch_type_2_ingredient/location_order_type_2.dart';

class view_un_catch_order_type_3_detail_screen extends StatefulWidget {
  final String id;
  const view_un_catch_order_type_3_detail_screen({super.key, required this.id});

  @override
  State<view_un_catch_order_type_3_detail_screen> createState() => _view_un_catch_order_type_3_detail_screenState();
}

class _view_un_catch_order_type_3_detail_screenState extends State<view_un_catch_order_type_3_detail_screen> {
  bool loading = false;

  catchOrderType3 order = catchOrderType3(id: '', locationSet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), S1time: getCurrentTime(), S2time: getCurrentTime(), S3time: getCurrentTime(), S4time: getCurrentTime(), costFee: Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0), subFee: 0, type: 1, motherOrder: '');

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order').child(widget.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      order = catchOrderType3.fromJson(data);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: get_usually_decoration_type_2_gradient(),
            child: ListView(
              children: [
                GestureDetector(
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 5,
                          left: 10,
                          child: GestureDetector(
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              finalData.shipperIndexTempotary.intData = 1;
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
                            },
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
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
                  },
                ),

                Container(height: 20,),

                general_info_order_type_2(order: order,),

                Container(height: 20,),

                location_info_order_type_2(order: order),

                Container(height: 20,),

                price_list_order_type_1(order: order),

                Container(height: 20,),

                receive_type_3_button(order: order,),

                Container(height: 10,),

                request_sub_fee_button(order: order),

                Container(height: 20,),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        finalData.shipperIndexTempotary.intData = 1;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
        return true;
      },);
  }
}
