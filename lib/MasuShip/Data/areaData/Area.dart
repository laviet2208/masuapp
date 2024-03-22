class Area {
  String id;// id khu vực
  String name;// tên khu vực
  int status;// 0 đang mở
  double money;

  Area({required this.id, required this.name,required this.money, required this.status});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'name': name,
    'money' : money,
    'status' : status,
  };

  factory Area.fromJson(Map<dynamic, dynamic> json) {
    return Area(
        id: json['id'].toString(),
        name: json['name'].toString(),
        money: double.parse(json['money'].toString()),
        status: int.parse(json['status'].toString())
    );
  }
}