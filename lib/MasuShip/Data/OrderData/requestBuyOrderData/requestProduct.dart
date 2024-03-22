class requestProduct{
  String name;
  String unit;
  double number;
  double cost;

  requestProduct({required this.name, required this.unit, required this.cost, required this.number});

  Map<dynamic, dynamic> toJson() => {
    'unit' : unit,
    'name' : name,
    'cost' : cost,
    'number' : number,
  };

  factory requestProduct.fromJson(Map<dynamic, dynamic> json) {
    return requestProduct(
      name: json['name'].toString(),
      unit: json['unit'].toString(),
      cost: double.parse(json['cost'].toString()),
      number: double.parse(json['number'].toString()),
    );
  }

}