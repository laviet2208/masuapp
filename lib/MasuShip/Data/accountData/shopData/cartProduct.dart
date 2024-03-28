import 'package:masuapp/MasuShip/Data/accountData/shopData/Product.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';

class cartProduct {
  Product product;
  int number;

  cartProduct({required this.product, required this.number});

  Map<dynamic, dynamic> toJson() => {
    'product' : product.toJson(),
    'number' : number,
  };

  factory cartProduct.fromJson(Map<dynamic, dynamic> json) {
    return cartProduct(
      product: Product.fromJson(json['product']),
      number: int.parse(json['number'].toString()),
    );
  }
}