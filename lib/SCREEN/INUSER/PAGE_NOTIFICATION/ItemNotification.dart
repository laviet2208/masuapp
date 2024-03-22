import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_NOTIFICATION/Notification.dart';

class ItemNotice extends StatefulWidget {
  final double width;
  final double height;
  final notification notice;
  const ItemNotice({Key? key, required this.width, required this.height, required this.notice}) : super(key: key);

  @override
  State<ItemNotice> createState() => _ItemNoticeState();
}

class _ItemNoticeState extends State<ItemNotice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: Colors.redAccent
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              height: 40,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5,
                    left: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/notice.png')
                        )
                      ),
                    ),
                  ),

                  Positioned(
                    top: 15,
                    right: 0,
                    child: Text(
                    getAllTimeString(widget.notice.send),
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'roboto',
                          color:Colors.grey,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            height: 6,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 25),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.notice.Title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'roboto',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Container(
            height: 6,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 60),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.notice.Sub,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'roboto',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),



          Container(
            height: 20,
          )
        ],
      )
    );
  }
}
