import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/NormalUser/accountNormal.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Th%C3%B4ng%20tin%20t%C3%A0i%20kho%E1%BA%A3n/R%C3%BAt%20ti%E1%BB%81n.dart';
import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/utils/utils.dart';
import '../PAGE_HISTORY/PAGEhistory.dart';
import '../SCREEN_NOTICE/SCREENnotice.dart';
import '../SCREENhistory/SCREENhistory.dart';
import 'Nạp tiền.dart';

class PAGEaccountinfo extends StatefulWidget {
  const PAGEaccountinfo({Key? key}) : super(key: key);

  @override
  State<PAGEaccountinfo> createState() => _PAGEaccountinfoState();
}

class _PAGEaccountinfoState extends State<PAGEaccountinfo> {
  String avaID = 'https://firebasestorage.googleapis.com/v0/b/rabbitshipping-fa875.appspot.com/o/image%2Favatar_no_image.png?alt=media&token=f36e0d5d-6eab-48d1-9e20-e6778e01037e';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (currentAccount.avatarID == 'NA') {
      avaID = 'https://firebasestorage.googleapis.com/v0/b/rabbitshipping-fa875.appspot.com/o/image%2Favatar_no_image.png?alt=media&token=f36e0d5d-6eab-48d1-9e20-e6778e01037e';
    } else {
      avaID = currentAccount.avatarID;
    }
  }

  Future<bool> getData(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('bikeRequest').once();
    bool ch = false;
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      catchOrderData.forEach((key, value) {
        if (accountNormal.fromJson(value['owner']).id == id) {
          ch = true;
        }
      }
      );
    }
    return ch;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
              ),

              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 15,
                    left: 20,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2), // màu của shadow
                              spreadRadius: 5, // bán kính của shadow
                              blurRadius: 7, // độ mờ của shadow
                              offset: Offset(0, 3), // vị trí của shadow
                            ),
                          ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(avaID)
                        )
                      ),
                    ),
                  ),

                  Positioned(
                    top: 30,
                    left: 145,
                    child: Text(
                      currentAccount.name,
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),

                  Positioned(
                      top: 60,
                      left: 145,
                      child: Text(
                        'Số dư : ' + getStringNumber(currentAccount.totalMoney) + ' đ',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                        ),
                      )
                  ),
                ],
              ),
            ),

            Container(height: 10,),

            //Phần Lịch sử
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Lịch sử Rabit',
                  style: TextStyle(
                      fontFamily: 'arial',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),

            Container(height: 20,),

            ///Lịch sử bắt xe
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistory()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Lịch sử đơn hàng',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Container(height: 50,),

            //Phần tính năng
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Tính năng',
                  style: TextStyle(
                      fontFamily: 'arial',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),

            Container(height: 20,),

            ///Thông báo
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => ScreenNotice()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Thông báo',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            ///chăm sóc khách hàng
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Liên hệ CSKH',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENnaptien()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nạp tiền',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => ScreenRutTien()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rút tiền',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Container(height: 50,),

            //Phần tài khoản của tôi
            Padding(
              padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Tài khoản của tôi',
                  style: TextStyle(
                      fontFamily: 'arial',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  toastMessage('tính năng đang phát triển');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ưu đãi cho thành viên',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  toastMessage('tính năng đang phát triển');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Yêu thích',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  toastMessage('tính năng đang phát triển');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phường thức thanh toán',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  toastMessage('tính năng đang phát triển');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Đã đặt trước',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  toastMessage('tính năng đang phát triển');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Số liên hệ S.O.S',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: GestureDetector(
                onTap: () {
                  toastMessage('tính năng đang phát triển');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(

                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: (screenWidth-30)/3*2,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Hồ sơ doanh nghiệp',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontWeight: FontWeight.normal
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
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
