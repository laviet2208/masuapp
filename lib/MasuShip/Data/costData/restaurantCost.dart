class restaurantCost {
  double discount;

  restaurantCost({required this.discount});

  Map<dynamic, dynamic> toJson() => {
    'discount': discount,
  };

  factory restaurantCost.fromJson(Map<dynamic, dynamic> json) {
    return restaurantCost(
      discount: double.parse(json['discount'].toString()),
    );
  }
}