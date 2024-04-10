import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class general_ingredient {
  static Container get_location_text(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  static Container get_cost_title(String title, Color color, FontWeight weight, double width) {
    return Container(
      height: 30,
      width: (width - 40 - 20)/2,
      child: AutoSizeText(
        title,
        style: TextStyle(
            fontFamily: 'muli',
            color: color,
            fontSize: 200,
            fontWeight: weight
        ),
      ),
    );
  }

  static Container get_cost_content(String title, Color color, FontWeight weight, double width) {
    return Container(
      height: 30,
      width: (width - 40 - 20)/2,
      child: AutoSizeText(
        title,
        textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: 'muli',
            color: color,
            fontSize: 200,
            fontWeight: weight
        ),
      ),
    );
  }
}
