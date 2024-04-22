import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/account_screen/policy_screen/policy_and_services_screen.dart';
import '../../../Data/areaData/Area.dart';
import '../../loginScreen/loading_screen.dart';
import 'change_account_user_info/change_account_user_info.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOutWithPhoneNumberOTP() async {
    try {
      // Kiểm tra nếu người dùng đã đăng nhập bằng số điện thoại OTP
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.providerData.any((info) => info.providerId == 'phone')) {
        // Nếu đăng nhập bằng số điện thoại OTP, thực hiện đăng xuất
        await FirebaseAuth.instance.signOut();
        print('Đăng xuất thành công!');
      } else {
        print('Không tìm thấy tài khoản đăng nhập bằng số điện thoại OTP.');
      }
    } catch (e) {
      print('Đăng xuất thất bại: $e');
    }
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
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
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
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 20,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => change_account_user_info(),),);
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
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
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
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: GestureDetector(
                    //     child: Container(
                    //       height: 60,
                    //       decoration: BoxDecoration(
                    //         color: Colors.transparent,
                    //       ),
                    //       child: Stack(
                    //         children: <Widget>[
                    //           Positioned(
                    //             top: 15,
                    //             left: 0,
                    //             child: Container(
                    //               height: 29,
                    //               width: 29,
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       fit: BoxFit.cover,
                    //                       image: AssetImage('assets/image/iconaccinfo/3.png')
                    //                   )
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             left: 60,
                    //             child: Container(
                    //                 width: (screenWidth-30)/3*2,
                    //                 height: 60,
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Text(
                    //                   'Lịch sử đặt hàng',
                    //                   style: TextStyle(
                    //                       fontFamily: 'arial',
                    //                       fontSize: 15,
                    //                       color: Color.fromARGB(255, 32, 32, 32),
                    //                       fontWeight: FontWeight.bold
                    //                   ),
                    //                 )
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             right: 0,
                    //             bottom: 0,
                    //             child: Container(
                    //               width: 20,
                    //               alignment: Alignment.center,
                    //               child: Icon(
                    //                 Icons.chevron_right,
                    //                 color: Colors.black,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     onTap: () {
                    //
                    //     },
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: Container(
                    //     height: 2,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey,
                    //         borderRadius: BorderRadius.circular(20)
                    //     ),
                    //   ),
                    // ),
                    //
                    // Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {
                          await _auth.signOut();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
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
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 20,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
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
                    // Container(height: 10,),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: GestureDetector(
                    //     child: Container(
                    //       height: 60,
                    //       decoration: BoxDecoration(
                    //         color: Colors.transparent,
                    //       ),
                    //       child: Stack(
                    //         children: <Widget>[
                    //           Positioned(
                    //             top: 15,
                    //             left: 0,
                    //             child: Container(
                    //               height: 29,
                    //               width: 29,
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       fit: BoxFit.cover,
                    //                       image: AssetImage('assets/image/iconaccinfo/5.png')
                    //                   )
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             left: 60,
                    //             child: Container(
                    //                 width: (screenWidth-30)/3*2,
                    //                 height: 60,
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Text(
                    //                   'Đăng ký bán hàng trên Masu',
                    //                   style: TextStyle(
                    //                       fontFamily: 'arial',
                    //                       fontSize: 15,
                    //                       color: Color.fromARGB(255, 32, 32, 32),
                    //                       fontWeight: FontWeight.bold
                    //                   ),
                    //                 )
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             right: 0,
                    //             bottom: 0,
                    //             child: Container(
                    //               width: 20,
                    //               alignment: Alignment.center,
                    //               child: Icon(
                    //                 Icons.chevron_right,
                    //                 color: Colors.black,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: Container(
                    //     height: 2,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey,
                    //         borderRadius: BorderRadius.circular(20)
                    //     ),
                    //   ),
                    // ),

                    // Container(height: 10,),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: GestureDetector(
                    //     child: Container(
                    //       height: 60,
                    //       decoration: BoxDecoration(
                    //         color: Colors.transparent,
                    //       ),
                    //       child: Stack(
                    //         children: <Widget>[
                    //           Positioned(
                    //             top: 15,
                    //             left: 0,
                    //             child: Container(
                    //               height: 29,
                    //               width: 29,
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       fit: BoxFit.cover,
                    //                       image: AssetImage('assets/image/iconaccinfo/6.png')
                    //                   )
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             left: 60,
                    //             child: Container(
                    //                 width: (screenWidth-30)/3*2,
                    //                 height: 60,
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Text(
                    //                   'Trung tâm trợ giúp',
                    //                   style: TextStyle(
                    //                       fontFamily: 'arial',
                    //                       fontSize: 15,
                    //                       color: Color.fromARGB(255, 32, 32, 32),
                    //                       fontWeight: FontWeight.bold
                    //                   ),
                    //                 )
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             right: 0,
                    //             bottom: 0,
                    //             child: Container(
                    //               width: 20,
                    //               alignment: Alignment.center,
                    //               child: Icon(
                    //                 Icons.chevron_right,
                    //                 color: Colors.black,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: Container(
                    //     height: 2,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey,
                    //         borderRadius: BorderRadius.circular(20)
                    //     ),
                    //   ),
                    // ),
                    //
                    // Container(height: 10,),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: GestureDetector(
                    //     child: Container(
                    //       height: 60,
                    //       decoration: BoxDecoration(
                    //         color: Colors.transparent,
                    //       ),
                    //       child: Stack(
                    //         children: <Widget>[
                    //           Positioned(
                    //             top: 15,
                    //             left: 0,
                    //             child: Container(
                    //               height: 29,
                    //               width: 29,
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       fit: BoxFit.cover,
                    //                       image: AssetImage('assets/image/iconaccinfo/8.png')
                    //                   )
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             left: 60,
                    //             child: GestureDetector(
                    //               child: Container(
                    //                   width: (screenWidth-30)/3*2,
                    //                   height: 60,
                    //                   alignment: Alignment.centerLeft,
                    //                   child: Text(
                    //                     'Điều khoản và phiên bản',
                    //                     style: TextStyle(
                    //                         fontFamily: 'arial',
                    //                         fontSize: 15,
                    //                         color: Color.fromARGB(255, 32, 32, 32),
                    //                         fontWeight: FontWeight.bold
                    //                     ),
                    //                   )
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           Positioned(
                    //             top: 0,
                    //             right: 0,
                    //             bottom: 0,
                    //             child: Container(
                    //               width: 20,
                    //               alignment: Alignment.center,
                    //               child: Icon(
                    //                 Icons.chevron_right,
                    //                 color: Colors.black,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => policy_and_services_screen(),),);
                    //     },
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: Container(
                    //     height: 2,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey,
                    //         borderRadius: BorderRadius.circular(20)
                    //     ),
                    //   ),
                    // ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {
                          await _auth.signOut();
                          toastMessage('Yêu cầu xóa tài khoản thành công, vui lòng đợi hệ thống xét duyệt');
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
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
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 20,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
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
