class productDirectory {
  String id;
  String mainName;
  String ownerID;
  List<String> foodList;

  productDirectory({required this.id, required this.mainName, required this.foodList, required this.ownerID});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'mainName' : mainName,
    'foodList': foodList.map((e) => e).toList(),
    'ownerID' : ownerID,
  };

  factory productDirectory.fromJson(Map<dynamic, dynamic> json) {
    List<String> idList = [];

    if (json["foodList"] != null) {
      for (final result in json["foodList"]) {
        idList.add(result.toString());
      }
    }

    return productDirectory(
      id: json['id'].toString(),
      mainName: json['mainName'].toString(),
      foodList: idList,
      ownerID: json['ownerID'].toString(),
    );
  }

}