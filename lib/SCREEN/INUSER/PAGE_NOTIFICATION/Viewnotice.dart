import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_NOTIFICATION/Notification.dart';

import '../../../GENERAL/Tool/Tool.dart';
import '../../SHIPPERSCREEN/INUSER/SCREEN_NOTICE/SCREENnotice.dart';
import '../SCREEN_MAIN/SCREENmain.dart';

class Viewnotice extends StatefulWidget {
  final notification notice;
  final int type;
  const Viewnotice({Key? key, required this.notice, required this.type}) : super(key: key);

  @override
  State<Viewnotice> createState() => _ViewnoticeState();
}

class _ViewnoticeState extends State<Viewnotice> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 245, 245)
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 15,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            if(widget.type == 1) {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                            }
                            if(widget.type == 2) {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => ScreenNotice()));
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image/backicon1.png')
                                )
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                          bottom: 22,
                          left: 60,
                          child: Text(
                            'Chi tiết thông báo',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 24,
                                fontFamily: 'arial',
                                color: Colors.black,
                                decoration: TextDecoration.none
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 100,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight - 100,
                  child: ListView(
                    children: [
                      Container(height: 0,),

                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 10),
                        child: Container(
                            child: Text(
                              widget.notice.Title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  decoration: TextDecoration.none,

                              ),
                            )
                        ),
                      ),

                      Container(height: 8,),

                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 10),
                        child: Container(
                            height: 20,
                            child: AutoSizeText(
                              getAllTimeString(widget.notice.send),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'roboto',
                                  color:Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                              ),
                            )
                        ),
                      ),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 10),
                        child: Container(
                            child: Text(
                              widget.notice.Content,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'arial',
                                color:Colors.black,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            )
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
        onWillPop: () async {
          return false;
        }
    );
  }
}
