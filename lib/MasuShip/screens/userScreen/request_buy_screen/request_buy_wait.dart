import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/cancel_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/item_market_location_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/item_request_product_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/order_log_buy_request_ingredient.dart';
import '../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../Data/otherData/Time.dart';
import '../../../Data/voucherData/Voucher.dart';
import '../bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import '../general/title_gradient_container.dart';

class request_but_wait extends StatefulWidget {
  final String id;
  const request_but_wait({super.key, required this.id});

  @override
  State<request_but_wait> createState() => _request_but_waitState();
}

class _request_but_waitState extends State<request_but_wait> {

  requestBuyOrder order = requestBuyOrder(
      id: generateID(25),
      locationSet: finalData.shipper_account.location,
      locationGet: finalData.shipper_account.location,
      cost: 0,
      owner: finalData.user_account,
      shipper: finalData.shipper_account,
      status: 'A',
      voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
      S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      productList: [],
      costFee: finalData.bikeCost,
      buyLocation: []
  );

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = requestBuyOrder.fromJson(orders);
      setState(() {

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
    double height = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button_in_wait(),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80 * order.buyLocation.length.toDouble() + 160,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 80 * order.buyLocation.length.toDouble(),
                                child: ListView.builder(
                                  itemCount: order.buyLocation.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return item_market_location_wait(index: index, list: order.buyLocation,);
                                  },
                                ),
                              ),

                              location_title(type: 'end'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: FutureBuilder(
                                  future: fetchLocationName(order.locationGet),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return general_ingredient.get_location_text('Đang tải vị trí ...');
                                    }

                                    if (snapshot.hasError) {
                                      return general_ingredient.get_location_text('Lỗi dữ liệu vị trí, vui lòng thử lại');
                                    }

                                    if (!snapshot.hasData) {
                                      return general_ingredient.get_location_text('Lỗi dữ liệu vị trí, vui lòng thử lại');
                                    }

                                    return general_ingredient.get_location_text(snapshot.data!.toString());
                                  },
                                ),
                              ),

                              Container(height: 8,),

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Xem hành trình',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.blueAccent,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        title: Text('Hành trình đơn hàng', style: TextStyle(fontFamily: 'muli'),),
                                        content: Container(
                                          width: MediaQuery.of(context).size.width - 10,
                                          child: order_log_buy_request_ingredient(order: order),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              Container(height: 8,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.store_mall_directory_outlined, title: 'Vị trí mua, trả hàng'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 60 + 45 * order.productList.length.toDouble(),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 45 * order.productList.length.toDouble(),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: order.productList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return item_request_product_wait(index: index, list: order.productList,);
                                  },
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
                        child: title_gradient_container(icon: Icons.shopping_bag_outlined, title: 'Hàng hóa cần mua'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 280,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
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
                                        child: order.buyLocation.length != 0 ? FutureBuilder(
                                          future: getDistance(order.buyLocation.first, order.locationGet),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_title('Chi phí di chuyển(...Km)', Colors.black, FontWeight.bold, width);
                                            }
                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_title('Lỗi tính toán', Colors.black, FontWeight.bold, width);
                                            }
                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_title('Lỗi tính toán', Colors.black, FontWeight.bold, width);
                                            }
                                            return general_ingredient.get_cost_title('Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + ' Km)', Colors.black, FontWeight.bold, width);
                                          },
                                        ) : general_ingredient.get_cost_title('Chi phí di chuyển(...Km)', Colors.black, FontWeight.bold, width),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: order.buyLocation.length != 0 ? FutureBuilder(
                                          future: getCost(order.buyLocation.first, order.locationGet, height),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_content('Đang tính toán', Colors.black, FontWeight.normal, width);
                                            }
                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_content('Lỗi tính toán', Colors.redAccent, FontWeight.normal, width);
                                            }
                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_content('Lỗi tính toán', Colors.redAccent, FontWeight.normal, width);
                                            }
                                            return general_ingredient.get_cost_content(getStringNumber(double.parse(snapshot.data.toString())) + '.đ', Colors.black, FontWeight.bold, width);
                                          },
                                        ) : general_ingredient.get_cost_content('Chưa chọn vị trí', Colors.black, FontWeight.normal, width),
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
                                      child: general_ingredient.get_cost_title('Phụ thu thời tiết', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content('0.đ', Colors.black, FontWeight.bold, width),
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
                                      child: general_ingredient.get_cost_title('Phụ thu hàng hóa(' + order.productList.length.toString() + ' điểm)', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber((10000 * ((order.productList.length/3).toInt()).toDouble())) + '.đ', Colors.black, FontWeight.bold, width),
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
                                      child: GestureDetector(
                                        child: general_ingredient.get_cost_content('Chưa chọn mã', Colors.redAccent, FontWeight.bold, width),
                                        onTap: () {

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
                                      child: general_ingredient.get_cost_title('Tổng thanh toán', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: order.buyLocation.length != 0 ? FutureBuilder(
                                          future: getCost(order.buyLocation.first, order.locationGet, height),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_content('Đang tính toán', Colors.black, FontWeight.bold, width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_content('Lỗi tính toán', Colors.redAccent, FontWeight.normal, width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_content('Lỗi tính toán', Colors.redAccent, FontWeight.normal, width);
                                            }

                                            return general_ingredient.get_cost_content(getStringNumber(double.parse(snapshot.data.toString()) + 10000 * ((order.productList.length/3).toInt()).toDouble()) + '.đ', Colors.black, FontWeight.bold, width);
                                          },
                                        ) : general_ingredient.get_cost_content('Chưa tính toán', Colors.black, FontWeight.bold, width),
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
                        child: title_gradient_container(icon: Icons.featured_play_list_outlined, title: 'Thông tin hóa đơn'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              cancel_button(order: order),

              Container(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
