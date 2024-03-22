import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Page%20L%E1%BB%8Bch%20s%E1%BB%AD.dart';
import '../../../../FINAL/finalClass.dart';
import '../PAGE_COMMINGSOON/PAGEcommingsoon.dart';
import '../PAGE_FOOD/PAGEfood.dart';
import '../PAGE_HISTORY/PAGEhistory.dart';
import '../PAGE_HOME/PAGEhome.dart';
import '../PAGE_itemsend/PAGEitemsend.dart';
import '../Page thông báo/PageNotification.dart';
import '../Page tài khoản/Page thông tin tài khoản.dart';

class SCREENmainshipping extends StatefulWidget {
  const SCREENmainshipping({Key? key}) : super(key: key);

  @override
  State<SCREENmainshipping> createState() => _SCREENmainState();
}

class _SCREENmainState extends State<SCREENmainshipping> {
  int selectedIndex = 0;
  String title = 'Đơn xe ôm , taxi';

  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + '/WorkStatus').set(status);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Widget getBodyWidget() {
    // Dựa vào selectedIndex, trả về phần body tương ứng
    switch (selectedIndex) {
      case 0 :
        return PAGEhome();
      case 1 :
        return Pagelichsu();
      case 2 :
        return PageNotification();
      case 3 :
        return Pagethongtintaikhoan();
      default:
        return PAGEcommingsoon();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = currentPage.second;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          appBar: selectedIndex != 0 ?  AppBar(
            backgroundColor: Colors.white,
            title: selectedIndex != 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "roboto",
                    fontSize: screenWidth/19.65,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 244, 164, 84),
                  ),
                ),

                SizedBox(width: screenWidth/5,)
              ],
            ) : null,
          ) : null,


      body: getBodyWidget(),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Color.fromARGB(255, 244, 164, 84),
            tabBackgroundColor: Color.fromARGB(100, 200, 225, 252),
            gap: 8,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                //currentPage.second = index;
                if (index == 0) {
                  title = 'ĐƠN XE ÔM , TAXI';
                }
                if (index == 1) {
                  title = 'Lịch sử';
                }
                if (index == 2) {
                  title = 'ĐƠN ĐỒ ĂN';
                }
                if (index == 3) {
                  title = 'LỊCH SỬ ĐƠN';
                }
                if (index == 4) {
                  title = 'THÔNG TIN TÀI KHOẢN';
                }
              });
            },

            padding: EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.rocket,
                text: ("Trang chủ"),
              ),

              GButton(
                icon: Icons.history,
                text: ("Lịch sử"),
              ),

              GButton(
                icon: Icons.notifications_active_outlined,
                text: ("Thông báo"),
              ),

              GButton(
                icon: Icons.account_circle_sharp,
                text: ("Tài Khoản"),
              ),
            ],
          ),
        ),
      ),

    ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
