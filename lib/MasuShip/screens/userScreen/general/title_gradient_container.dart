import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class title_gradient_container extends StatefulWidget {
  final IconData icon;
  final String title;
  const title_gradient_container({super.key, required this.icon, required this.title});

  @override
  State<title_gradient_container> createState() => _title_gradient_containerState();
}

class _title_gradient_containerState extends State<title_gradient_container> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 40,
      width: width/3*2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
        gradient: LinearGradient(
          colors: [Colors.yellow.withAlpha(200) ,Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 2, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Row(
          children: <Widget>[
            Container(
              width: 25,
              child: Icon(
                widget.icon,
                color: Colors.black,
                size: 25,
              ),
            ),

            Container(width: 5,),

            Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Container(
                width: width/3*2 - 50,
                child: AutoSizeText(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
