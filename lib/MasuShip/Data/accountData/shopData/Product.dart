import '../../otherData/Time.dart';

class Product {
  String id;
  String name;
  String describle;
  int status; //0: đang đóng, 1: đang mở
  Time createTime;
  double cost;
  String owner;

  Product({required this.id, required this.cost, required this.name, required this.describle, required this.owner, required this.status, required this.createTime});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'name': name,
    'describle': describle,
    'cost': cost,
    'owner': owner,
    'status': status,
    'createTime': createTime.toJson(),
  };

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'].toString(),
      describle: json['describle'].toString(),
      owner: json['owner'].toString(),
      status: int.parse(json['status'].toString()),
      cost: double.parse(json['cost'].toString()),
      createTime: Time.fromJson(json['createTime']),
    );
  }
}