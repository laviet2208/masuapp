import 'package:flutter/material.dart';

import '../otherData/Tool.dart';
import 'autocomplate_prediction.dart';

class item_autocomplete extends StatefulWidget {
  final AutocompletePrediction location;
  final double width;
  final bool loading;
  final VoidCallback onTap;
  const item_autocomplete({Key? key, required this.location, required this.width, required this.loading, required this.onTap}) : super(key: key);

  @override
  State<item_autocomplete> createState() => _item_autocompleteState();
}

class _item_autocompleteState extends State<item_autocomplete> {
  String secondaryText = 'Dont have a secondary Text';
  @override
  Widget build(BuildContext context) {
    if (widget.location.structuredFormatting!.secondaryText.toString() != null || widget.location.structuredFormatting!.secondaryText.toString().isNotEmpty ) {
      secondaryText = widget.location.structuredFormatting!.secondaryText.toString();
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: 80,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: (80-30)/2,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/locationRounditem.png'),
                  ),
                ),
              ),
            ),

            Positioned(
              right: 10,
              top: (80-15)/2,
              child: Container(
                width: 15,
                height: 15,
                child: widget.loading ? CircularProgressIndicator(color: Colors.yellow.shade600,) : Icon(Icons.chevron_right, color: Colors.black,),
              ),
            ),


            Positioned(
              top: 19,
              left: 40,
              child: Text(
                compactString(30, widget.location.description.toString()),
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              top: 44,
              left: 40,
              child: Text(
                compactString(40, secondaryText),
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: Container(
                width: widget.width-40,
                height: 3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
