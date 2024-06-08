import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/product_order_screen/cart_screen/item_store_cart_product.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/product_order_screen/cart_screen/product_order_step_1/product_order_step_1.dart';

import '../../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../../Data/accountData/shopData/cartProduct.dart';
import '../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../Data/otherData/Time.dart';
import '../../../../../Data/otherData/Tool.dart';
import '../../../../../Data/otherData/utils.dart';
import '../../../../../Data/voucherData/Voucher.dart';

class view_store_cart_screen extends StatefulWidget {
  final Widget beforewidget;
  const view_store_cart_screen({super.key, required this.beforewidget});

  @override
  State<view_store_cart_screen> createState() => _view_store_cart_screenState();
}

class _view_store_cart_screenState extends State<view_store_cart_screen> {
  bool loading = false;

  Future<void> add_restaurant_to_list(List<cartProduct> list, List<ShopAccount> shops) async {
    shops.clear();
    for (cartProduct cartproduct in list) {
      if (shops.any((shop) => shop.id == cartproduct.product.owner)) {

      } else {
        ShopAccount account = await get_restaurant_info(cartproduct.product.owner);
        shops.add(account);
      }
    }
  }

  Future<ShopAccount> get_restaurant_info(String id) async {
    dynamic orders;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Store").child(id).once().then((DatabaseEvent event) {
      orders = event.snapshot.value;
    });
    return ShopAccount.fromJson(orders);
  }

  void add_time_and_product(List<Time> times, List<cartProduct> products) {
    for (int i = 0; i < 6; i++) {
      times.add(Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0));
    }

    for (int i = 0; i < finalData.storeCartList.length; i++) {
      cartProduct product = finalData.storeCartList[i];
      products.add(product);
    }
  }

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
    costFee: finalData.foodShipCost,
    note: '',
    waitFee: 0,
    weatherFee: 0,
    pointFee: 0,
    resCost: finalData.restaurantcost,
  );
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.beforewidget));
                            },
                          ),

                          Container(width: 10,),

                          Container(
                            width: width - 20 - 80,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, bottom: 0),
                              child: Container(
                                height: 23,
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'Giỏ hàng của tôi',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 100,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 100,
                left: 10,
                right: 10,
                bottom: 80,
                child: Container(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: finalData.storeCartList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: item_store_cart_product(product: finalData.storeCartList[index], event: () {
                          setState(() {

                          });
                        }),
                      );
                    },
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            child: Container(
                              width: width - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [Colors.yellow.withOpacity(0.4), Colors.yellow],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: Container(
                                      width: width - 20 - 40,
                                      height: 20,
                                      child: !loading ? RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Giỏ hàng   |  ',
                                            ),
                                            TextSpan(
                                              text: finalData.storeCartList.length.toString() + ' món',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal, // Cài đặt FontWeight.normal cho "món"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ) : Container(height: 20, width: 20, alignment: Alignment.center, child: CircularProgressIndicator(color: Colors.black,),),
                                    ),
                                  ),

                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      width: width - 20 - 40,
                                      height: 20,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        getStringNumber(get_total_cart_money()) + '.đ',
                                        style: TextStyle(
                                          fontFamily: 'muli',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    if (finalData.storeCartList.length == 0) {
                      toastMessage('Giỏ hàng chưa có sản phẩm nào');
                    } else {
                      setState(() {
                        loading = true;
                      });
                      await add_restaurant_to_list(finalData.storeCartList, order.shopList);
                      order.locationSet = order.shopList.first.location;
                      order.locationGet = finalData.user_account.location;
                      order.pointFee = (order.shopList.length - 1).toDouble() * 5000;
                      add_time_and_product(order.timeList, order.productList);
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => product_order_step_1(beforeWidget: widget.beforewidget, order: order,),),);
                    }
                  },
                ),
              ),
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
