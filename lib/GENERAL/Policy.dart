
import 'Tool/Time.dart';

class Policy {
  String id;
  String title;
  String content;
  Time createTime;

  Policy({required this.id,required this.createTime, required this.title, required this.content});

  Map<dynamic, dynamic> toJson() => {
    'id' :id,
    'title' : title,
    'content' : content,
    'createTime' : createTime.toJson(),
  };

  factory Policy.fromJson(Map<dynamic, dynamic> json) {
    return Policy(
        id: json['id'],
        title: json['title'].toString(),
        content: json['content'].toString(),
        createTime: Time.fromJson(json['createTime']),
    );
  }
}