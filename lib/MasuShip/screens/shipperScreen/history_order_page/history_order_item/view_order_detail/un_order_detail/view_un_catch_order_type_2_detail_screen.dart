import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_2_ingredient/general_info_order_type_2.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_2_ingredient/location_order_type_2.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_2_ingredient/price_list_order_type_2.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_2_ingredient/receive_button.dart';
import '../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../Data/costData/Cost.dart';
import '../../../../../../Data/locationData/Location.dart';
import '../../../../../../Data/otherData/Tool.dart';
import '../../../../../../Data/voucherData/Voucher.dart';
import '../../../../main_screen/shipper_main_screen.dart';
import 'ingredient/catch_type_1_ingredient/request_sub_fee_button.dart';

class view_un_catch_order_type_2_detail_screen extends StatefulWidget {
  final String id;
  const view_un_catch_order_type_2_detail_screen({Key? key, required this.id}) : super(key: key);

  @override
  State<view_un_catch_order_type_2_detail_screen> createState() => _view_un_catch_order_type_2_detail_screenState();
}

class _view_un_catch_order_type_2_detail_screenState extends State<view_un_catch_order_type_2_detail_screen> {
  CatchOrder order = CatchOrder(id: '', locationSet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude:  0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), S1time: getCurrentTime(), S2time: getCurrentTime(), S3time: getCurrentTime(), S4time: getCurrentTime(), costFee: Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0), subFee: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('Order').child(widget.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      order = CatchOrder.fromJson(data);
      setState(() {

      });
    });
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
            decoration: get_usually_decoration_gradient(),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    finalData.shipperIndexTempotary.intData = 1;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
                  },
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
                ),

                Container(height: 20,),

                general_info_order_type_2(order: order,),

                Container(height: 20,),

                location_info_order_type_2(order: order),

                Container(height: 20,),

                price_list_order_type_2(order: order),

                Container(height: 20,),

                receive_button(order: order,),

                Container(height: 20,),

                request_sub_fee_button(order: order),

                Container(height: 20,),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        finalData.shipperIndexTempotary.intData = 1;
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
        return true;
      },);
  }
}
