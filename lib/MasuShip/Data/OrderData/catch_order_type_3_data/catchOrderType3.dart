import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/costData/Cost.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';

import '../../accountData/shipperAccount.dart';
import '../../accountData/userAccount.dart';
import '../../locationData/Location.dart';
import '../../voucherData/Voucher.dart';

class catchOrderType3 extends CatchOrder {
  int type; //1: chở người, 2: lái xe
  String motherOrder;

  catchOrderType3({
    required String id,
    required Location locationSet,
    required Location locationGet,
    required double cost,
    required UserAccount owner,
    required shipperAccount shipper,
    required String status,
    required Voucher voucher,
    required Time S1time,
    required Time S2time,
    required Time S3time,
    required Time S4time,
    required Cost costFee,
    required double subFee,
    required this.type,
    required this.motherOrder,
  }) : super(
    id: id,
    locationSet: locationSet,
    locationGet: locationGet,
    cost: cost,
    owner: owner,
    shipper: shipper,
    status: status,
    voucher: voucher,
    S1time: S1time,
    S2time: S2time,
    S3time: S3time,
    S4time: S4time,
    subFee: subFee,
    costFee: costFee
  );

  // Ghi đè phương thức toJson() để bổ sung thông tin của CatchOrder
  @override
  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> superJson = super.toJson();
    superJson['type'] = type;
    superJson['motherOrder'] = motherOrder;
    return superJson;
  }

  // Triển khai phương thức fromJson()
  factory catchOrderType3.fromJson(Map<dynamic, dynamic> json) {
    CatchOrder order = CatchOrder.fromJson(json);

    return catchOrderType3(
      id: order.id,
      locationSet: order.locationSet,
      locationGet: order.locationGet,
      cost: order.cost,
      owner: order.owner,
      shipper: order.shipper,
      status: order.status,
      voucher: order.voucher,
      S1time: order.S1time,
      S2time: order.S2time,
      S3time: order.S3time,
      S4time: order.S4time,
      costFee: order.costFee,
      subFee: order.subFee,
      type: int.parse(json['type'].toString()),
      motherOrder: json['motherOrder'].toString(),
    );
  }
}