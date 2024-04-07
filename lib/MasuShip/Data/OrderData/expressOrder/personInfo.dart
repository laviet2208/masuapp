class personInfo {
  String name;
  String phone;

  personInfo({required this.name, required this.phone});

  Map<dynamic, dynamic> toJson() => {
    'name' : name,
    'phone' : phone,
  };

  factory personInfo.fromJson(Map<dynamic, dynamic> json) {
    return personInfo(
      name: json['name'].toString(),
      phone: json['phone'].toString(),
    );
  }
}