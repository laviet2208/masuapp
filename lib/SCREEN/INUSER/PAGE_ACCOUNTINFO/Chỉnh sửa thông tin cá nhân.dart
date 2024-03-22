import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/OTHER/Button/Buttontype1.dart';

import '../../SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../SCREEN_MAIN/SCREENmain.dart';

class Viewpersonalinfo extends StatefulWidget {
  final int type;
  const Viewpersonalinfo({Key? key, required this.type}) : super(key: key);

  @override
  State<Viewpersonalinfo> createState() => _ViewpersonalinfoState();
}

class _ViewpersonalinfoState extends State<Viewpersonalinfo> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  Future<void> pushData(String name) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("normalUser/" + currentAccount.id + "/name").set(name);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = currentAccount.name;
    if (currentAccount.phoneNum[0] == '0') {
      phonecontroller.text = currentAccount.phoneNum;
    } else {
      phonecontroller.text = '0' + currentAccount.phoneNum;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245)
            ),
            child: ListView(
              children: [
                Container(
                  width: screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // màu của shadow
                          spreadRadius: 5, // bán kính của shadow
                          blurRadius: 7, // độ mờ của shadow
                          offset: Offset(0, 3), // vị trí của shadow
                        ),
                      ],
                      color: Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            if (widget.type == 1) {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
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
                          bottom: 14,
                          left: 60,
                          child: Text(
                            'Thông tin tài khoản',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: 'arial',
                                color: Colors.black
                            ),
                          )
                      ),
                    ],
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 18,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'THÔNG TIN CƠ BẢN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 200,
                                  fontFamily: 'arial',
                                  color: Color.fromARGB(255, 245, 57, 26)
                              ),
                            ),
                          ),
                        ),

                        Container(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.grey
                            ),
                          ),
                        ),

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 17,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'Họ tên',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 200,
                                  fontFamily: 'arial',
                                  color: Color.fromARGB(255, 1, 1, 1)
                              ),
                            ),
                          ),
                        ),

                        Container(height: 10,),

                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey,
                                  )
                              ),

                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Form(
                                  child: TextFormField(
                                    controller: namecontroller,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập họ và tên của bạn',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: 'arial',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),

                        Container(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 17,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'Số điện thoại',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 200,
                                  fontFamily: 'arial',
                                  color: Color.fromARGB(255, 1, 1, 1)
                              ),
                            ),
                          ),
                        ),

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 235, 235, 235),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey,
                                )
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Form(
                                child: TextFormField(
                                  controller: phonecontroller,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'arial',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập họ và tên của bạn',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                  ),
                                  readOnly: true, // Đặt readOnly thành true để khóa chỉnh sửa
                                ),
                              ),
                            ),
                          ),
                        ),


                        Container(height: 20,),

                      ],
                    ),
                  ),
                ),

                Container(height: 20,),
                
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: ButtonType1(Height: 60, Width: 200, color: Color.fromARGB(255, 245, 57, 26), radiusBorder: 200, title: "Lưu thông tin", fontText: 'arial', colorText: Colors.white,
                      onTap: () async {
                         if (namecontroller.text.isNotEmpty) {
                           if (namecontroller.text.toString() != currentAccount.name) {
                             toastMessage('Vui lòng đợi');
                             await pushData(namecontroller.text.toString());
                             toastMessage('Cập nhật tên thành công');
                           } else {
                             toastMessage('Bạn chưa nhập tên mới');
                           }
                         } else {
                           toastMessage('Bạn cần điền tên');
                         }
                      }),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        }
    );
  }
}
