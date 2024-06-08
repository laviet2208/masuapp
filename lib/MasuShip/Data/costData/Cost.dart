class Cost {
  double departKM;
  double departCost;
  double milestoneKM1;
  double milestoneKM2;
  double perKMcost1;
  double perKMcost2;
  double perKMcost3;
  double discountLimit;
  double discountMoney;
  double discountPercent;

  Cost({
    required this.departKM,
    required this.departCost,
    required this.milestoneKM1,
    required this.milestoneKM2,
    required this.perKMcost1,
    required this.perKMcost2,
    required this.perKMcost3,
    required this.discountLimit,
    required this.discountMoney,
    required this.discountPercent,
  });

  Map<dynamic, dynamic> toJson() => {
    'departKM': departKM,
    'departCost': departCost,
    'milestoneKM1': milestoneKM1,
    'milestoneKM2': milestoneKM2,
    'perKMcost1': perKMcost1,
    'perKMcost2': perKMcost2,
    'perKMcost3': perKMcost3,
    'discountLimit': discountLimit,
    'discountMoney': discountMoney,
    'discountPercent': discountPercent,
  };

  factory Cost.fromJson(Map<dynamic, dynamic> json) {
    return Cost(
      departKM: double.parse(json['departKM'].toString()),
      departCost: double.parse(json['departCost'].toString()),
      milestoneKM1: double.parse(json['milestoneKM1'].toString()),
      milestoneKM2: double.parse(json['milestoneKM2'].toString()),
      perKMcost1: double.parse(json['perKMcost1'].toString()),
      perKMcost2: double.parse(json['perKMcost2'].toString()),
      perKMcost3: double.parse(json['perKMcost3'].toString()),
      discountLimit: double.parse(json['discountLimit'].toString()),
      discountMoney: double.parse(json['discountMoney'].toString()),
      discountPercent: double.parse(json['discountPercent'].toString()),
    );
  }

  void changeData(Map<dynamic, dynamic> json) {
    departKM = double.parse(json['departKM'].toString());
    departCost = double.parse(json['departCost'].toString());
    milestoneKM1 = double.parse(json['milestoneKM1'].toString());
    milestoneKM2 = double.parse(json['milestoneKM2'].toString());
    perKMcost1 = double.parse(json['perKMcost1'].toString());
    perKMcost2 = double.parse(json['perKMcost2'].toString());
    perKMcost3 = double.parse(json['perKMcost3'].toString());
    discountLimit = double.parse(json['discountLimit'].toString());
    discountMoney = double.parse(json['discountMoney'].toString());
    discountPercent = double.parse(json['discountPercent'].toString());
  }

  List<double> calculateMilestones(double distance) {
    List<double> milestones = [];
    double remainingDistance = distance;

    if (remainingDistance <= departKM) {
      milestones.add(remainingDistance);
      remainingDistance = 0;
    } else {
      remainingDistance = remainingDistance - departKM;
      milestones.add(departKM);
    }

    if (remainingDistance <= milestoneKM1) {
      milestones.add(remainingDistance);
      remainingDistance = 0;
    } else {
      milestones.add(milestoneKM1);
      remainingDistance = remainingDistance - milestoneKM1;
    }

    if (remainingDistance <= milestoneKM2) {
      milestones.add(remainingDistance);
      remainingDistance = 0;
    } else {
      milestones.add(milestoneKM2);
      remainingDistance = remainingDistance - milestoneKM2;
    }
    milestones.add(remainingDistance);

    return milestones;
  }
}
