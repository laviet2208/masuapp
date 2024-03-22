class Cost {
  double departKM;
  double departCost;
  double perKMcost;
  double discount;

  Cost({
    required this.departKM,
    required this.departCost,
    required this.perKMcost,
    required this.discount,
  });

  Map<dynamic, dynamic> toJson() => {
    'departCost': departCost,
    'departKM': departKM,
    'discount': discount,
    'perKMcost': perKMcost,
  };

  factory Cost.fromJson(Map<dynamic, dynamic> json) {
    return Cost(
        departKM: double.parse(json['departKM'].toString()),
        departCost: double.parse(json['departCost'].toString()),
        perKMcost: double.parse(json['perKMcost'].toString()),
        discount: double.parse(json['discount'].toString())
    );
  }

  void changeData(Map<dynamic, dynamic> json) {
    departKM = double.parse(json['departKM'].toString());
    departCost = double.parse(json['departCost'].toString());
    perKMcost = double.parse(json['perKMcost'].toString());
    discount = double.parse(json['discount'].toString());
  }
}