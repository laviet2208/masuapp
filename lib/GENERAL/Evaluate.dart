import 'Tool/Time.dart';

class Evaluate {
  String id;
  String Area;
  int type; // 1 : Nhà hàng , 2 :Tài xế
  int star;
  String content;
  String owner; // Người đánh giá
  String receiver; // Người nhận đánh giá
  String orderCode;
  Time creatTime;

  Evaluate({
    required this.id,
    required this.Area,
    required this.type,
    required this.owner,
    required this.receiver,
    required this.creatTime,
    required this.orderCode,
    required this.star,
    required this.content
  });

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'Area' : Area,
    'owner' : owner,
    'type' : type,
    'receiver' : receiver,
    'creatTime' : creatTime.toJson(),
    'orderCode' : orderCode,
    'star' : star,
    'content' : content
  };

  void changeDataFromJson(Map<dynamic, dynamic> json) {
    id = json['id'].toString();
    Area = json['Area'].toString();
    
    owner = json['owner'].toString();
    receiver = json['receiver'].toString();
    orderCode = json['orderCode'].toString();
    creatTime = Time.fromJson(json['creatTime']);
    star = int.parse(json['star'].toString());
    content = json['content'].toString();
  }

  factory Evaluate.fromJson(Map<dynamic, dynamic> json) {
    return Evaluate(
        id: json['id'].toString(),
        Area: json['Area'].toString(),
        type: int.parse(json['type'].toString()),
        owner: json['owner'].toString(),
        receiver: json['receiver'].toString(),
        creatTime: Time.fromJson(json['creatTime']),
        orderCode: json['orderCode'].toString(),
        star:int.parse(json['star'].toString()),
        content: json['content'].toString()
    );
  }
}