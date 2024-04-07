import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class location_title extends StatefulWidget {
  final String type;
  const location_title({super.key, required this.type});

  @override
  State<location_title> createState() => _location_titleState();
}

class _location_titleState extends State<location_title> {
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
                widget.type == 'start' ? 'Điểm đón' : 'Điểm đến',
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
