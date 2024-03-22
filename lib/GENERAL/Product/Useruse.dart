class Useruse {
  String id;
  int count;

  Useruse({required this.id, required this.count});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'count' : count
  };

  factory Useruse.fromJson(Map<dynamic, dynamic> json) {
    return Useruse(
      id: json['id'].toString(),
      count: int.parse(json['count'].toString()),
    );
  }
}