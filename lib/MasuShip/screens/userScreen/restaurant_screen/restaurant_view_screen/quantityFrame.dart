import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';

import '../../../../Data/otherData/Time.dart';

class quantityFrame extends StatefulWidget {
  final Time data = Time(second: 1, minute: 0, hour: 0, day: 0, month: 0, year: 0);
  @override
  State<quantityFrame> createState() => _quantityFrameState();
}

class _quantityFrameState extends State<quantityFrame> {
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
    } else {
      toastMessage('Số lượng không được bé hơn 1');
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
