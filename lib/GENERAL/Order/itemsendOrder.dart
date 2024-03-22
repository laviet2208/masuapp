import 'package:masuapp/FINAL/finalClass.dart';

import '../NormalUser/accountLocation.dart';
import '../NormalUser/accountNormal.dart';
import '../Product/Voucher.dart';
import '../Tool/Time.dart';
import 'Cost.dart';
import 'Receiver.dart';
import 'item_details.dart';

class itemsendOrder {
  String id;
  accountLocation locationset;
  double cost;
  Time S1time;
  Time S2time;
  Time S3time;
  Time S4time;
  accountNormal owner;
  Receiver receiver;
  item_details itemdetails;
  accountNormal shipper;
  String status;
  Cost costFee;
  Voucher voucher;

  itemsendOrder({
    required this.id,
    required this.cost,
    required this.owner,
    required this.shipper,
    required this.status,
    required this.S1time,
    required this.S2time,
    required this.S3time,
    required this.S4time,
    required this.locationset,
    required this.receiver,
    required this.itemdetails,
    required this.voucher,
    required this.costFee
  });

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'locationset' : locationset.toJson(),
    'cost' : cost,
    'S1time' : S1time.toJson(),
    'S2time' : S2time.toJson(),
    'S3time' : S3time.toJson(),
    'S4time' : S4time.toJson(),
    'owner' : owner.toJson(),
    'receiver' : receiver.toJson(),
    'itemdetails' : itemdetails.toJson(),
    'shipper' : shipper.toJson(),
    'status' : status,
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
    locationset = accountLocation.fromJson(json['locationset']);
    cost = double.parse(json['cost'].toString());
    owner = accountNormal.fromJson(json['owner']);
    status = json['status'].toString();
    S1time = Time.fromJson(json['S1time']);
    S2time = Time.fromJson(json['S2time']);
    S3time = Time.fromJson(json['S3time']);
    S4time = Time.fromJson(json['S4time']);
    receiver = Receiver.fromJson(json['receiver']);
    itemdetails = item_details.fromJson(json['itemdetails']);
    voucher = Voucher.fromJson(json['voucher']);
    costFee = Cost.fromJson(json['costFee']);
  }

  factory itemsendOrder.fromJson(Map<dynamic, dynamic> json) {
    accountNormal shipper;

    if (json['shipper'] != null) {
      shipper = accountNormal.fromJson(json['shipper']);
    } else {
      shipper = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: currentAccount.Area, license: '', WorkStatus: 0);
    }

    return itemsendOrder(
      id: json['id'].toString(),
      cost: double.parse(json['cost'].toString()),
      owner: accountNormal.fromJson(json['owner']),
      status: json['status'].toString(),
      S1time: Time.fromJson(json['S1time']),
      S2time: Time.fromJson(json['S2time']),
      S3time: Time.fromJson(json['S3time']),
      S4time: Time.fromJson(json['S4time']),
      shipper: shipper,
      locationset: accountLocation.fromJson(json['locationset']),
      receiver: Receiver.fromJson(json['receiver']),
      itemdetails: item_details.fromJson(json['itemdetails']),
      voucher: Voucher.fromJson(json['voucher']),
      costFee: Cost.fromJson(json['costFee']),
    );
  }
}