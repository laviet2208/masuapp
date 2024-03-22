import '../Tool/Time.dart';
import 'Useruse.dart';

class Voucher {
  String id;
  String tenchuongtrinh;
  double totalmoney;
  double mincost;
  double maxSale;
  String LocationId;
  Time startTime;
  Time endTime;
  int useCount;
  int maxCount;

  int type; //0: giảm theo tiền cứng , 1: giảm theo phần trăm
  String Otype; //1: giảm cho tất cả loại đơn , 2 : giảm cho nhà hàng

  int perCustom;
  List<Useruse> CustomList = [];


  Voucher({required this.id, required this.totalmoney,required this.mincost,required this.startTime,required this.endTime,required this.useCount,required this.maxCount, required this.tenchuongtrinh, required this.LocationId, required this.type, required this.Otype, required this.perCustom, required this.CustomList, required this.maxSale});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'totalmoney' : totalmoney,
    'mincost' : mincost,
    'startTime' : startTime.toJson(),
    'endTime' : endTime.toJson(),
    'useCount' : useCount,
    'maxCount' : maxCount,
    'tenchuongtrinh' : tenchuongtrinh,
    'LocationId' : LocationId,
    'type' : type,
    'Otype' : Otype,
    'perCustom' : perCustom,
    'CustomList' : CustomList.map((e) => e.toJson()).toList(),
    'maxSale' : maxSale
  };

  factory Voucher.fromJson(Map<dynamic, dynamic> json) {
    List<Useruse> userList = [];

    if (json["CustomList"] != null) {
      for (final result in json["CustomList"]) {
        userList.add(Useruse.fromJson(result));
      }
    }

    return Voucher(
      id: json['id'].toString(),
      totalmoney: double.parse(json['totalmoney'].toString()),
      mincost: double.parse(json['mincost'].toString()),
      startTime: Time.fromJson(json['startTime']),
      endTime: Time.fromJson(json['endTime']),
      useCount: int.parse(json['useCount'].toString()),
      maxCount: int.parse(json['maxCount'].toString()),
      tenchuongtrinh: json['tenchuongtrinh'].toString(),
      LocationId: json['LocationId'].toString(),
      type: int.parse(json['type'].toString()),
      Otype: json['Otype'].toString(),
      perCustom: int.parse(json['perCustom'].toString()),
      CustomList: userList,
      maxSale: double.parse(json['maxSale'].toString()),
    );
  }

  void Setdata(Voucher vouchers) {
    id= vouchers.id;
    totalmoney= vouchers.totalmoney;
    mincost = vouchers.mincost;
    startTime = vouchers.startTime;
    endTime = vouchers.endTime;
    useCount = vouchers.useCount;
    maxCount = vouchers.maxCount;
    tenchuongtrinh = vouchers.tenchuongtrinh;
    LocationId = vouchers.LocationId;
    type = vouchers.type;
    Otype = vouchers.Otype;
    perCustom = vouchers.perCustom;
    CustomList = vouchers.CustomList;
    maxSale = vouchers.maxSale;
  }

  void changeToDefault() {
    id = '';
    totalmoney = 0;
    mincost = 0;
    startTime = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
    endTime = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
    useCount = 0;
    maxCount = 0;
    tenchuongtrinh = '';
    LocationId = '';
    type = 0;
    Otype = '0';
    perCustom = 0;
    CustomList = [];
    maxSale = 0;
  }
}