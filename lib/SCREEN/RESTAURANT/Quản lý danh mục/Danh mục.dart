class RestaurantDirectory {
  String mainContent;
  String mainIcon;
  String subContent;
  String subIcon;
  String id;
  String Area;
  List<String> shopList;

  RestaurantDirectory({required this.id, required this.mainContent, required this.mainIcon, required this.subContent, required this.subIcon, required this.shopList, required this.Area});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'mainContent' : mainContent,
    'mainIcon' : mainIcon,
    'subContent' : subContent,
    'subIcon' : subIcon,
    'shopList': shopList.map((e) => e).toList(),
    'Area' : Area
  };

  factory RestaurantDirectory.fromJson(Map<dynamic, dynamic> json) {
    List<String> idList = [];

    if (json["shopList"] != null) {
      for (final result in json["shopList"]) {
        idList.add(result.toString());
      }
    }

    return RestaurantDirectory(
        id: json['id'].toString(),
        mainContent: json['mainContent'].toString(),
        mainIcon: json['mainIcon'].toString(),
        subContent: json['subContent'].toString(),
        subIcon: json['subIcon'].toString(),
        shopList: idList,
        Area: json['Area'].toString()
    );
  }
}