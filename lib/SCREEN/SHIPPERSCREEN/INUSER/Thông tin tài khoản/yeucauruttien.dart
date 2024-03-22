import 'package:masuapp/GENERAL/NormalUser/accountNormal.dart';

class withdrawRequest {
  String id;
  accountNormal owner;
  String chutk;
  String nganhang;
  String stk;
  double sotien;

  withdrawRequest({
    required this.id,
    required this.nganhang,
    required this.chutk,
    required this.sotien,
    required this.stk,
    required this.owner
  });

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'nganhang' : nganhang,
    'chutk' : chutk,
    'sotien' : sotien,
    'stk' : stk,
    'owner' : owner.toJson(),
  };

  factory withdrawRequest.fromJson(Map<dynamic, dynamic> json) {
    return withdrawRequest(
      id: json['id'].toString(),
      nganhang: json['nganhang'].toString(),
      chutk: json['chutk'].toString(),
      sotien: double.parse(json['sotien'].toString()),
      stk: json['stk'].toString(),
      owner: accountNormal.fromJson(json['owner']),
    );
  }


}