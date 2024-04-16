import '../otherData/Time.dart';

class historyTransactionData {
  String id;
  String senderId;
  String receiverId;
  String area;
  String content;
  double money;
  Time transactionTime;
  int type;
  // 1 : nạp tiền cho ship , 2 : rút tiền cho ship , 3 : nạp tiền khu vực ,
  // 4 : trừ tiền khu vực , 5 : Chiết khấu , 6 : Hoàn chiết khấu , 7 : Cộng tiền khuyến mãi , 8 : hoàn chiết khấu nhà hàng, 9 : trừ chiết khấu nhà hàng
  // 10 : cộng tiền vào ví vay , 11 : hoàn tiền vào ví vay

  historyTransactionData({required this.id, required this.senderId,required this.receiverId, required this.transactionTime, required this.type,required this.content, required this.money, required this.area});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'receiverId' : receiverId,
    'type' : type,
    'transactionTime' : transactionTime.toJson(),
    'content' : content,
    'money' : money,
    'area' : area
  };

  factory historyTransactionData.fromJson(Map<dynamic, dynamic> json) {
    return historyTransactionData(
        id: json['id'].toString(),
        senderId: json['senderId'].toString(),
        receiverId: json['receiverId'].toString(),
        type: int.parse(json['type'].toString()),
        transactionTime: Time.fromJson(json['transactionTime']),
        content: json['content'].toString(),
        money: double.parse(json['money'].toString()),
        area: json['area'].toString()
    );
  }
}