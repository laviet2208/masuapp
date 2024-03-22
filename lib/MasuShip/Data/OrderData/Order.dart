import '../locationData/Location.dart';
import '../otherData/Tool.dart';
import '../accountData/shipperAccount.dart';
import '../accountData/userAccount.dart';
import '../voucherData/Voucher.dart';

class Order {
  String id;
  Location locationSet;
  Location locationGet;
  double cost;
  Voucher voucher;
  UserAccount owner;
  shipperAccount shipper;
  String status;

  Order({
    required this.id,
    required this.locationSet,
    required this.locationGet,
    required this.cost,
    required this.owner,
    required this.shipper,
    required this.status,
    required this.voucher,
  });

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'locationSet' : locationSet.toJson(),
    'locationGet' : locationGet.toJson(),
    'cost' : cost,
    'owner' : owner.toJson(),
    'status' : status,
    'shipper' : shipper.toJson(),
    'voucher' : voucher.toJson(),
  };

  factory Order.fromJson(Map<dynamic, dynamic> json) {
    shipperAccount shipper;

    if (json['shipper'] != null) {
      shipper = shipperAccount.fromJson(json['shipper']);
    } else {
      shipper = shipperAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0,);
    }

    return Order(
      id: json['id'].toString(),
      locationSet: Location.fromJson(json['locationSet']),
      locationGet: Location.fromJson(json['locationGet']),
      cost: double.parse(json['cost'].toString()),
      owner: UserAccount.fromJson(json['owner']),
      status: json['status'].toString(),
      shipper: shipper,
      voucher: Voucher.fromJson(json['voucher']),
    );
  }
}