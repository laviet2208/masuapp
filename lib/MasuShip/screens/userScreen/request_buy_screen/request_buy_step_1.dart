import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/map_api_interact.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/action/add_product.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/item_market_location.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/item_request_product.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/ingredient/start_order_button.dart';
import '../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../Data/locationData/Location.dart';
import '../../../Data/otherData/Tool.dart';
import '../general/search_location_dialog.dart';
import '../general/voucher_select.dart';
import '../main_screen/user_main_screen.dart';

class request_buy_step_1 extends StatefulWidget {
  const request_buy_step_1({super.key});

  @override
  State<request_buy_step_1> createState() => _request_buy_step_1State();
}

class _request_buy_step_1State extends State<request_buy_step_1> {
  double product_fee = 0;
  
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
      costFee: finalData.requestBuyShipCost,
      buyLocation: [],
    subFee: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    order.locationGet = finalData.user_account.location;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: [
              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,

                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withOpacity(0.2), Colors.yellow],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: -70,
                                bottom: 0,
                                child: Container(

                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/bikeLogo2.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Bạn ngại đi chợ\n',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),

                                  TextSpan(
                                    text: 'Có Masu Ship',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),

                                  TextSpan(
                                    text: ' đi hộ',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 140,
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
                                    location_title(type: 'end'),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {return search_location_dialog(location: order.locationGet, title: 'Chọn điểm nhận hàng', event: () {setState(() {});});}
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),

                              ),

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
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.location_on_outlined, title: 'Bạn muốn nhận hàng tại'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 90 + 45 * order.productList.length.toDouble(),
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
                                    return item_request_product(index: index, list: order.productList, callback: () {setState(() {});});
                                  },
                                ),
                              ),

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 18,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: AutoSizeText(
                                      'Thêm mặt hàng',
                                      style: TextStyle(
                                          fontFamily: 'muli',
                                          color: Colors.blueAccent,
                                          fontSize: 100
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return add_product(list: order.productList, event: () {
                                        product_fee = 10000 * ((order.productList.length/3).toInt()).toDouble();
                                        setState(() {

                                        });
                                      });
                                    },
                                  );
                                },
                              ),

                              Container(height: 10,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.shopping_bag_outlined, title: 'Hàng hóa cần mua hộ'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80 * order.buyLocation.length.toDouble() + 90,
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
                                    return item_market_location(index: index, list: order.buyLocation, callback: () {setState(() {});},);
                                  },
                                ),
                              ),

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 18,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: AutoSizeText(
                                      'Thêm vị trí mua hàng',
                                      style: TextStyle(
                                          fontFamily: 'muli',
                                          color: Colors.blueAccent,
                                          fontSize: 100
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (order.productList.length != 0) {
                                    Location location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return search_location_dialog(location: location, title: 'Thêm vị trí mua hàng',
                                            event: () {
                                              order.buyLocation.add(location);
                                              setState(() {});
                                            }
                                        );
                                      },
                                    );
                                  } else {
                                    toastMessage('Bạn cần thêm sản phẩm trước');
                                  }
                                },
                              ),

                              Container(height: 10,),

                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.store_mall_directory_outlined, title: 'Bạn muốn mua hàng ở đâu?'),
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
                                child: Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: order.buyLocation.length != 0 ? FutureBuilder(
                                    future: map_api_interact.getMaxDistance(order.buyLocation, order.locationGet),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Row(
                                          children: [
                                            Container(
                                              width: 10,
                                            ),

                                            general_ingredient.get_cost_title('Chi phí di chuyển(...Km)', Colors.black, FontWeight.bold, width),

                                            general_ingredient.get_cost_content('Đang tính toán', Colors.black, FontWeight.normal, width),
                                          ],
                                        );
                                      }

                                      if (snapshot.hasError)
                                      {
                                        return Row(
                                          children: [
                                            Container(
                                              width: 10,
                                            ),

                                            general_ingredient.get_cost_title('Chi phí di chuyển(lỗi)', Colors.black, FontWeight.bold, width),

                                            general_ingredient.get_cost_content('Lỗi tính toán', Colors.black, FontWeight.normal, width),
                                          ],
                                        );
                                      }
                                      if (!snapshot.hasData) {
                                        return Row(
                                          children: [
                                            Container(
                                              width: 10,
                                            ),

                                            general_ingredient.get_cost_title('Chi phí di chuyển(lỗi)', Colors.black, FontWeight.bold, width),

                                            general_ingredient.get_cost_content('Lỗi tính toán', Colors.black, FontWeight.normal, width),
                                          ],
                                        );
                                      }

                                      return Row(
                                        children: [
                                          Container(
                                            width: 10,
                                          ),

                                          general_ingredient.get_cost_title('Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + 'Km)', Colors.black, FontWeight.bold, width),

                                          general_ingredient.get_cost_content(getStringNumber(getShipCost(snapshot.data!, order.costFee)) + '.đ', Colors.black, FontWeight.normal, width),
                                        ],
                                      );
                                    },
                                  ) : Row(
                                    children: [
                                      Container(
                                        width: 10,
                                      ),

                                      general_ingredient.get_cost_title('Chi phí di chuyển(chưa chọn)', Colors.black, FontWeight.bold, width),

                                      general_ingredient.get_cost_content('Chưa chọn', Colors.black, FontWeight.normal, width),
                                    ],
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
                                        child: general_ingredient.get_cost_content(order.voucher.id == '' ? 'Chọn mã khuyến mãi' : (getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'), Colors.redAccent, FontWeight.bold, width),
                                        onTap: () {
                                          if (order.buyLocation.length == 0) {
                                            toastMessage('Bạn chưa thêm vị trí nào');
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return voucher_select(voucher: order.voucher, ontap: () {
                                                  setState(() {

                                                  });
                                                }, cost: order.cost);
                                              },
                                            );
                                          }
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
                                          future: map_api_interact.getMaxDistance(order.buyLocation, order.locationGet),
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

                                            return general_ingredient.get_cost_content(getStringNumber(getShipCost(snapshot.data!, order.costFee) - getVoucherSale(order.voucher, getShipCost(snapshot.data!, order.costFee)) + 10000 * ((order.productList.length/3).toInt()).toDouble()) + '.đ', Colors.black, FontWeight.bold, width);
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

              start_order_button(order: order),

              Container(height: 30,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
