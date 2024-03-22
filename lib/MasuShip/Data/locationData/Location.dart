class Location {
  String placeId;
  String description;
  double longitude; // kinh độ
  double latitude; // vĩ độ
  String mainText;
  String secondaryText;

  Location({required this.placeId, required this.description,required this.longitude, required this.latitude, required this.mainText, required this.secondaryText});

  Map<dynamic, dynamic> toJson() => {
    'placeId': placeId,
    'description': description,
    'longitude' : longitude,
    'latitude' : latitude,
    'mainText' : mainText,
    'secondaryText' : secondaryText
  };

  factory Location.fromJson(Map<dynamic, dynamic> json) {
    return Location(
      placeId: json['placeId'].toString(),
      description: json['description'].toString(),
      longitude: double.parse(json['longitude'].toString()),
      latitude: double.parse(json['latitude'].toString()),
      mainText: json['mainText'].toString(),
      secondaryText: json['secondaryText'].toString(),
    );
  }
}