import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Data/otherData/Time.dart';
import '../../../../../../../Data/otherData/Tool.dart';

class order_type_one_log_line extends StatefulWidget {
  final Time time;
  final String currentStatus;
  final String lineStatus;
  final String title;
  const order_type_one_log_line({super.key, required this.currentStatus, required this.lineStatus, required this.title, required this.time});

  @override
  State<order_type_one_log_line> createState() => _order_type_one_log_lineState();
}

class _order_type_one_log_lineState extends State<order_type_one_log_line> {
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
                    image: (widget.currentStatus == widget.lineStatus || widget.currentStatus == 'D' || widget.currentStatus == 'E' || widget.currentStatus == 'E1') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
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
              width: (width - 80)/2,
              child: AutoSizeText(
                widget.title,
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: widget.lineStatus == widget.currentStatus ?  FontWeight.bold : FontWeight.normal
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              height: 30,
              width: (width - 80)/2,
              child: AutoSizeText(
                getAllTimeString(widget.time),
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: widget.lineStatus == widget.currentStatus ?  FontWeight.bold : FontWeight.normal
                ),
              ),
            ),
          ),

          Container(
            width: 10,
          ),

        ],
      ),
    );
  }
}
