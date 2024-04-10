import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class location_title_custom_express extends StatefulWidget {
  final String type;
  final String title;
  const location_title_custom_express({super.key, required this.type, required this.title});

  @override
  State<location_title_custom_express> createState() => _location_titleState();
}

class _location_titleState extends State<location_title_custom_express> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 30,
      child: Row(
        children: [
          Container(
            width: 10,
          ),

          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.type == 'start' ? 'assets/image/orangecircle.png' : 'assets/image/redcircle.png')
                )
            ),
          ),

          Container(
            width: 10,
          ),

          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              height: 30,
              width: width - 40 - 30 - 30 - 10,
              child: AutoSizeText(
                widget.title,
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
