import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../main_screen/user_main_screen.dart';

class back_button_in_wait extends StatefulWidget {
  const back_button_in_wait({super.key});

  @override
  State<back_button_in_wait> createState() => _back_button_in_waitState();
}

class _back_button_in_waitState extends State<back_button_in_wait> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        child: Row(
          children: [
            Container(width: 10,),

            Container(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            ),

            Container(width: 10,),

            Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Container(
                width: width - 70,
                child: AutoSizeText(
                  'Quay về trang chủ',
                  style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 100,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
      },
    );
  }
}
