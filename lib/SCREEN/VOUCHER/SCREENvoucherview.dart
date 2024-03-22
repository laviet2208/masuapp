import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/Product/Voucher.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'ITEMvoucherview.dart';

class SCREENvoucherview extends StatefulWidget {
  const SCREENvoucherview({Key? key}) : super(key: key);

  @override
  State<SCREENvoucherview> createState() => _SCREENvoucherviewState();
}

class _SCREENvoucherviewState extends State<SCREENvoucherview> {
  final List<Voucher> voucherList = [];
  void getVoucherData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        Voucher voucher = Voucher.fromJson(value);
        if (voucher.LocationId == currentAccount.Area) {
          voucherList.add(voucher);
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVoucherData();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight,

                child: ListView(
                  children: [
                    Container(
                      height: screenHeight/8 + 60,
                      width: screenWidth,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              height: screenHeight/6,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 244, 164, 84)
                              ),

                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 40,
                                    left: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/image/backicon1.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: screenHeight/8,
                            left: 10,
                            child: GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                height: 60,
                                width: screenWidth - 20,
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
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 15,
                                      left: 10,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/image/linhtinh4.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 50,
                                      child: Text(
                                        'Kho voucher Masu',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          height: screenHeight - 10 - screenHeight/4,
                          decoration: BoxDecoration(

                          ),
                          child: GridView.builder(
                            itemCount: voucherList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // số phần tử trên mỗi hàng
                              mainAxisSpacing: 0, // khoảng cách giữa các hàng
                              crossAxisSpacing: 0, // khoảng cách giữa các cột
                              childAspectRatio: 3.2, // tỷ lệ chiều rộng và chiều cao
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                                child: InkWell(
                                  onTap: () {

                                  },
                                  child: ITENvoucherview(voucher: voucherList[index], width: screenWidth - 20, height: screenWidth/2,),
                                ),
                              );
                            },
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
