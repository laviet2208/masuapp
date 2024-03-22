class shopDirectory {
  String id;
  String mainName;
  String subName;
  String area;
  int status; //0 : Đang đóng, 1 : Đang mở
  List<String> restaurantList;

  shopDirectory({required this.id, required this.status, required this.mainName, required this.subName, required this.area, required this.restaurantList});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'mainName' : mainName,
    'restaurantList': restaurantList.map((e) => e).toList(),
    'subName' : subName,
    'area' : area,
    'status' : status,
  };

  factory shopDirectory.fromJson(Map<dynamic, dynamic> json) {
    List<String> idList = [];

    if (json["restaurantList"] != null) {
      for (final result in json["restaurantList"]) {
        idList.add(result.toString());
      }
    }

    return shopDirectory(
      id: json['id'].toString(),
      mainName: json['mainName'].toString(),
      restaurantList: idList,
      subName: json['subName'].toString(),
      area: json['area'].toString(),
      status: int.parse(json['status'].toString()),
    );
  }

}
