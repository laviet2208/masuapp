import '../NormalUser/accountLocation.dart';

class Receiver {
  accountLocation location;
  String locationNote;
  String name;
  String phoneNum;
  String note;

  Receiver({
    required this.location,
    required this.locationNote,
    required this.name,
    required this.phoneNum,
    required this.note,
  });

  Map<dynamic, dynamic> toJson() => {
    'location' : location.toJson(),
    'locationNote' : locationNote,
    'name' : name,
    'phoneNum' : phoneNum,
    'note' : note,
  };

  factory Receiver.fromJson(Map<dynamic, dynamic> json) {
    return Receiver(
      location: accountLocation.fromJson(json['location']),
      locationNote: json['locationNote'].toString(),
      name: json['name'].toString(),
      phoneNum: json['phoneNum'].toString(),
      note: json['note'].toString(),
    );
  }

  void changeToDefault() {
    location = accountLocation(phoneNum: "NA", LocationID: "NA", Latitude: -1, Longitude: -1, firstText: "NA", secondaryText: "NA");
    locationNote = 'NA';
    name = 'NA';
    phoneNum = 'NA';
    note = 'NA';
  }
}