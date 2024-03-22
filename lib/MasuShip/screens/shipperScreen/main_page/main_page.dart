import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_page/controller/main_page_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_page/dash_board.dart';

class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  static Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('CCCD').child(imagePath);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [finalData.shipper_account.onlineStatus == 1 ? Colors.yellow.shade700 : Colors.black26,finalData.shipper_account.onlineStatus == 1 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),

        child: Column(
          children: [
            Container(height: 50,),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // màu của shadow
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
                      bottom: 10,
                      left: 10,
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(finalData.shipper_account.id + '_Ava.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              );
                            }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitWidth,);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: 10,
                      left: 90,
                      child: Container(
                        width: width/3,
                        height: 18,
                        child: AutoSizeText(
                            'Tài xế',
                            maxLines: 1,
                            style : TextStyle(
                                fontSize: 100,
                                fontFamily: 'arial',
                                color: Colors.grey
                            )
                        ),
                      ),
                    ),

                    Positioned(
                      top: 32,
                      left: 90,
                      child: Container(
                        width: width/3,
                        height: 20,
                        child: AutoSizeText(
                            finalData.shipper_account.name,
                            maxLines: 1,
                            style : TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'arial'
                            )
                        ),
                      ),
                    ),

                    Positioned(
                      top: 56,
                      left: 90,
                      child: Container(
                        width: width/3,
                        height: 20,
                        child: AutoSizeText(
                            'Xe máy' + finalData.shipper_account.license,
                            maxLines: 1,
                            style : TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontFamily: 'arial'
                            )
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      right: 20,
                      child: GestureDetector(
                        child: Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: finalData.shipper_account.onlineStatus == 0 ? Colors.grey : Colors.yellow.shade700,
                        ),
                        onTap: () async {
                          main_page_controller.CheckInAndCheckOut(context, () {setState(() {});});
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: dash_board_container(),
            )
          ],
        ),
      ),
    );
  }
}
