import '../Tool/Time.dart';

class accountShop {
  String phoneNum;
  String id;
  String name;
  int status;
  int isTop;
  int Type;
  Time createTime;
  String location;
  String avatarID;
  String password;
  Time closeTime;
  Time openTime;
  int OpenStatus; // 0 : đang đóng cửa ; 1 : đang mở cửa
  String Area;
  List<String> ListDirectory;


  accountShop({required this.openTime,required this.OpenStatus,required this.ListDirectory ,required this.closeTime,required this.phoneNum, required this.location, required this.name, required this.id, required this.status, required this.avatarID, required this.createTime, required this.password, required this.isTop, required this.Type, required this.Area});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'location': location,
    'id' : id,
    'name' : name,
    'status' : status,
    'createTime' : createTime.toJson(),
    'avatarID' : avatarID,
    'password' : password,
    'closeTime' : closeTime.toJson(),
    'openTime' : openTime.toJson(),
    'isTop' : isTop,
    'Type' : Type,
    'ListDirectory' : ListDirectory.map((e) => e).toList(),
    'Area' : Area,
    'OpenStatus' : OpenStatus
  };

  factory accountShop.fromJson(Map<dynamic, dynamic> json) {
    List<String> idList = [];

    if (json["ListDirectory"] != null) {
      for (final result in json["ListDirectory"]) {
        idList.add(result.toString());
      }
    }

    return accountShop(
      phoneNum: json['phoneNum'].toString(),
      location: json['location'].toString(),
      name: json['name'].toString(),
      id: json['id'].toString(),
      status: int.parse(json['status'].toString()),
      avatarID: json['avatarID'].toString(),
      createTime: Time.fromJson(json['createTime']),
      password: json['password'].toString(),
      closeTime: Time.fromJson(json['closeTime']),
      openTime: Time.fromJson(json['openTime']),
      isTop: int.parse(json['isTop'].toString()),
      Type: int.parse(json['Type'].toString()),
      ListDirectory: idList,
      Area: json['Area'].toString(),
      OpenStatus: int.parse(json['OpenStatus'].toString()),
    );
  }
}