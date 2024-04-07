import 'package:flutter/material.dart';
import '../accountData/shopData/shopAccount.dart';
import '../otherData/Time.dart';

class restaurantAdsData {
  String id;
  String area;
  int status; // 0: ko khả dụng, 1: đang khả dụng
  int direction; // 1: bung ra khi vào app, 2: quảng cáo ở top của trang chính, 3: quảng cáo ở top phần nhà hàng
  Time pushTime; // thời gian đẩy quảng cáo lần cuối
  Time endTime; // thời gian dừng lần cuối
  Time editTime; // thời gian chỉnh sửa lần cuối
  ShopAccount account;

  restaurantAdsData({required this.id, required this.account, required this.area, required this.status, required this.direction, required this.editTime, required this.pushTime, required this.endTime});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'area': area,
    'account': account.toJson(),
    'status' : status,
    'direction' : direction,
    'pushTime' : pushTime.toJson(),
    'editTime' : editTime.toJson(),
    'endTime' : endTime.toJson(),
  };

  factory restaurantAdsData.fromJson(Map<dynamic, dynamic> json) {
    return restaurantAdsData(
      id: json['id'].toString(),
      area: json['area'].toString(),
      account: ShopAccount.fromJson(json['account']),
      status: int.parse(json['status'].toString()),
      direction: int.parse(json['direction'].toString()),
      editTime: Time.fromJson(json['editTime']),
      pushTime: Time.fromJson(json['pushTime']),
      endTime: Time.fromJson(json['endTime']),
    );
  }
}
