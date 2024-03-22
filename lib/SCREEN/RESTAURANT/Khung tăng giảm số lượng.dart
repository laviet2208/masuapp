import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/ShopUser/accountShop.dart';
import 'package:masuapp/GENERAL/Tool/Time.dart';

class QuantitySelector extends StatefulWidget {
  final Time data = Time(second: 1, minute: 0, hour: 0, day: 0, month: 0, year: 0);
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  void increment() {
    setState(() {
      widget.data.second++;
    });
  }

  void decrement() {
    if (widget.data.second > 1) {
      setState(() {
        widget.data.second--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: decrement,
        ),
        Text(
          widget.data.second.toString(),
          style: TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: increment,
        ),
      ],
    );
  }
}
