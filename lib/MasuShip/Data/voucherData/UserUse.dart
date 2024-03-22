class UserUse {
  String id;
  int count;

  UserUse({required this.id, required this.count});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'count' : count
  };

  factory UserUse.fromJson(Map<dynamic, dynamic> json) {
    return UserUse(
      id: json['id'].toString(),
      count: int.parse(json['count'].toString()),
    );
  }
}