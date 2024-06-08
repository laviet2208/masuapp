import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/catch_type_1_ingredient/request_sub_fee_button.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/express_order_ingredient/receive_button.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/express_order_ingredient/general_info_express_order.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/shipper_main_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import '../../../../../../Data/OrderData/expressOrder/personInfo.dart';
import '../../../../../../Data/locationData/Location.dart';
import '../../../../../../Data/otherData/Time.dart';
import '../../../../../../Data/otherData/Tool.dart';
import '../../../../../../Data/voucherData/Voucher.dart';
import '../../../../../userScreen/express_screen/ingredient/location_title_custom_express.dart';

class view_un_express_order extends StatefulWidget {
  final String id;
  const view_un_express_order({super.key, required this.id});

  @override
  State<view_un_express_order> createState() => _view_un_express_orderState();
}

class _view_un_express_orderState extends State<view_un_express_order> {
  double weightFee = 0;
  String weightType = 'Dưới 10kg';

  expressOrder order = expressOrder(
    id: '',
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
    costFee: finalData.expressShipCost,
    subFee: 0,
    codMoney: 0,
    sender: personInfo(name: '', phone: ''),
    receiver: personInfo(name: '', phone: ''),
    item: '',
    weightType: 1,
    note: '',
    payer: 0,
  );

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = expressOrder.fromJson(orders);
      setState(() {
        if (order.weightType == 1) {
          weightFee = 10000;
          weightType = 'Từ 10 -> 20kg';
        }

        if (order.weightType == 2) {
          weightFee = 20000;
          weightType = 'Trên 20kg';
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  finalData.shipperIndexTempotary.intData = 1;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
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

              general_info_express_order(order: order),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: get_usually_decoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(height: 20,),

                      location_title_custom_express(type: 'start', title: 'Điểm lấy hàng',),

                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 10),
                        child: general_ingredient.get_location_text(order.locationSet.mainText + ' ' + order.locationSet.secondaryText, Colors.black),
                      ),

                      Container(
                        width: 40,
                      ),

                      location_title_custom_express(type: 'end', title: 'Điểm giao hàng',),

                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 10),
                        child: general_ingredient.get_location_text(order.locationGet.mainText + ' ' + order.locationGet.secondaryText, Colors.black),
                      ),

                      Container(height: 20,),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: get_usually_decoration(),
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

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: general_ingredient.get_cost_title('Chi phí di chuyển(' + getDistanceOfBike(order.cost, order.costFee).toStringAsFixed(1) + ' Km)', Colors.black, FontWeight.bold, width),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: Container(
                                height: 30,
                                width: (width - 40 - 20)/2,
                                alignment: Alignment.centerRight,
                                child: general_ingredient.get_cost_content(getStringNumber(order.cost) + '.đ', Colors.black, FontWeight.bold, width),
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
                              child: general_ingredient.get_cost_title(order.subFee == 0 ? 'Phụ phí thời tiết' : ('Phụ phí ' + finalData.weathercost.weatherTitle), Colors.black, FontWeight.bold, width),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: general_ingredient.get_cost_content(order.subFee == 0 ? 'Chưa có' : (getStringNumber(order.subFee) +'.đ'), Colors.black, FontWeight.bold, width),
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
                              child: general_ingredient.get_cost_title('Phụ phí cân nặng', Colors.black, FontWeight.bold, width),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: general_ingredient.get_cost_content(getStringNumber(weightFee) + ".đ", Colors.black, FontWeight.bold, width),
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
                              child: general_ingredient.get_cost_title('Mã giảm giá', Colors.black, FontWeight.bold, width),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: general_ingredient.get_cost_content(order.voucher.id == '' ? "Không có" : ('- ' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'), Colors.redAccent, FontWeight.bold, width),
                            ),
                          ],
                        ),
                      ),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                              color: Colors.red
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
                              child: general_ingredient.get_cost_title('Thu của khách', Colors.black, FontWeight.bold, width),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: general_ingredient.get_cost_content(getStringNumber(order.cost - getVoucherSale(order.voucher, order.cost) + order.subFee + weightFee) +'.đ', Colors.black, FontWeight.bold, width),
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
                              child: general_ingredient.get_cost_title('Shipper thực nhận', Colors.black, FontWeight.bold, width),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 7, bottom: 7),
                              child: general_ingredient.get_cost_content(getStringNumber(order.cost - getShipDiscount(order.cost, order.costFee) + order.subFee + weightFee) +'.đ', Colors.black, FontWeight.bold, width),
                            ),
                          ],
                        ),
                      ),

                      Container(height: 20,),

                      receive_button(order: order),

                      Container(height: 10,),

                      request_sub_fee_button(order: order),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                      ),

                      Container(height: 20,),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        finalData.shipperIndexTempotary.intData = 1;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => shipper_main_screen(),),);
        return true;
      },
    );
  }
}
