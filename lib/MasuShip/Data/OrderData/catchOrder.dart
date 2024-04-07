import '../OrderData/Order.dart';
import '../accountData/shipperAccount.dart';
import '../locationData/Location.dart';
import '../otherData/Time.dart';
import '../accountData/userAccount.dart';
import '../voucherData/Voucher.dart';
import '../costData/Cost.dart';

class CatchOrder extends Order {
  Time S1time;
  Time S2time;
  Time S3time;
  Time S4time;
  double subFee;
  Cost costFee;

  CatchOrder({
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
    required this.costFee,
    required this.subFee,
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

  // Ghi đè phương thức toJson() để bổ sung thông tin của CatchOrder
  @override
  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> superJson = super.toJson();
    superJson['S1time'] = S1time.toJson();
    superJson['S2time'] = S2time.toJson();
    superJson['S3time'] = S3time.toJson();
    superJson['S4time'] = S4time.toJson();
    superJson['costFee'] = costFee.toJson();
    superJson['subFee'] = subFee;
    return superJson;
  }

  // Triển khai phương thức fromJson()
  factory CatchOrder.fromJson(Map<dynamic, dynamic> json) {
    Order order = Order.fromJson(json);

    return CatchOrder(
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
      subFee: double.parse(json['subFee'].toString()),
    );
  }
}