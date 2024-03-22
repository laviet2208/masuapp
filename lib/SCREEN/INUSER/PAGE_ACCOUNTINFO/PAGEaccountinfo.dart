import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/NormalUser/accountNormal.dart';


import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/Area.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../BEFORE/Page tìm kiếm.dart';
import '../../BEFORE/SCREEN_firstloading.dart';
import '../../FILL_INFOR/SCREENfillbikerequest.dart';
import '../../HISTORY/SCREENhistory.dart';
import '../../HISTORY/SCREENhistorycatch.dart';
import '../../HISTORY/SCREENhistoryfood.dart';
import '../../HISTORY/SCREENhistorymarket.dart';
import '../../HISTORY/SCREENhistorysend.dart';
import '../Điều khoản và dịch vụ.dart';
import 'Chỉnh sửa thông tin cá nhân.dart';

class PAGEaccountinfo extends StatefulWidget {
  const PAGEaccountinfo({Key? key}) : super(key: key);

  @override
  State<PAGEaccountinfo> createState() => _PAGEaccountinfoState();
}

class _PAGEaccountinfoState extends State<PAGEaccountinfo> {
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
            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: (screenWidth - 20)/2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/bginfo.png')
                  ),
                  borderRadius: BorderRadius.circular(20)
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => Viewpersonalinfo(type: 1,)));
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
                                              compactString(30, area.name),
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
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Chọn khu vực'),
                                                content: Container(
                                                  width: screenWidth - 40,
                                                  height: 200,
                                                  child: searchPageArea(list: areaList, area: area),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Chọn khu vực này'),
                                                    onPressed: () async {
                                                      await pushData1(area.id);
                                                      setState(() {

                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            }
                                        );
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
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENhistory()));
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
                        onTap: () async {
                          if (await getData(currentAccount.id)) {
                            toastMessage('bạn đã gửi yêu cầu rồi vui lòng chờ xác minh');
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfillbikerequest()));
                          }

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
                                top: 10,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
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
                                    Navigator.push(context, MaterialPageRoute(builder:(context) => Dieukhoandichvu(type: 1,)));
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

            Container(height: 50,),

          ],
        ),
      ),
    );
  }
}
