import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class feature_button_in_main_page extends StatefulWidget {
  final String title;
  final String imageUrl;
  const feature_button_in_main_page({super.key, required this.title, required this.imageUrl});

  @override
  State<feature_button_in_main_page> createState() => _feature_button_in_main_pageState();
}

class _feature_button_in_main_pageState extends State<feature_button_in_main_page> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width - 60)/3,
      height: (width - 60)/3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            bottom: (width - 100)/6,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(widget.imageUrl)
                  ),
                  // color: Colors.redAccent
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              height: (width - 90)/8 - 20,
              alignment: Alignment.center,
              child: AutoSizeText(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 100,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
