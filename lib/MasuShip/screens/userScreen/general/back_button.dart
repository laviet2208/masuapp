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
    return Container(
      height: 30,
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
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
            },
          ),

        ],
      ),
    );
  }
}
