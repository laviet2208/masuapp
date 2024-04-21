import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import '../../Data/otherData/utils.dart';
import '../userScreen/main_screen/user_main_screen.dart';

class enter_name_screen extends StatefulWidget {
  const enter_name_screen({Key? key}) : super(key: key);

  @override
  State<enter_name_screen> createState() => _enter_name_screenState();
}

class _enter_name_screenState extends State<enter_name_screen> {
  final nameController = TextEditingController();
  bool loading = false;

  Future<void> pushData(String name) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Account").child(finalData.user_account.id).child('name').set(name);
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
                  fontFamily: "muli",
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
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: screenWidth/22,
                        fontFamily: 'muli',
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
                          fontFamily: 'muli',
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Bạn thích mọi người gọi bằng tên gì?',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'muli',
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
                            fontFamily: 'muli',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'Điều khoản dịch vụ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: screenWidth / 26,
                            fontFamily: 'muli',
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
                            fontFamily: 'muli',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'Thông Báo Bảo Mật',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: screenWidth / 26,
                            fontFamily: 'muli',
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
                            fontFamily: 'muli',
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
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                      ),
                      child: Center(
                        child: !loading ? Text(
                          'Tôi chọn tên này',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ) : CircularProgressIndicator(color: Colors.black,),
                      ),
                    ),

                    onTap: () async {
                      if (nameController.text.isNotEmpty) {
                        setState(() {
                          loading = true;
                        });

                        finalData.account.name = nameController.text.toString();
                        await pushData(nameController.text.toString());

                        setState(() {
                          loading = false;
                        });

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
                      } else {
                        toastMessage("Bạn cần đặt tên biệt danh của mình");
                      }
                    },
                  )
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
