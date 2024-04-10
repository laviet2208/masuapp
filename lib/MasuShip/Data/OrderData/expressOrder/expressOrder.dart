import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/personInfo.dart';
import '../../accountData/shipperAccount.dart';
import '../../accountData/userAccount.dart';
import '../../costData/Cost.dart';
import '../../locationData/Location.dart';
import '../../otherData/Time.dart';
import '../../voucherData/Voucher.dart';
import '../Order.dart';
import '../catchOrder.dart';

class expressOrder extends CatchOrder {
  personInfo sender;
  personInfo receiver;
  String item; // tên hàng hóa
  int weightType;
  double codMoney;
  String note;

  expressOrder ({
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
    required this.codMoney,
    required this.sender,
    required this.receiver,
    required this.item,
    required this.weightType,
    required this.note,
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
    costFee: costFee,
    subFee: subFee
  );

  @override
  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> superJson = super.toJson();
    superJson['sender'] = sender.toJson();
    superJson['receiver'] = receiver.toJson();
    superJson['item'] = item;
    superJson['subFee'] = subFee;
    superJson['weightType'] = weightType;
    superJson['codMoney'] = codMoney;
    superJson['note'] = note;
    return superJson;
  }

  factory expressOrder.fromJson(Map<dynamic, dynamic> json) {
    Order order = Order.fromJson(json);

    return expressOrder(
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
      codMoney: double.parse(json['codMoney'].toString()),
      sender: personInfo.fromJson(json['sender']),
      receiver: personInfo.fromJson(json['receiver']),
      item: json['item'].toString(),
      weightType: int.parse(json['weightType'].toString()),
      note: json['note'].toString(),
    );
  }
}

