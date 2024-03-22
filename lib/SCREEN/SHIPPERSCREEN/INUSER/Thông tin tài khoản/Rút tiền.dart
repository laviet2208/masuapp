import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/Page%20v%C3%AD%20ti%E1%BB%81n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Th%C3%B4ng%20tin%20t%C3%A0i%20kho%E1%BA%A3n/yeucauruttien.dart';

import '../SCREEN_MAIN/SCREENmain.dart';

class ScreenRutTien extends StatefulWidget {
  const ScreenRutTien({Key? key}) : super(key: key);

  @override
  State<ScreenRutTien> createState() => _ScreenRutTienState();
}

class _ScreenRutTienState extends State<ScreenRutTien> {
  final stk = TextEditingController();
  final chutk = TextEditingController();
  final nganhang = TextEditingController();
  final sotien = TextEditingController();

  Future<void> pushData(withdrawRequest request) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("withdrawRequest/" + request.id).set(request.toJson());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: GestureDetector(
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

                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Pagevitien()));
                        },
                      ),
                    ),

                    Positioned(
                      bottom: 20,
                      left: 70,
                      right: 70,
                      child: Container(
                        height: 20,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Yêu cầu rút tiền',
                          style: TextStyle(
                              fontFamily: 'arial',
                              fontSize: 100,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),
                        ),
                      ),
                    )
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
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20 , bottom: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Vui lòng điền đầy đủ các thông tin bên dưới , hệ thống sẽ kiểm tra và xử lí yêu cầu rút tiền của bạn trong tối đa 24h',
                            style: TextStyle(
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                        ),

                        Container(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Số tài khoản',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                                fontWeight: FontWeight.normal
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
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Form(
                                  child: TextFormField(
                                    controller: stk,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập đúng số tài khoản',
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

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Tên ngân hàng',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                                fontWeight: FontWeight.normal
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
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Form(
                                  child: TextFormField(
                                    controller: nganhang,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập đúng tên ngân hàng nhận',
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

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Chủ tài khoản',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                                fontWeight: FontWeight.normal
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
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Form(
                                  child: TextFormField(
                                    controller: chutk,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập đúng tên chủ tài khoản',
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

                        Container(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Số tiền muốn rút',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'arial',
                                fontWeight: FontWeight.normal
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
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Form(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: sotien,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'arial',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập đúng số tiền muốn rút',
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

                        Container(height: 25,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: GestureDetector(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 244, 164, 84)
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: 15,left: 20, right: 20, bottom: 15),
                                child: AutoSizeText(
                                  'Gửi yêu cầu',
                                  style: TextStyle(
                                      fontSize: 100,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (nganhang.text.isNotEmpty && chutk.text.isNotEmpty && sotien.text.isNotEmpty && stk.text.isNotEmpty) {
                                if (double.parse(sotien.text.toString()) > 0 && double.parse(sotien.text.toString()) < currentAccount.totalMoney) {
                                  withdrawRequest request = withdrawRequest(
                                      id: generateID(15),
                                      nganhang: nganhang.text.toString(),
                                      chutk: chutk.text.toString(),
                                      sotien: double.parse(sotien.text.toString()),
                                      stk: stk.text.toString(),
                                      owner: currentAccount
                                  );
                                  await pushData(request);
                                  toastMessage('Gửi yêu cầu thành công');
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => Pagevitien()));
                                } else {
                                  toastMessage('Số tiền phải > 0 và < số tiền hiện tại');
                                }

                              } else {
                                toastMessage('Bạn phải điền đủ các mục');
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
