import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class back_button extends StatefulWidget {
  final Widget beforeWidget;
  const back_button({super.key, required this.beforeWidget});

  @override
  State<back_button> createState() => _back_buttonState();
}

class _back_buttonState extends State<back_button> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Container(width: 10,),

            GestureDetector(
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),

            ),

            Container(width: 10,),

            Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Container(
                width: width - 70,
                child: AutoSizeText(
                  'Quay về trước',
                  style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 100,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
      },
    );
  }
}
