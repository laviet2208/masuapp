import 'package:flutter/material.dart';
import '../accountData/shopData/shopAccount.dart';

class restaurantAdsData {
  String id;
  String area;
  int status; // 0: ko khả dụng, 1: đang khả dụng
  int direction; // 1: bung ra khi vào app, 2: quảng cáo ở top của trang chính, 3: quảng cáo ở top phần nhà hàng
  ShopAccount account;

  restaurantAdsData({required this.id, required this.account, required this.area, required this.status, required this.direction});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'area': area,
    'account': account.toJson(),
    'status' : status,
    'direction' : direction,
  };

  factory restaurantAdsData.fromJson(Map<dynamic, dynamic> json) {
    return restaurantAdsData(
      id: json['id'].toString(),
      area: json['area'].toString(),
      account: ShopAccount.fromJson(json['account']),
      status: int.parse(json['status'].toString()),
      direction: int.parse(json['direction'].toString())
    );
  }
}
