class Time {
  int second = 0;
  int minute = 0;
  int hour = 0;
  int day = 0;
  int month = 0;
  int year = 0;

  Time({
    required this.second,
    required this.minute,
    required this.hour,
    required this.day,
    required this.month,
    required this.year,
  });

  Map<dynamic, dynamic> toJson() => {
    'second': second,
    'minute': minute,
    'hour': hour,
    'day': day,
    'month': month,
    'year': year,
  };

  factory Time.fromJson(Map<dynamic, dynamic> json) {
    return Time(
      second: int.parse(json['second'].toString()),
      minute: int.parse(json['minute'].toString()),
      hour: int.parse(json['hour'].toString()),
      day: int.parse(json['day'].toString()),
      month: int.parse(json['month'].toString()),
      year: int.parse(json['year'].toString()),
    );
  }

}