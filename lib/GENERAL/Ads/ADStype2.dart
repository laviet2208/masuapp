class ADStype2 {
  String id;
  String mainContent;
  String facebookLink;
  String mainImage;

  ADStype2({required this.mainContent, required this.facebookLink, required this.mainImage, required this.id});

  Map<dynamic, dynamic> toJson() => {
    'mainContent': mainContent,
    'facebookLink': facebookLink,
    'mainImage' : mainImage,
    'id' : id
  };

  factory ADStype2.fromJson(Map<dynamic, dynamic> json) {
    return ADStype2(
      id: json['id'].toString(),
      mainContent: json['mainContent'].toString(),
      facebookLink: json['facebookLink'].toString(),
      mainImage: json['mainImage'].toString(),
    );
  }

}