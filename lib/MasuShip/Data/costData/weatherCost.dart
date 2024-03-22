class weatherCost {
  int available; // 0: không cho thu, 1: cho thu
  String weatherTitle;
  double cost;

  weatherCost({required this.available, required this.cost, required this.weatherTitle});

  Map<dynamic, dynamic> toJson() => {
    'available': available,
    'cost': cost,
    'weatherTitle': weatherTitle,
  };

  factory weatherCost.fromJson(Map<dynamic, dynamic> json) {
    return weatherCost(
      available: int.parse(json['available'].toString()),
      cost: double.parse(json['cost'].toString()),
      weatherTitle: json['weatherTitle'].toString(),
    );
  }
}
