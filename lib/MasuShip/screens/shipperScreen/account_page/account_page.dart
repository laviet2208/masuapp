import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/areaData/Area.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/loading_screen.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/account_page/change_account_shipper_info.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/account_page/policy_and_services_page/policy_and_services_page.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/account_page/wallet_page/wallet_page.dart';

import '../../../Data/otherData/Tool.dart';
import '../../../Data/otherData/utils.dart';

class account_page extends StatefulWidget {
  const account_page({Key? key}) : super(key: key);

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  Area area = Area(id: '', name: '', money: 0, status: 1);
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
  void get_data_area() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + finalData.shipper_account.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data_area();
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
                    gradient: LinearGradient(
                        colors: [finalData.shipper_account.onlineStatus == 1 ? Colors.yellow.shade700 : Colors.black26,finalData.shipper_account.onlineStatus == 1 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                    borderRadius: BorderRadius.circular(20),
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
                                color: finalData.shipper_account.onlineStatus == 1 ? Colors.black : Colors.white
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
                            finalData.shipper_account.name,
                            style: TextStyle(
                                fontSize: 160,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto',
                                color: finalData.shipper_account.onlineStatus == 1 ? Colors.black : Colors.white
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
                                    color: finalData.shipper_account.onlineStatus == 1 ? Colors.black : Colors.white,
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
                                      (finalData.shipper_account.phone[0] == '0') ? finalData.shipper_account.phone : ('0' + finalData.shipper_account.phone),
                                      style: TextStyle(
                                        fontSize: 160,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'roboto',
                                        color: finalData.shipper_account.onlineStatus == 1 ? Colors.black : Colors.white,
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
                                  Icons.attach_money,
                                  color: finalData.shipper_account.onlineStatus == 1 ? Colors.black : Colors.white,
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
                                      getStringNumber(finalData.shipper_account.money) + 'đ',
                                      style: TextStyle(
                                        fontSize: 160,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'roboto',
                                        color: finalData.shipper_account.onlineStatus == 1 ? Colors.black : Colors.white,
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
                                  child: Icon(
                                    Icons.manage_accounts_outlined,
                                    color: Colors.redAccent,
                                    size: 25,
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => change_account_shipper_info()));
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 1,
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
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.redAccent,
                                    size: 25,
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
                        height: 1,
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
                                    Icons.wallet_travel_rounded,
                                    size: 25,
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => wallet_page()));
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 1,
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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
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
                                  child: Icon(
                                    Icons.login_outlined,
                                    color: Colors.redAccent,
                                    size: 25,
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
                                    size: 25,
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
                                    Navigator.push(context, MaterialPageRoute(builder:(context) => policy_and_services_page()));
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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
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
