import 'package:masuapp/MasuShip/Data/otherData/Time.dart';

class timeKeeping {
  String reason;
  int reasonType;
  int shift;
  Time dayOff;

  timeKeeping({required this.reasonType, required this.shift, required this.reason, required this.dayOff});

  Map<dynamic, dynamic> toJson() => {
    'reason': reason,
    'reasonType': reasonType,
    'shift': shift,
    'dayOff': dayOff.toJson(),
  };

  factory timeKeeping.fromJson(Map<dynamic, dynamic> json) {
    return timeKeeping(
      reason: json['reason'].toString(),
      reasonType: int.parse(json['reasonType'].toString()),
      shift: int.parse(json['shift'].toString()),
      dayOff: Time.fromJson(json['dayOff']),
    );
  }
}