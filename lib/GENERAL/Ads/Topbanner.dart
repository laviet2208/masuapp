
import '../Tool/Time.dart';

class Topbanner {
  String id;
  String URLimage;
  String URL;
  Time createTime;

  Topbanner({required this.URLimage, required this.URL, required this.createTime, required this.id});

  Map<dynamic, dynamic> toJson() => {
    'URLimage': URLimage,
    'URL': URL,
    'createTime' : createTime.toJson(),
  };

  factory Topbanner.fromJson(Map<dynamic, dynamic> json) {
    return Topbanner(
        URLimage: json['URLimage'].toString(),
        URL: json['URL'].toString(),
        createTime: Time.fromJson(json['createTime']),
        id: json['id'].toString(),
    );
  }
}