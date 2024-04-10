import '../../accountData/shipperAccount.dart';
import '../../accountData/shopData/shopAccount.dart';
import '../../accountData/userAccount.dart';
import '../../locationData/Location.dart';
import '../../otherData/Time.dart';
import '../../voucherData/Voucher.dart';
import '../../costData/Cost.dart';
import '../Order.dart';
import 'requestProduct.dart';

class requestBuyOrder extends Order {
  Time S1time;
  Time S2time;
  Time S3time;
  Time S4time;
  List<Location> buyLocation;
  List<requestProduct> productList;
  Cost costFee;

  requestBuyOrder({
    required String id,
    required Location locationSet,
    required Location locationGet,
    required double cost,
    required UserAccount owner,
    required shipperAccount shipper,
    required String status,
    required Voucher voucher,
    required this.S1time,
    required this.S2time,
    required this.S3time,
    required this.S4time,
    required this.productList,
    required this.costFee,
    required this.buyLocation,
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
    superJson['S1time'] = S1time.toJson();
    superJson['S2time'] = S2time.toJson();
    superJson['S3time'] = S3time.toJson();
    superJson['S4time'] = S4time.toJson();
    superJson['productList'] = productList.map((e) => e.toJson()).toList();
    superJson['costFee'] = costFee.toJson();
    superJson['buyLocation'] = buyLocation.map((e) => e.toJson()).toList();
    return superJson;
  }

  factory requestBuyOrder.fromJson(Map<dynamic, dynamic> json) {
    Order order = Order.fromJson(json);

    List<requestProduct> products = [];
    List<Location> locations = [];

    if (json["productList"] != null) {
      for (final result in json["productList"]) {
        products.add(requestProduct.fromJson(result));
      }
    }

    if (json["buyLocation"] != null) {
      for (final result in json["buyLocation"]) {
        locations.add(Location.fromJson(result));
      }
    }

    return requestBuyOrder(
      id: order.id,
      locationSet: order.locationSet,
      locationGet: order.locationGet,
      cost: order.cost,
      owner: order.owner,
      shipper: order.shipper,
      status: order.status,
      voucher: order.voucher,
      S1time: Time.fromJson(json['S1time']),
      S2time: Time.fromJson(json['S2time']),
      S3time: Time.fromJson(json['S3time']),
      S4time: Time.fromJson(json['S4time']),
      costFee: Cost.fromJson(json['costFee']),
      productList: products,
      buyLocation: locations
    );
  }
}