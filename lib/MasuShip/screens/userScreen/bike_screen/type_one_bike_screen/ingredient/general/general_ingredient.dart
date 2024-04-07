import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class general_ingredient {
  static Column loading_container() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 30,),

        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: Colors.yellow,),
        ),

        Container(height: 20,),
      ],
    );
  }

  static Column error_container() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 30,),

        Container(
          height: 20,
          alignment: Alignment.center,
          child: AutoSizeText(
            'Lỗi dữ liệu, hãy thử lại',
            style: TextStyle(
                fontFamily: 'muli',
                fontSize: 100,
                color: Colors.grey
            ),
          ),
        ),

        Container(height: 20,),
      ],
    );
  }
}