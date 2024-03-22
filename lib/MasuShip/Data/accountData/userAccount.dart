import 'Account.dart';
import '../locationData/Location.dart';
import '../otherData/Time.dart';
import '../voucherData/Voucher.dart';

class UserAccount extends Account {
  Location location;

  UserAccount({
    required String id,
    required Time createTime,
    required int lockStatus,
    required String name,
    required String area,
    required String phone,
    required this.location,
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
    return superJson;
  }

  factory UserAccount.fromJson(Map<dynamic, dynamic> json) {
    return UserAccount(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      lockStatus: int.parse(json['lockStatus'].toString()),
      name: json['name'].toString(),
      area: json['area'].toString(),
      phone: json['phone'].toString(),
      location: Location.fromJson(json['location']),
    );
  }
}