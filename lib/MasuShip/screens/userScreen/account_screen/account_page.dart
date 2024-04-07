import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../Data/areaData/Area.dart';

class account_page extends StatefulWidget {
  const account_page({super.key});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void get_area_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + finalData.user_account.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      area.id = a.id;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_data();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: (screenWidth - 20)/2 + 50,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                          height: (screenWidth - 20)/2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white,Colors.yellow],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(20),
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
                            children: [
                              Container(height: 22,),

                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    'Xin chào !',
                                    style: TextStyle(
                                        fontSize: 160,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'roboto',
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    finalData.user_account.name,
                                    style: TextStyle(
                                        fontSize: 160,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'roboto',
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 40,),

                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                    height: 25,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          child: Icon(
                                            Icons.phone_android_sharp,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                        ),

                                        Container(
                                          width: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 5,bottom: 5),
                                          child: Container(
                                            width: screenWidth/3 * 2,
                                            child: AutoSizeText(
                                              finalData.user_account.phone,
                                              style: TextStyle(
                                                  fontSize: 160,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/bikeLogo2.png')
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 15,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/1.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Thông tin tài khoản',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // chọn khu vực
                                return AlertDialog(
                                  title: Text('Chọn khu vực', style: TextStyle(fontFamily: 'arial', fontSize: 16),),
                                  content: Container(
                                      height: 60,
                                      width: screenWidth,
                                      child: ListView(
                                        children: [
                                          Container(
                                            height: 20,
                                            child: AutoSizeText(
                                              'Bạn hiện đang ở khu vực',
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  color: Color.fromARGB(255, 244, 164, 84),
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),

                                          Container(height: 6,),

                                          Container(
                                            height: 20,
                                            child: AutoSizeText(
                                              area.name,
                                              style: TextStyle(
                                                  fontSize: 100
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Khu vực khác'),
                                      onPressed: () {

                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/2.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Khu vực hiện tại',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 10,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: (screenWidth - 20 - 20)/3,
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    area.name,
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'arial',
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),


                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/3.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Lịch sử đặt hàng',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {

                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 27,
                                  width: 27,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/4.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Đăng xuất',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(height: 10,),
                  ],
                ),
              ),

            ),

            Container(height: 15,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {

                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/5.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nộp đơn tài xế với Masu',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/5.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Đăng ký bán hàng trên Masu',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/6.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Trung tâm trợ giúp',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/8.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: GestureDetector(
                                  child: Container(
                                      width: (screenWidth-30)/3*2,
                                      height: 60,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Điều khoản và phiên bản',
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 32, 32, 32),
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  ),
                                  onTap: () {

                                  },
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {

                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 15,
                                left: 0,
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/iconaccinfo/7.png')
                                      )
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Yêu cầu xóa tài khoản',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 32, 32, 32),
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/righticon.png')
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(height: 10,),
                  ],
                ),
              ),

            ),

            Container(height: 50,),

          ],
        ),
      ),
    );
  }
}
