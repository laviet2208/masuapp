import 'package:masuapp/MasuShip/Data/accountData/shipperAccount.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';

class timeKeeping {
  String id;
  shipperAccount owner;
  String reason;
  int reasonType;
  int shift;
  int status; // 0 : chờ duyệt, 1 : đã duyệt, 2 : từ chối duyệt
  Time dayOff;

  timeKeeping({required this.id,required this.reasonType, required this.shift, required this.reason, required this.dayOff, required this.owner, required this.status});

  Map<dynamic, dynamic> toJson() => {
    'reason': reason,
    'id': id,
    'reasonType': reasonType,
    'shift': shift,
    'dayOff': dayOff.toJson(),
    'owner': owner.toJson(),
    'status': status,
  };

  factory timeKeeping.fromJson(Map<dynamic, dynamic> json) {
    return timeKeeping(
      reason: json['reason'].toString(),
      id: json['id'].toString(),
      reasonType: int.parse(json['reasonType'].toString()),
      shift: int.parse(json['shift'].toString()),
      dayOff: Time.fromJson(json['dayOff']),
      owner: shipperAccount.fromJson(json['owner']),
      status: int.parse(json['status'].toString()),
    );
  }
}