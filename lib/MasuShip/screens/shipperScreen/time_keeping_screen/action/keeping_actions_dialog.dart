import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/time_keeping_screen/action/break_take/break_take_step_1.dart';

class keeping_action_dialog extends StatefulWidget {
  final Time time;
  const keeping_action_dialog({super.key, required this.time});

  @override
  State<keeping_action_dialog> createState() => _keeping_action_dialogState();
}

class _keeping_action_dialogState extends State<keeping_action_dialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 10,),

            GestureDetector(
              child: Container(
                height: 40,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 10,
                      bottom: 10,
                      right: 10,
                      left: 10,
                      child: Container(
                        child: AutoSizeText(
                          'Xin nghỉ ngày này',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.black,
                              fontFamily: 'muli'
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 10,
                      bottom: 10,
                      right: 10,
                      child: Container(
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return break_take_step_1(time: widget.time,);
                  },
                );
              },
            ),

            Container(height: 10,),
          ],
        ),
      ),
    );
  }
}
