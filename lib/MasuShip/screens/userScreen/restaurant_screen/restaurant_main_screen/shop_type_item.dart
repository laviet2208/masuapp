import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class shop_type_item extends StatefulWidget {
  final String imagePath;
  final String title;
  const shop_type_item({super.key, required this.imagePath, required this.title});

  @override
  State<shop_type_item> createState() => _shop_type_itemState();
}

class _shop_type_itemState extends State<shop_type_item> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 110)/4;
    double height = (MediaQuery.of(context).size.width - 110)/4;
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(widget.imagePath),
                    )
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 15,
                alignment: Alignment.center,
                child: AutoSizeText(
                  widget.title,
                  style: TextStyle(
                      fontSize: 100,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
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
