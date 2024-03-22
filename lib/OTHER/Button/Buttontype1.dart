import 'package:flutter/material.dart';

class ButtonType1 extends StatelessWidget {
  final double Height;
  final double Width;
  final Color color;
  final double radiusBorder;

  final String title;
  final String fontText;
  final Color colorText;

  final VoidCallback onTap;

  final bool loading;


  const ButtonType1({Key? key, required this.Height, required this.Width, required this.color, required this.radiusBorder,
                     required this.title, required this.fontText, required this.colorText,
                     required this.onTap, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child : Container(
        height: Height,
        width: Width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radiusBorder),

        ),
        child: Center(
          child: loading ? CircularProgressIndicator(strokeWidth: 4, color: Colors.white,) : Text(
            title,
            style: TextStyle(
                fontFamily: fontText,
                color: colorText
            ),
          ),
        ),
      )
    );
  }

}