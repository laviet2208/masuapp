import 'package:masuapp/FINAL/finalClass.dart';

import '../NormalUser/accountLocation.dart';
import '../NormalUser/accountNormal.dart';
import '../Product/Product.dart';
import '../Product/Voucher.dart';
import '../Tool/Time.dart';
import 'Cost.dart';

class foodOrder {
   String id;
   accountLocation locationSet;
   accountLocation locationGet;
   double cost;
   double shipcost;
   Time S1time;
   Time S2time;
   Time S3time;
   Time S4time;
   Time S5time;
   accountNormal owner;
   accountNormal shipper;
   String status;
   Voucher voucher;
   Cost costFee;
   Cost costBiker;
   List<Product> productList;

   foodOrder({
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
     required this.S5time,
     required this.productList,
     required this.shipcost,
     required this.voucher,
     required this.costFee,
     required this.costBiker
   });

   Map<dynamic, dynamic> toJson() => {
     'id' : id,
     'locationSet' : locationSet.toJson(),
     'locationGet' : locationGet.toJson(),
     'cost' : cost,
     'shipcost' : shipcost,
     'S1time' : S1time.toJson(),
     'S2time' : S2time.toJson(),
     'S3time' : S3time.toJson(),
     'S4time' : S4time.toJson(),
     'S5time' : S5time.toJson(),
     'owner' : owner.toJson(),
     'status' : status,
     'productList': productList.map((e) => e.toJson()).toList(),
     'shipper' : shipper.toJson(),
     'voucher' : voucher.toJson(),
     'costFee' : costFee.toJson(),
     'costBiker' : costBiker.toJson()
   };

   void SetDataByAnother(foodOrder thisO) {
     shipper = thisO.shipper;
     locationSet = thisO.locationSet;
     cost = thisO.cost;
     shipcost = thisO.shipcost;
     costBiker = thisO.costBiker;
     costFee = thisO.costFee;
     voucher = thisO.voucher;
     locationGet = thisO.locationGet;
     id = thisO.id;
     owner = thisO.owner;
     status = thisO.status;
     S1time = thisO.S1time;
     S2time = thisO.S2time;
     S3time = thisO.S3time;
     S4time = thisO.S4time;
     S5time = thisO.S5time;
     productList = thisO.productList;
     id = thisO.id;
   }


   factory foodOrder.fromJson(Map<dynamic, dynamic> json) {
     List<Product> product = [];

     if (json["productList"] != null) {
       for (final result in json["productList"]) {
         product.add(Product.fromJson(result));
       }
     }

     accountNormal shipper;

     if (json['shipper'] != null) {
       shipper = accountNormal.fromJson(json['shipper']);
     } else {
       shipper = accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: currentAccount.Area, license: '', WorkStatus: 0);
     }

     return foodOrder(
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
       S5time: Time.fromJson(json['S5time']),
       productList: product,
       shipcost: double.parse(json['shipcost'].toString()),
       shipper: shipper,
       voucher: Voucher.fromJson(json['voucher']),
       costFee: Cost.fromJson(json['costFee']),
       costBiker: Cost.fromJson(json['costBiker']),
     );
   }
}