
import '../otherData/Time.dart';

class Account {
  String phone;
  String id;
  String name;
  int lockStatus;
  String area;
  Time createTime;

  Account({required this.id, required this.createTime, required this.lockStatus, required this.name, required this.area, required this.phone,});

  Map<dynamic, dynamic> toJson() => {
    'phone': phone,
    'id': id,
    'name': name,
    'lockStatus': lockStatus,
    'area': area,
    'createTime': createTime.toJson(),
  };

  factory Account.fromJson(Map<dynamic, dynamic> json) {
    return Account(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      lockStatus: int.parse(json['lockStatus'].toString()),
      name: json['name'].toString(),
      area: json['area'].toString(),
      phone: json['phone'].toString(),
    );
  }



  void changeData(Map<dynamic, dynamic> json) {
    id= json['id'].toString();
    createTime= Time.fromJson(json['createTime']);
    lockStatus= int.parse(json['lockStatus'].toString());
    name= json['name'].toString();
    area= json['area'].toString();
    phone= json['phone'].toString();
  }
}