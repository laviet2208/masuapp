import 'package:masuapp/MasuShip/Data/OrderData/Order.dart';

import '../../accountData/shipperAccount.dart';
import '../../accountData/userAccount.dart';
import '../../locationData/Location.dart';
import '../../otherData/Time.dart';
import '../../voucherData/Voucher.dart';
import 'catchOrderType3.dart';

class motherOrder extends Order {
  List<String> orderList;
  Time createTime;

  motherOrder({
    required String id,
    required Location locationSet,
    required Location locationGet,
    required double cost,
    required UserAccount owner,
    required shipperAccount shipper,
    required String status,
    required Voucher voucher,
    required this.createTime,
    required this.orderList,
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
    superJson['orderList'] = orderList.map((e) => e).toList();
    superJson['createTime'] = createTime.toJson();
    return superJson;
  }

  factory motherOrder.fromJson(Map<dynamic, dynamic> json) {
    Order order = Order.fromJson(json);

    List<String> products = [];

    if (json["orderList"] != null) {
      for (final result in json["orderList"]) {
        products.add(result.toString());
      }
    }

    return motherOrder(
      id: order.id,
      locationSet: order.locationSet,
      locationGet: order.locationGet,
      cost: order.cost,
      owner: order.owner,
      shipper: order.shipper,
      status: order.status,
      voucher: order.voucher,
      orderList: products,
      createTime: Time.fromJson(json['createTime']),
    );
  }
}