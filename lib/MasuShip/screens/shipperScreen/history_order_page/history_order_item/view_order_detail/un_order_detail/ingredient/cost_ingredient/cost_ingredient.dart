import 'package:flutter/material.dart';

class cost_ingredient {
  static Positioned left_title_cost(String title, Color color, FontWeight weight) {
    return Positioned(
      top: 0,
      left: 0,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            color: color,
            fontFamily: 'muli',
            fontWeight: weight
        ),
      ),
    );
  }

  static Positioned right_title_cost(String title, Color color, FontWeight weight) {
    return Positioned(
      top: 0,
      right: 0,
      child: Text(
        title,
        textAlign: TextAlign.end,
        style: TextStyle(
            fontSize: 14,
            color: color,
            fontFamily: 'muli',
            fontWeight: weight
        ),
      ),
    );
  }
}