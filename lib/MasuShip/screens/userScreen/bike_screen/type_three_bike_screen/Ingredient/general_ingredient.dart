import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../Data/otherData/Tool.dart';
class general_ingredient {
  static Container get_money_text(String title, double width) {
    return Container(
      height: 60,
      width: (width - 40 - 20)/2,
      alignment: Alignment.centerRight,
      child: Text(
        title,
        textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  static Container get_loading(double width) {
    return Container(
      height: 60,
      width: (width - 40 - 20)/2,
      alignment: Alignment.centerRight,
      child: Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2,),
      ),
    );
  }

  static Container get_distance_text(String title, double width) {
    return Container(
      height: 60,
      width: (width - 40 - 20)/2,
      child: Text(
        title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  static Padding get_cost_title(String title, double width, double padding) {
    return Padding(
      padding: EdgeInsets.only(top: padding, bottom: padding),
      child: Container(
        height: 30,
        width: (width - 40 - 20)/2,
        child: Container(
          height: 30,
          width: (width - 40 - 20)/2,
          child: AutoSizeText(
            title,
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontSize: 200,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }



  static Container get_cost_money(String title, double width) {
    return Container(
      height: 30,
      width: (width - 40 - 20)/2,
      child: AutoSizeText(
        title,
        textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 200,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}