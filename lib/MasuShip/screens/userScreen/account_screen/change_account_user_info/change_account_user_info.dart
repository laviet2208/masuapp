import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../../Data/otherData/utils.dart';
import '../../main_screen/user_main_screen.dart';

class change_account_user_info extends StatefulWidget {
  const change_account_user_info({super.key});

  @override
  State<change_account_user_info> createState() => _change_account_user_infoState();
}

class _change_account_user_infoState extends State<change_account_user_info> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  bool loading = false;

  Future<void> change_data(String name) async {
    finalData.user_account.name = name;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Account/" + finalData.user_account.id + "/name").set(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = finalData.user_account.name;
    if (finalData.user_account.phone[0] == '0') {
      phonecontroller.text = finalData.user_account.phone;
    } else {
      phonecontroller.text = '0' + finalData.user_account.phone;
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
                            Navigator.push(context, MaterialPageRoute(builder:(context) => user_main_screen()));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 20,
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
                                fontFamily: 'roboto',
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
                                  fontFamily: 'roboto',
                                  color: Colors.black
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
                                  fontFamily: 'roboto',
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
                                      fontFamily: 'roboto',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập họ và tên của bạn',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: 'roboto',
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
                                  fontFamily: 'roboto',
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
                                    fontFamily: 'roboto',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập họ và tên của bạn',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'roboto',
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
                  child: GestureDetector(
                      child: !loading ? Container(height: 50, decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(10)), alignment: Alignment.center, child: Text('Lưu thông tin', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),),) : CircularProgressIndicator(color: Colors.black,),
                      onTap: () async {
                        if (namecontroller.text.isNotEmpty) {
                          if (namecontroller.text.toString() != finalData.shipper_account.name) {
                            toastMessage('Vui lòng đợi');
                            setState(() {
                              loading = true;
                            });
                            await change_data(namecontroller.text.toString());
                            toastMessage('Cập nhật tên thành công');
                            setState(() {
                              loading = true;
                            });
                          } else {
                            toastMessage('Bạn chưa nhập tên mới');
                          }
                        } else {
                          toastMessage('Bạn cần điền tên');
                        }
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
          return true;
        }
    );  }
}
