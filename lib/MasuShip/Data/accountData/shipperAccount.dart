import 'Account.dart';

import '../locationData/Location.dart';
import '../otherData/Time.dart';

class shipperAccount extends Account {
  Location location; //Vị trí hiện tại
  int onlineStatus; //Trạng thái check-in,chech-out
  int orderHaveStatus; //0: chưa có đơn,1: đang có đơn
  double money;
  double debt;
  String license;

  shipperAccount({
    required String id,
    required Time createTime,
    required int lockStatus,
    required String name,
    required String area,
    required String phone,
    required this.location,
    required this.onlineStatus,
    required this.money,
    required this.license,
    required this.orderHaveStatus,
    required this.debt,
  }) : super(
    id: id,
    createTime: createTime,
    lockStatus: lockStatus,
    name: name,
    area: area,
    phone: phone,
  );

  Map<dynamic, dynamic> toJson() {
    Map superJson = super.toJson();
    superJson['location'] = location.toJson();
    superJson['license'] = license;
    superJson['onlineStatus'] = onlineStatus;
    superJson['orderHaveStatus'] = orderHaveStatus;
    superJson['money'] = money;
    superJson['debt'] = debt;
    return superJson;
  }

  factory shipperAccount.fromJson(Map<dynamic, dynamic> json) {
    return shipperAccount(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      lockStatus: int.parse(json['lockStatus'].toString()),
      name: json['name'].toString(),
      area: json['area'].toString(),
      phone: json['phone'].toString(),
      location: Location.fromJson(json['location']),
      onlineStatus: int.parse(json['onlineStatus'].toString()),
      money: double.parse(json['money'].toString()),
      license: json['license'].toString(),
      orderHaveStatus: int.parse(json['orderHaveStatus'].toString()),
      debt: double.parse(json['debt'].toString()),
    );
  }

  void changeData(Map<dynamic, dynamic> json) {
    id = json['id'].toString();
    createTime = Time.fromJson(json['createTime']);
    lockStatus = int.parse(json['lockStatus'].toString());
    name = json['name'].toString();
    area = json['area'].toString();
    phone = json['phone'].toString();
    location  = Location.fromJson(json['location']);
    onlineStatus  = int.parse(json['onlineStatus'].toString());
    money = double.parse(json['money'].toString());
    license = json['license'].toString();
    debt = double.parse(json['debt'].toString());
    orderHaveStatus = int.parse(json['orderHaveStatus'].toString());
  }
}