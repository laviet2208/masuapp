import '../otherData/Time.dart';

class noticeData {
  String id;
  String area;
  String title;
  String sub;
  String content;
  int object;
  int status; // 1 : chưa thông báo , 2 : đang thông báo
  Time create;
  Time send;

  noticeData({required this.id,required this.area,required this.title ,required this.sub,required this.object, required this.create, required this.send, required this.status, required this.content});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'area': area,
    'title': title,
    'sub' : sub,
    'object' : object,
    'create' : create.toJson(),
    'send' : send.toJson(),
    'status' : status,
    'content' : content
  };

  factory noticeData.fromJson(Map<dynamic, dynamic> json) {
    return noticeData(
        area: json['area'].toString(),
        title: json['title'].toString(),
        sub: json['sub'].toString(),
        object: int.parse(json['object'].toString()),
        create: Time.fromJson(json['create']),
        send: Time.fromJson(json['send']),
        id: json['id'].toString(),
        status: int.parse(json['status'].toString()),
        content: json['content'].toString()
    );
  }
}