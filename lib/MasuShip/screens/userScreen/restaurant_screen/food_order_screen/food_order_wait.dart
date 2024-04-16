import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/ingredient/cancel_food_order_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/ingredient/food_order_log.dart';
import '../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../Data/accountData/shopData/cartProduct.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../express_screen/ingredient/location_title_custom_express.dart';
import '../../general/title_gradient_container.dart';
import '../../main_screen/user_main_screen.dart';
import 'food_order_step_1/item_food_view.dart';

class food_order_wait extends StatefulWidget {
  final String id;
  const food_order_wait({super.key, required this.id});

  @override
  State<food_order_wait> createState() => _food_order_waitState();
}

class _food_order_waitState extends State<food_order_wait> {

  foodOrder order = foodOrder(
    id: generateID(25),
    locationSet: finalData.user_account.location,
    locationGet: finalData.user_account.location,
    cost: 0,
    owner: finalData.user_account,
    shipper: finalData.shipper_account,
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    productList: [],
    shopList: [],
    timeList: [],
    costFee: finalData.bikeCost,
    note: '',
    waitFee: 0,
    weatherFee: 0,
    pointFee: 0,
    resCost: finalData.restaurantcost,
  );

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = foodOrder.fromJson(orders);
      setState(() {

      });
    });
  }

  double get_total_cart_money(List<cartProduct> list) {
    double money = 0;
    for(int i = 0; i < list.length; i++) {
      money = money + (list[i].number * list[i].product.cost);
    }
    return money;
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
              Container(height: 20,),

              back_button_in_wait(),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 170,
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

                              location_title_custom_express(type: 'start', title: 'Điểm nhận đồ ăn'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 20),
                                child: general_ingredient.get_location_text(order.locationGet.mainText + order.locationGet.secondaryText, Colors.black),
                              ),

                              Container(height: 10,),

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
                                          child: food_order_log(order: order),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.add_location_alt_outlined, title: 'Vị trí nhận đồ ăn'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80 * order.productList.length.toDouble() + 50,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
                            child: Container(
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 20),
                                itemCount: order.productList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: item_food_view(product: order.productList[index],),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.fastfood_outlined, title: 'Danh sách món ăn'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 360,
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
                                      child: general_ingredient.get_cost_title('Giá tiền món ăn', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(get_total_cart_money(order.productList)) + '.đ', Colors.black, FontWeight.bold, width),
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
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: FutureBuilder(
                                          future: getDistance(order.locationSet, order.locationGet),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_title('Chi phí ship(...km)', Colors.black, FontWeight.bold, width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_title('Lỗi khoảng cách', Colors.black, FontWeight.bold, width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_title('Lỗi khoảng cách', Colors.black, FontWeight.bold, width);
                                            }

                                            return general_ingredient.get_cost_title('Chi phí ship(' + snapshot.data!.toStringAsFixed(1) + ' Km)', Colors.black, FontWeight.bold, width);
                                          },
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(order.cost) + '.đ', Colors.black, FontWeight.bold, width),
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
                                      child: general_ingredient.get_cost_title('Phụ thu thêm điểm(' + order.shopList.length.toString() + ' điểm)', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(order.pointFee) + '.đ', Colors.black,order.shopList.length == 0 ? FontWeight.normal : FontWeight.bold, width),
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
                                      child: general_ingredient.get_cost_title(order.weatherFee == 0 ? 'Phụ thu thời tiết' : ('Phụ thu ' + finalData.weathercost.weatherTitle), Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(order.weatherFee) + '.đ', Colors.black,order.weatherFee == 0 ? FontWeight.normal : FontWeight.bold, width),
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
                                      child: general_ingredient.get_cost_title('Phụ thu chờ món', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(order.waitFee) + '.đ', Colors.black, order.weatherFee == 0 ? FontWeight.normal : FontWeight.bold, width),
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
                                      child: general_ingredient.get_cost_content(order.voucher.id == '' ? 'Không chọn mã' : ('-' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'), Colors.red, FontWeight.normal, width),
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
                                      child: general_ingredient.get_cost_content(getStringNumber(order.cost + order.pointFee + order.weatherFee + order.waitFee + get_total_cart_money(order.productList) - getVoucherSale(order.voucher, order.cost)) + '.đ', Colors.black, FontWeight.bold, width),
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
                        child: title_gradient_container(icon: Icons.money_outlined, title: 'Thông tin thanh toán'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              cancel_food_order_button(order: order),

              Container(height: 20,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return true;
      },
    );
  }
}
