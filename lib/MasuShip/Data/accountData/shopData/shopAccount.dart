import '../../locationData/Location.dart';
import '../../otherData/Time.dart';
import '../Account.dart';

class ShopAccount extends Account {
  String password;
  Time closeTime;
  Time openTime;
  int openStatus;// 0 : đang đóng cửa, 1 : đang mở cửa
  int type;
  int discount_type;// 1 : nhà hàng đối tác ,2 : nhà hàng tự thêm
  double money;
  String area;
  Location location;
  List<String> listDirectory;

  ShopAccount({
    required String id,
    required Time createTime,
    required int lockStatus,
    required String name,
    required String phone,
    required this.money,
    required this.type,
    required this.password,
    required this.closeTime,
    required this.openTime,
    required this.openStatus,
    required this.discount_type,
    required this.area,
    required this.location,
    required this.listDirectory,
  }) : super(
    id: id,
    createTime: createTime,
    lockStatus: lockStatus,
    name: name,
    area: area,
    phone: phone,
  );

  // Ghi đè phương thức toJson() để bổ sung thông tin của shopAccount
  @override
  Map<dynamic, dynamic> toJson() {
    Map superJson = super.toJson();
    superJson['password'] = password;
    superJson['closeTime'] = closeTime.toJson();
    superJson['openTime'] = openTime.toJson();
    superJson['openStatus'] = openStatus;
    superJson['type'] = type;
    superJson['area'] = area;
    superJson['location'] = location.toJson();
    superJson['listDirectory'] = listDirectory;
    superJson['discount_type'] = discount_type;
    superJson['money'] = money;
    return superJson;
  }

  factory ShopAccount.fromJson(Map<dynamic, dynamic> json) {
    // Gọi phương thức fromJson() của lớp Account để tạo đối tượng Account
    Account account = Account.fromJson(json);

    List<String> directoryList = [];

    if (json["listDirectory"] != null) {
      for (final result in json["listDirectory"]) {
        directoryList.add(result.toString());
      }
    }

    return ShopAccount(
      id: account.id,
      createTime: account.createTime,
      lockStatus: account.lockStatus,
      name: account.name,
      area: account.area,
      phone: account.phone,
      password: json['password'].toString(),
      closeTime: Time.fromJson(json['closeTime']),
      openTime: Time.fromJson(json['openTime']),
      openStatus: int.parse(json['openStatus'].toString()),
      type: int.parse(json['type'].toString()),
      location: Location.fromJson(json['location']),
      discount_type: int.parse(json['discount_type'].toString()),
      listDirectory: directoryList,
      money: double.parse(json['money'].toString()),
    );
  }
}