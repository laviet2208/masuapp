
import '../NormalUser/accountNormal.dart';

class Evaluate {
  accountNormal owner;
  int star;
  String content;

  Evaluate({required this.owner, required this.star, required this.content});

  Map<dynamic, dynamic> toJson() => {
    'owner': owner.toJson(),
    'star': star,
    'content' : content,
  };

  factory Evaluate.fromJson(Map<dynamic, dynamic> json) {
    return Evaluate(
        owner: accountNormal.fromJson(json['owner']),
        star: int.parse(json['star']),
        content: json['content'].toString()
    );
  }
}