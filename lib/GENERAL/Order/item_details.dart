class item_details {
  double weight;
  String type;
  double codFee;

  item_details({
    required this.weight,
    required this.type,
    required this.codFee,
  });

  Map<dynamic, dynamic> toJson() => {
    'weight' : weight,
    'type' : type,
    'codFee' : codFee,
  };

  factory item_details.fromJson(Map<dynamic, dynamic> json) {
    return item_details(
      weight: double.parse(json['weight'].toString()),
      type: json['type'].toString(),
      codFee: double.parse(json['codFee'].toString()),
    );
  }

  void changeToDefault() {
    weight = -1;
    codFee = -1;
    type = 'NA';
  }
}