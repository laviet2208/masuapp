import '../../../GENERAL/Tool/Time.dart';

class notification {
  String id;
  String Area;
  String Title;
  String Sub;
  String Content;
  int object;
  int status; // 1 : chưa thông báo , 2 : đang thông báo
  Time create;
  Time send;

  notification({required this.id,required this.Area,required this.Title ,required this.Sub,required this.object, required this.create, required this.send, required this.status, required this.Content});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'Area': Area,
    'Title': Title,
    'Sub' : Sub,
    'object' : object,
    'create' : create.toJson(),
    'send' : send.toJson(),
    'status' : status,
    'Content' : Content
  };

  factory notification.fromJson(Map<dynamic, dynamic> json) {
    return notification(
        Area: json['Area'].toString(),
        Title: json['Title'].toString(),
        Sub: json['Sub'].toString(),
        object: int.parse(json['object'].toString()),
        create: Time.fromJson(json['create']),
        send: Time.fromJson(json['send']),
        id: json['id'].toString(),
        status: int.parse(json['status'].toString()),
        Content: json['Content'].toString()
    );
  }

  void changeData(Map<dynamic, dynamic> json) {
    Area = json['Area'].toString();
    Title = json['Title'].toString();
    Sub = json['Sub'].toString();
    object = int.parse(json['object'].toString());
    create = Time.fromJson(json['create']);
    send = Time.fromJson(json['send']);
    id = json['id'].toString();
    status = int.parse(json['status'].toString());
    Content = json['Content'].toString();
  }
}