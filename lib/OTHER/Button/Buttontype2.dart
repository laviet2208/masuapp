import 'package:flutter/material.dart';

class ButtonType2 extends StatelessWidget {
  final double Height;
  final double Width;
  final double radiusBorder;

  final String title;
  final String fontText;
  final Color colorText;
  final Color BackGroundColor;
  final Color StrokeColor;

  final VoidCallback onTap;

  final String url;

  const ButtonType2({super.key, required this.Height, required this.Width, required this.radiusBorder, required this.title, required this.fontText, required this.colorText, required this.BackGroundColor, required this.StrokeColor, required this.onTap, required this.url});


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child : Container(
          height: Height,
          width: Width,
          decoration: BoxDecoration(
            color: BackGroundColor,
            borderRadius: BorderRadius.circular(radiusBorder),
            border: Border.all(
              width: 2,
              color: StrokeColor
            )
          ),

          child: Stack(
            children: <Widget>[
              Positioned(
                top: Height/5,
                right: Height/5,
                child: Container(
                  alignment: Alignment.centerRight,
                  width: 3/4 * Width,
                  height: 3/5 * Height,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: fontText,
                        color: colorText,
                        fontSize: Height/4
                      ),
                    ),
                ),
              ),

              Positioned(
                top: Height/5,
                left: Height/6,

                child: Container(
                  width: 3/5 * Height,
                  height: 3/5 * Height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(url),
                    ),
                  ),
                ),
              )

            ],
          ),

        )
    );  }
}
