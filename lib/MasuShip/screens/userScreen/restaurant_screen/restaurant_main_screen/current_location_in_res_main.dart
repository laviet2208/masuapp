import 'package:flutter/material.dart';

class current_location_in_res_main extends StatelessWidget {
  final String title;
  const current_location_in_res_main({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: 'Giao tới\n',
        style: TextStyle(
          fontFamily: 'roboto',
          fontSize: 14,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
          ),
        ],
      ),
    );
  }
}
