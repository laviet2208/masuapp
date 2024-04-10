import 'package:masuapp/MasuShip/Data/OrderData/Order.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';
import 'package:masuapp/MasuShip/Data/costData/Cost.dart';
import 'package:masuapp/MasuShip/Data/costData/restaurantCost.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';

import '../../accountData/shipperAccount.dart';
import '../../accountData/shopData/Product.dart';
import '../../accountData/userAccount.dart';
import '../../locationData/Location.dart';
import '../../voucherData/Voucher.dart';

class foodOrder extends Order {
  List<cartProduct> productList;
  List<ShopAccount> shopList;
  List<Time> timeList;
  Cost costFee;
  restaurantCost resCost;
  String note;
  double weatherFee;
  double pointFee;
  double waitFee;

  foodOrder({
    required String id,
    required Location locationSet,
    required Location locationGet,
    required double cost,
    required UserAccount owner,
    required shipperAccount shipper,
    required String status,
    required Voucher voucher,
    required this.productList,
    required this.shopList,
    required this.timeList,
    required this.costFee,
    required this.note,
    required this.waitFee,
    required this.weatherFee,
    required this.pointFee,
    required this.resCost,
  }) : super(
    id: id,
    locationSet: locationSet,
    locationGet: locationGet,
    cost: cost,
    owner: owner,
    shipper: shipper,
    status: status,
    voucher: voucher,
  );

  @override
  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> superJson = super.toJson();
    superJson['costFee'] = costFee.toJson();
    superJson['note'] = note;
    superJson['weatherFee'] = weatherFee;
    superJson['pointFee'] = pointFee;
    superJson['waitFee'] = waitFee;
    superJson['productList'] = productList.map((e) => e.toJson()).toList();
    superJson['shopList'] = shopList.map((e) => e.toJson()).toList();
    superJson['timeList'] = timeList.map((e) => e.toJson()).toList();
    superJson['resCost'] = resCost.toJson();
    return superJson;
  }

  factory foodOrder.fromJson(Map<dynamic, dynamic> json) {
    Order order = Order.fromJson(json);

    List<cartProduct> products = [];
    List<ShopAccount> shops = [];
    List<Time> times = [];

    if (json["productList"] != null) {
      for (final result in json["productList"]) {
        products.add(cartProduct.fromJson(result));
      }
    }

    if (json["timeList"] != null) {
      for (final result in json["timeList"]) {
        times.add(Time.fromJson(result));
      }
    }

    if (json["shopList"] != null) {
      for (final result in json["shopList"]) {
        shops.add(ShopAccount.fromJson(result));
      }
    }

    return foodOrder(
      id: order.id,
      locationSet: order.locationSet,
      locationGet: order.locationGet,
      cost: order.cost,
      owner: order.owner,
      shipper: order.shipper,
      status: order.status,
      voucher: order.voucher,
      productList: products,
      shopList: shops,
      timeList: times,
      costFee: Cost.fromJson(json['costFee']),
      note: json['note'].toString(),
      waitFee: double.parse(json['waitFee'].toString()),
      weatherFee: double.parse(json['weatherFee'].toString()),
      pointFee: double.parse(json['pointFee'].toString()),
      resCost: restaurantCost.fromJson(json['resCost']),
    );
  }
}