import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/Order.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/order_have/buy_request_order_dialog.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../order_have/catch_order_have_dialog.dart';
import '../order_have/catch_order_have_type_2_dialog.dart';
import '../order_have/catch_order_have_type_3_dialog.dart';
import '../order_have/express_order_have_dialog.dart';
import '../order_have/food_order_have_dialog.dart';

class order_have_dialog_controller {
  //Hiển thị dialog nhận đơn bắt xe
  static Future<void> show_catch_order_have_dialog(BuildContext context, CatchOrder order) async {
    if (await check_get_order_success(order.id)) {
      print('5. check thành công lần 3');
      double money = get_commission(order.toJson());
      finalData.shipper_account.money = finalData.shipper_account.money - money;
      await change_shipper_money();
      await change_order_time('S2time', order.id);
      await push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn xe ôm' + order.id, money: money, area: finalData.shipper_account.area));
      print('Trừ tiền tài khoản, đẩy lịch sử lên');
      final player = AudioPlayer();
      await player.play(AssetSource('volume/ting.mp3'), volume: 200);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return catch_order_have_dialog(order: order,);
        },
      );
    } else {
      print('thất bại ở lần 3');
      finalData.shipper_account.orderHaveStatus = 0;
      await change_Have_Order_Status(0);
    }
  }

  //Hiển thị dialog nhận đơn bắt xe không biết điểm đến
  static Future<void> show_catch_order_type_2_have_dialog(BuildContext context, CatchOrder order) async {
    if (await check_get_order_success(order.id)) {
      print('5. check thành công lần 3');
      double money = get_commission(order.toJson());
      finalData.shipper_account.money = finalData.shipper_account.money - money;
      await change_shipper_money();
      await change_order_time('S2time', order.id);
      print('Trừ tiền tài khoản, đẩy lịch sử lên');
      final player = AudioPlayer();
      await player.play(AssetSource('volume/ting.mp3'), volume: 200);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return catch_order_have_type_2_dialog(order: order,);
        },
      );
    } else {
      print('thất bại ở lần 3');
      finalData.shipper_account.orderHaveStatus = 0;
      await change_Have_Order_Status(0);
    }
  }

  //Hiển thị dialog nhận đơn lái hộ
  static Future<void> show_catch_order_type_3_have_dialog(BuildContext context, catchOrderType3 order) async {
    if (await check_get_order_success(order.id)) {
      print('5. check thành công lần 3');
      double money = get_commission(order.toJson());
      finalData.shipper_account.money = finalData.shipper_account.money - money;
      await change_shipper_money();
      await change_order_time('S2time', order.id);
      await push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn xe ôm' + order.id, money: money, area: finalData.shipper_account.area));
      print('Trừ tiền tài khoản, đẩy lịch sử lên');
      final player = AudioPlayer();
      await player.play(AssetSource('volume/ting.mp3'), volume: 200);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return catch_order_have_type_3_dialog(order: order,);
        },
      );
    } else {
      print('thất bại ở lần 3');
      finalData.shipper_account.orderHaveStatus = 0;
      await change_Have_Order_Status(0);
    }
  }

  //Hiển thị dialog nhận đơn mua hộ theo yêu cầu
  static Future<void> show_buy_request_order_have_dialog(BuildContext context, requestBuyOrder order) async {
    if (await check_get_order_success(order.id)) {
      print('5. check thành công lần 3');
      double money = get_commission(order.toJson());
      finalData.shipper_account.money = finalData.shipper_account.money - money;
      await change_shipper_money();
      await change_order_time('S2time', order.id);
      await push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn xe ôm' + order.id, money: money, area: finalData.shipper_account.area));
      print('Trừ tiền tài khoản, đẩy lịch sử lên');
      final player = AudioPlayer();
      await player.play(AssetSource('volume/ting.mp3'), volume: 200);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return buy_request_order_dialog(order: order,);
        },
      );
    } else {
      print('thất bại ở lần 3');
      finalData.shipper_account.orderHaveStatus = 0;
      await change_Have_Order_Status(0);
    }
  }

  //Hiển thị dialog nhận đơn mua đồ ăn
  static Future<void> show_food_order_have_dialog(BuildContext context, foodOrder order) async {
    if (await check_get_order_success(order.id)) {
      print('5. check thành công lần 3');
      double money = get_commission(order.toJson());
      double res_discount_money = history_controller.get_discount_cost_of_restaurant(order.shopList, order.productList, order.resCost.discount);
      finalData.shipper_account.money = finalData.shipper_account.money - money - res_discount_money;
      await change_shipper_money();
      await change_order_time('timeList/1', order.id);
      await push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 9, content: 'Chiết khấu nhà hàng ' + order.id, money: res_discount_money, area: finalData.shipper_account.area));
      await push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn nhà hàng ' + order.id, money: money, area: finalData.shipper_account.area));
      print('Trừ tiền tài khoản, đẩy lịch sử lên');
      final player = AudioPlayer();
      await player.play(AssetSource('volume/ting.mp3'), volume: 200);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return food_order_have_dialog(order: order,);
        },
      );
    } else {
      print('thất bại ở lần 3');
      finalData.shipper_account.orderHaveStatus = 0;
      await change_Have_Order_Status(0);
    }
  }

  //Hiển thị dialog nhận đơn express
  static Future<void> show_express_order_have_dialog(BuildContext context, expressOrder order) async {
    if (await check_get_order_success(order.id)) {
      print('5. check thành công lần 3');
      double money = get_commission(order.toJson());
      finalData.shipper_account.money = finalData.shipper_account.money - money;
      await change_shipper_money();
      await change_order_time('S2time', order.id);
      await push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn xe ôm' + order.id, money: money, area: finalData.shipper_account.area));
      print('Trừ tiền tài khoản, đẩy lịch sử lên');
      final player = AudioPlayer();
      await player.play(AssetSource('volume/ting.mp3'), volume: 200);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return express_order_have_dialog(order: order,);
        },
      );
    } else {
      print('thất bại ở lần 3');
      finalData.shipper_account.orderHaveStatus = 0;
      await change_Have_Order_Status(0);
    }
  }

  static Future<void> change_order_time(String time, String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child(time).set(getCurrentTime().toJson());
  }

  //Chuyển đổi trạng thái tài khoản
  static Future<void> change_Have_Order_Status(int HaveOrderStatus) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Account/" + finalData.shipper_account.id).child('orderHaveStatus').set(HaveOrderStatus);
  }

  //Thay đổi shipper cho đơn hàng
  static Future<void> change_Order_Shipper(String orderId) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").child(orderId).child('shipper').set(finalData.shipper_account.toJson());
  }

  //Thay đổi trạng thái cho đơn hàng
  static Future<void> change_Order_Status(String orderId, String status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").child(orderId).child('status').set(status);
  }

  //Sau khi hoàn thành đơn sẽ gọi
  static void listen_To_Order_Have_StatusChange(BuildContext context) {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Account/" + finalData.shipper_account.id).child('orderHaveStatus').onValue.listen((event) {
      // Khi có sự thay đổi trong orderHaveStatus, gọi lại hàm getData
      //Get_Order_Automatic(context);
    });
  }

  //Hàm check xem đã thực sự nhận được đơn chưa
  static Future<bool> check_get_order_success(String order_id) async {
    bool check = false;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").child(order_id).child('shipper').child('id').once().then((DatabaseEvent event) {
      final dynamic orders = event.snapshot.value;
      if (orders != null) {
        if (orders.toString() == finalData.shipper_account.id) {
          check = true;
        }
      }
    }).catchError((error) {
      print("Failed to get order: $error");
      // Handle error here if needed
    });
    return check;
  }

  //Hàm thay đổi số tiền của tài xế
  static Future<void> change_shipper_money() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account/' + finalData.shipper_account.id + '/money').set(finalData.shipper_account.money);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  //hàm đẩy lịch sử chiết khấu
  static Future<void> push_history_data(historyTransactionData his) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(his.id).set(his.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  //Tính toán tiền giảm của voucher
  static double getVoucherSale(dynamic order) {
    double money = 0;
    double vouchermoney = double.parse(order['voucher']['Money'].toString());
    double maxSale = double.parse(order['voucher']['maxSale'].toString());
    double cost = double.parse(order['cost'].toString());
    if(vouchermoney < 100) {
      double mn = cost/(1-(vouchermoney/100))*(vouchermoney/100);
      if (mn <= maxSale) {
        money = mn;
      } else {
        money = maxSale;
      }
    } else {
      money = vouchermoney;
    }

    return money;
  }

  //Hàm tính toán tiền chiết khấu
  static double get_commission(dynamic order) {
    double commissionMoney = 0;
    double cost = double.parse(order['cost'].toString());
    double discount = double.parse(order['costFee']['discount'].toString());
    commissionMoney = (cost + getVoucherSale(order)) * (discount/100);

    return commissionMoney;
  }

  //Hàm tự động nhận đơn
  static Future<void> Get_Order_Automatic1(BuildContext context) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('status').equalTo('A').once().then((DatabaseEvent event) {
      final dynamic orders = event.snapshot.value;
      if (orders != null) {
        orders.forEach((key, value) async {
          if (DateTime.now().difference(finalData.lastOrderTime).inMilliseconds >= 40500) {
            if (finalData.shipper_account.orderHaveStatus == 0) {
              if (get_commission(value) <= finalData.shipper_account.money) {
                print('Đủ tiền nhận đơn');
                finalData.shipper_account.orderHaveStatus = 1;
                await change_Order_Status(value['id'].toString(), 'B');
                print('1.Thay đổi trạng thái đơn thành công');
                await change_Have_Order_Status(1);
                print('2.Thay đổi trạng thái nhận đơn thành công');
                await change_Order_Shipper(value['id'].toString());
                if (await check_get_order_success(value['id'].toString())) {
                  print('3.check thành công, nhận đơn');
                  if (value['resCost'] != null && get_commission(value) + history_controller.get_discount_cost_of_restaurant(foodOrder.fromJson(value).shopList, foodOrder.fromJson(value).productList, foodOrder.fromJson(value).resCost.discount) <= finalData.shipper_account.money) {
                    //Nhận đơn đồ ăn
                    foodOrder order = foodOrder.fromJson(value);
                    if (await check_get_order_success(value['id'].toString())) {
                      print('4. check thành công lần 2');
                      await show_food_order_have_dialog(context, order);
                    } else {
                      print('4. thất bại ở lần check 2');
                      finalData.shipper_account.orderHaveStatus = 0;
                      await change_Have_Order_Status(0);
                    }
                  } else if (value['receiver'] != null) {
                    //Nhận đơn express
                    expressOrder order = expressOrder.fromJson(value);
                    if (await check_get_order_success(value['id'].toString())) {
                      print('4. check thành công lần 2');
                      await show_express_order_have_dialog(context, order);
                    } else {
                      print('4. thất bại ở lần check 2');
                      finalData.shipper_account.orderHaveStatus = 0;
                      await change_Have_Order_Status(0);
                    }
                  } else if (value['motherOrder'] != null) {
                    //Nhận đơn lái xe hộ
                    catchOrderType3 order = catchOrderType3.fromJson(value);
                    if (await check_get_order_success(value['id'].toString())) {
                      print('4. check thành công lần 2');
                      await show_catch_order_type_3_have_dialog(context, order);
                    } else {
                      print('4. thất bại ở lần check 2');
                      finalData.shipper_account.orderHaveStatus = 0;
                      await change_Have_Order_Status(0);
                    }
                  } else if (value['buyLocation'] != null) {
                    // Đơn mua theo yêu cầu
                    requestBuyOrder order = requestBuyOrder.fromJson(value);
                    if (await check_get_order_success(value['id'].toString())) {
                      print('4. check thành công lần 2');
                      await show_buy_request_order_have_dialog(context, order);
                    } else {
                      print('4. thất bại ở lần check 2');
                      finalData.shipper_account.orderHaveStatus = 0;
                      await change_Have_Order_Status(0);
                    }
                  } else {
                    // Đơn chở người
                    CatchOrder order = CatchOrder.fromJson(value);
                    if (await check_get_order_success(value['id'].toString())) {
                      print('4. check thành công lần 2');
                      if (order.locationGet.longitude != 0) {
                        await show_catch_order_have_dialog(context, order);
                      } else {
                        await show_catch_order_type_2_have_dialog(context, order);
                      }
                    } else {
                      print('4. thất bại ở lần check 2');
                      finalData.shipper_account.orderHaveStatus = 0;
                      await change_Have_Order_Status(0);
                    }
                  }
                } else {
                  print('3.check không thành công,không nhận đơn');
                  finalData.shipper_account.orderHaveStatus = 0;
                  await change_Have_Order_Status(0);
                }
              }
            }
          }
        });
      }
    }).catchError((error) {
      print("Failed to get order: $error");
      // Handle error here if needed
    });
  }

}