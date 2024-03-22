class accountLocation {
  String phoneNum;
  String LocationID;
  double Longitude; // kinh độ
  double Latitude; // vĩ độ
  String firstText;
  String secondaryText;

  accountLocation({required this.phoneNum, required this.LocationID, required this.Latitude, required this.Longitude, required this.firstText, required this.secondaryText});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'LocationID': LocationID,
    'Longitude' : Longitude,
    'Latitude' : Latitude,
    'firstText' : firstText,
    'secondaryText' : secondaryText
  };

  factory accountLocation.fromJson(Map<dynamic, dynamic> json) {
    return accountLocation(
        phoneNum: json["phoneNum"].toString(),
        LocationID: json["LocationID"].toString(),
        Latitude: double.parse(json["Latitude"].toString()),
        Longitude: double.parse(json["Longitude"].toString()),
        firstText: json["firstText"].toString(),
        secondaryText: json["secondaryText"].toString()
    );
  }
}