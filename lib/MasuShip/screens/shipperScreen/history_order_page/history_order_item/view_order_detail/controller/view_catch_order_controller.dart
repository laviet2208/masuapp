import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class view_catch_order_controller {
  static void show_B_dialog(BuildContext context, double width) async {
    final player = AudioPlayer();
    await player.play(AssetSource('volume/ting.mp3'), volume: 200);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Đón khách thành công'),
          content: Container(
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Chúc mừng, bạn đã đón khách',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      ),
                    )
                ),

                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Hãy đưa khách đến nơi ngay nhé',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                GestureDetector(
                  child: Container(
                    height: 45,
                    child: Center(
                      child: Container(
                        width: width/2,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Xác nhận',
                            style: TextStyle(
                                fontSize: 100,
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),

                Container(height: 20,),
              ],
            ),
          ),
        );
      },
    );
  }

  static void show_C_dialog(BuildContext context, double width) async {
    final player = AudioPlayer();
    await player.play(AssetSource('volume/ting.mp3'), volume: 200);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Trả khách thành công'),
          content: Container(
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Chúc mừng, đơn đã hoàn thành',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      ),
                    )
                ),

                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Nhận thanh toán ngay nhé',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                GestureDetector(
                  child: Container(
                    height: 45,
                    child: Center(
                      child: Container(
                        width: width/2,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Xác nhận',
                            style: TextStyle(
                                fontSize: 100,
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),

                Container(height: 20,),
              ],
            ),
          ),
        );
      },
    );
  }
}