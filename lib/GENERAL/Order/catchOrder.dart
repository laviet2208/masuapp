import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Product/Voucher.dart';

import '../NormalUser/accountLocation.dart';
import '../NormalUser/accountNormal.dart';
import '../Tool/Time.dart';
import 'Cost.dart';

class catchOrder {
  String id;
  accountLocation locationSet;
  accountLocation locationGet;
  int type;
  double cost;
  Voucher voucher;
  Time S1time;
  Time S2time;
  Time S3time;
  Time S4time;
  accountNormal owner;
  accountNormal shipper;
  Cost costFee;
  String status;

  catchOrder({
    required this.id,
    required this.locationSet,
    required this.locationGet,
    required this.cost,
    required this.owner,
    required this.shipper,
    required this.status,
    required this.S1time,
    required this.S2time,
    required this.S3time,
    required this.S4time,
    required this.type,
    required this.voucher,
    required this.costFee
  });

  void ChangeDataByAnother(catchOrder thisO) {
    shipper = thisO.shipper;
    locationSet = thisO.locationSet;
    cost = thisO.cost;
    locationGet = thisO.locationGet;
    id = thisO.id;
    costFee = thisO.costFee;
    voucher = thisO.voucher;
    owner = thisO.owner;
    status = thisO.status;
    S1time = thisO.S1time;
    S2time = thisO.S2time;
    S3time = thisO.S3time;
    S4time = thisO.S4time;
    type = thisO.type;
  }

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'locationSet' : locationSet.toJson(),
    'locationGet' : locationGet.toJson(),
    'cost' : cost,
    'S1time' : S1time.toJson(),
    'S2time' : S2time.toJson(),
    'S3time' : S3time.toJson(),
    'S4time' : S4time.toJson(),
    'owner' : owner.toJson(),
    'status' : status,
    'shipper' : shipper.toJson(),
    'type' : type,
    'voucher' : voucher.toJson(),
    'costFee' : costFee.toJson()
  };

  void setDataFromJson(Map<dynamic, dynamic> json) {
    accountNormal shipper;

    if (json['shipper'] != null) {
      shipper = accountNormal.fromJson(json['shipper']);
    } else {
      shipper = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: currentAccount.Area, license: '', WorkStatus: 0);
    }

    id = json['id'].toString();
    locationSet = accountLocation.fromJson(json['locationSet']);
    locationGet = accountLocation.fromJson(json['locationGet']);
    cost = double.parse(json['cost'].toString());
    owner = accountNormal.fromJson(json['owner']);
    status = json['status'].toString();
    S1time = Time.fromJson(json['S1time']);
    S2time = Time.fromJson(json['S2time']);
    S3time = Time.fromJson(json['S3time']);
    S4time = Time.fromJson(json['S4time']);
    shipper = shipper;
    
    voucher = Voucher.fromJson(json['voucher']);
    costFee = Cost.fromJson(json['costFee']);
  }

  factory catchOrder.fromJson(Map<dynamic, dynamic> json) {
    accountNormal shipper;

    if (json['shipper'] != null) {
      shipper = accountNormal.fromJson(json['shipper']);
    } else {
      shipper = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: currentAccount.Area, license: '', WorkStatus: 0);
    }

    return catchOrder(
        id: json['id'].toString(),
        locationSet: accountLocation.fromJson(json['locationSet']),
        locationGet: accountLocation.fromJson(json['locationGet']),
        cost: double.parse(json['cost'].toString()),
        owner: accountNormal.fromJson(json['owner']),
        status: json['status'].toString(),
        S1time: Time.fromJson(json['S1time']),
        S2time: Time.fromJson(json['S2time']),
        S3time: Time.fromJson(json['S3time']),
        S4time: Time.fromJson(json['S4time']),
        shipper: shipper,
        type: int.parse(json['type'].toString()),
        voucher: Voucher.fromJson(json['voucher']),
        costFee: Cost.fromJson(json['costFee']),
    );
  }
}