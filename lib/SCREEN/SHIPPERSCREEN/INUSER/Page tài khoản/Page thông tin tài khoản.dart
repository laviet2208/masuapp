import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20v%C3%AD%20ti%E1%BB%81n/Page%20v%C3%AD%20ti%E1%BB%81n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Th%C3%B4ng%20tin%20t%C3%A0i%20kho%E1%BA%A3n/N%E1%BA%A1p%20ti%E1%BB%81n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Th%C3%B4ng%20tin%20t%C3%A0i%20kho%E1%BA%A3n/R%C3%BAt%20ti%E1%BB%81n.dart';

import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/NormalUser/Area.dart';
import '../../../../GENERAL/Tool/Tool.dart';
import '../../../../GENERAL/utils/utils.dart';
import '../../../BEFORE/Page tìm kiếm.dart';
import '../../../BEFORE/SCREEN_firstloading.dart';
import '../../../HISTORY/SCREENhistory.dart';
import '../../../INUSER/PAGE_ACCOUNTINFO/Chỉnh sửa thông tin cá nhân.dart';
import '../../../INUSER/Điều khoản và dịch vụ.dart';

class Pagethongtintaikhoan extends StatefulWidget {
  const Pagethongtintaikhoan({Key? key}) : super(key: key);

  @override
  State<Pagethongtintaikhoan> createState() => _PagethongtintaikhoanState();
}

class _PagethongtintaikhoanState extends State<Pagethongtintaikhoan> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  final List<Area> areaList = [];
  void getData2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        if (area.status == 0) {
          areaList.add(area);
        }
      });
      setState(() {

      });
    });
  }
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + currentAccount.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }
  Future<void> pushData1(String id) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + '/Area').set(id);
      toastMessage('Xác nhận vị trí thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
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
    getData1();
    getData2();
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
                  height: (screenWidth - 20)/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [finalData.shipper_account.onlineStatus == 1 ? Colors.yellow.shade700 : Colors.black26,finalData.shipper_account.onlineStatus == 1 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                    ),
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
                                color: Colors.white
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
                            currentAccount.name,
                            style: TextStyle(
                                fontSize: 160,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto',
                                color: Colors.white
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
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/image/phoneicon.png')
                                      )
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
                                      (currentAccount.phoneNum[0] == '0') ? currentAccount.phoneNum : ('0' + currentAccount.phoneNum),
                                      style: TextStyle(
                                          fontSize: 160,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'roboto',
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Container(
                            height: 25,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),

                                Container(
                                  width: 10,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 5,bottom: 5),
                                  child: Container(
                                    width: screenWidth/3 * 2,
                                    child: AutoSizeText(
                                      getStringNumber(currentAccount.totalMoney) + 'đ',
                                      style: TextStyle(
                                          fontSize: 160,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'roboto',
                                          color: Colors.white
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
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Viewpersonalinfo(type: 2,)));
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
                          toastMessage('Bạn không thể tự đổi khu vực');
                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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
                                  left: 5,
                                  child: Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 30,
                                    color: Colors.redAccent,

                                  )
                              ),

                              Positioned(
                                top: 0,
                                left: 60,
                                child: Container(
                                    width: (screenWidth-30)/3*2,
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Ví tiền của tôi',
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Pagevitien()));
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

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () async {
                          await _auth.signOut();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SCREENfirstloading()), (route) => false,);
                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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
                                  left: 5,
                                  child: Icon(
                                    Icons.policy_outlined,
                                    size: 30,
                                    color: Colors.redAccent,
                                  )
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
                                    Navigator.push(context, MaterialPageRoute(builder:(context) => Dieukhoandichvu(type: 2,)));
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
                          await _auth.signOut();
                          toastMessage("you delete account request will be sent, you can wait 6-7 days");
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SCREENfirstloading()), (route) => false,);
                        },
                        child: Container(
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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

            Container(height: 15,),
          ],
        ),
      ),
    );
  }
}
