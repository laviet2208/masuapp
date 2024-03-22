import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/utils/utils.dart';
import '../../OTHER/Button/Buttontype1.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'SCREEN_selectLocation.dart';

class SCREENentername extends StatefulWidget {
  const SCREENentername({Key? key}) : super(key: key);

  @override
  State<SCREENentername> createState() => _SCREENenternameState();
}

class _SCREENenternameState extends State<SCREENentername> {
  final nameController = TextEditingController();
  bool loading = false;

  Future<void> pushData(String name) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("normalUser/" + currentAccount.id + "/name").set(name);
  }

  Future<void> changeStatus(int status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("normalUser/" + currentAccount.id + "/status").set(status);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0, // Xóa phần shadow giữa AppBar và body
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            centerTitle: true, // Căn giữa dòng chữ trong AppBar
            title: Container(
              child: Text(
                'Bắt đầu',
                style: TextStyle(
                  fontFamily: "arial",
                  fontSize: screenWidth / 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),


          body: Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),

            child: ListView(
              children: [
                Container(
                  height: 50,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Tên",
                    style: TextStyle(
                        color: Color.fromARGB(255, 115, 115, 115),
                        fontSize: screenWidth/22,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(
                  height: 5,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: Colors.blueGrey,
                            )
                        )
                    ),
                    child: Form(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'arial',
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Bạn thích mọi người gọi bằng tên gì?',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: screenWidth/4,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bằng cách tiếp tục, bạn xác nhận rằng bạn đã đọc và đồng ý với ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 115, 115, 115),
                            fontSize: screenWidth / 26,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'Điều khoản dịch vụ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: screenWidth / 26,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Xử lý khi người dùng nhấp vào "Điều khoản dịch vụ"
                            },
                        ),
                        TextSpan(
                          text: ' và ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 115, 115, 115),
                            fontSize: screenWidth / 26,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'Thông Báo Bảo Mật',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: screenWidth / 26,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Xử lý khi người dùng nhấp vào "Thông Bán Bảo Mật"
                            },
                        ),
                        TextSpan(
                          text: ' của chúng tôi',
                          style: TextStyle(
                            color: Color.fromARGB(255, 115, 115, 115),
                            fontSize: screenWidth / 24,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ButtonType1(Height: 50, Width: screenWidth - 50, color: Color.fromARGB(255, 244, 164, 84), radiusBorder: 10, title: "Tiếp tục", fontText: 'arial', colorText: Colors.white,
                    onTap: () async {
                       if (nameController.text.isNotEmpty) {
                         setState(() {
                           loading = true;
                         });
                         currentAccount.status = 1;
                         currentAccount.name = nameController.text.toString();
                         await pushData(nameController.text.toString());
                         await changeStatus(1);
                         setState(() {
                           loading = false;
                         });
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENselectLocation(),),);
                       } else {
                         toastMessage("Bạn cần đặt tên biệt danh của mình");
                       }
                    }, loading: loading,),
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
