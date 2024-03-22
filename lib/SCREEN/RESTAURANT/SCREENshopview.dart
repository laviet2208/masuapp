import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Product/Danh%20m%E1%BB%A5c%20%C4%91%E1%BB%93%20%C4%83n.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_HOME/T%C3%ADnh%20kho%E1%BA%A3ng%20c%C3%A1ch.dart';
import 'SCREENfoodcart.dart';
import '../../GENERAL/Product/Product.dart';
import '../../GENERAL/ShopUser/accountShop.dart';
import '../../GENERAL/Tool/Time.dart';
import '../../GENERAL/utils/utils.dart';
import 'Quản lý danh mục/Item danh mục món ăn.dart';
import 'SCREENshopmain.dart';

class SCREENshopview extends StatefulWidget {
  final String currentShop;
  const SCREENshopview({Key? key, required this.currentShop}) : super(key: key);

  @override
  State<SCREENshopview> createState() => _SCREENshopmainState();
}

class _SCREENshopmainState extends State<SCREENshopview> {
  List<Product> productList = [];
  List<FoodDirectory> foodDirecList = [];
  List<FoodDirectory> chosenList = [];
  FoodDirectory chosenDirectory = FoodDirectory(id: '', mainName: '', foodList: [], ownerID: '');
  double total1 = 0;
  String totalText = '0 .đ';
  accountShop selectShop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  int SelectIndex = 0;

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant/" + widget.currentShop).onValue.listen((event) {
      final dynamic restaurant = event.snapshot.value;
        accountShop pro = accountShop.fromJson(restaurant);
        selectShop.avatarID = pro.avatarID;
        selectShop.id = pro.id;
        selectShop.name = pro.name;
        selectShop.ListDirectory = pro.ListDirectory;
        selectShop.Type = pro.Type;
        selectShop.createTime = pro.createTime;
        selectShop.closeTime = pro.closeTime;
        selectShop.location = pro.location;
        selectShop.phoneNum = pro.phoneNum;
        setState(() {

        });
    });
  }

  void getData1()  {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("FoodDirectory").onValue.listen((event) {
      foodDirecList.clear();
      chosenList.clear();
      foodDirecList.add(FoodDirectory(id: 'all', mainName: 'Tất cả', foodList: [], ownerID: ''));
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        FoodDirectory acc = FoodDirectory.fromJson(value);
        if (acc.ownerID == widget.currentShop) {
          foodDirecList.add(acc);
          chosenList.add(acc);
        }

        setState(() {
          chosenDirectory = foodDirecList.first;
        });
      });

    });
  }

  List<int> parseDateString(String dateString) {
    List<String> parts = dateString.split('/');
    if (parts.length != 3) {

    }

    int day = int.parse(parts[0]) ?? 0;
    int month = int.parse(parts[1]) ?? 0;
    int year = int.parse(parts[2]) ?? 0;

    return [day, month, year];
  }

  String formatTime(int hour, int minute, int second) {
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour giờ $formattedMinute phút';
  }

  void updateTotalText() {
    // Gọi setState để cập nhật giao diện
    setState(() {});
  }

  void dropdownCallback(FoodDirectory? selectedValue) {
    if (selectedValue is FoodDirectory) {
      chosenDirectory = selectedValue;
      if (chosenDirectory.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < foodDirecList.length ; i++) {
          if (foodDirecList.elementAt(i).id != 'all') {
            chosenList.add(foodDirecList.elementAt(i));
            setState(() {

            });
          }

        }
        setState(() {

        });
      } else {
        chosenList.clear();
        setState(() {

        });
        for(int i = 0 ; i < foodDirecList.length ; i++) {
          if (foodDirecList.elementAt(i).id == chosenDirectory.id) {
            chosenList.add(foodDirecList.elementAt(i));
            print(chosenList.first.toJson().toString());
            print(chosenList.length);
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

    }

    setState(() {

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectShop.id = widget.currentShop;
    getData();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    total1 = 0;
    for (int i = 0 ; i < cartList.length ; i++) {
      total1 = total1 + cartList[i].cost;
    }
    totalText = getStringNumber(total1) + ' .đ';

    return WillPopScope(
      child: Scaffold(
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
                      height: screenWidth,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(selectShop.avatarID)
                          )
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 40,
                            left: 10,
                            child: GestureDetector(
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/image/backicon1.png')
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENshopmain()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenWidth/5*3,
                    left: 0,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight - (screenWidth/5*3) - 80,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(height: 20,),

                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(

                              ),
                              child: AutoSizeText(
                                selectShop.name,
                                style: TextStyle(
                                    fontFamily: 'DMSans_regu',
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(

                              ),
                              child: AutoSizeText(
                                selectShop.location,
                                style: TextStyle(
                                    fontFamily: 'DMSans_regu',
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),

                          Container(height: 10,),

                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(

                              ),
                              child: AutoSizeText(
                                'Cách bạn ' + CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(selectShop.location)[0], CaculateDistance.parseDoubleString(selectShop.location)[1], currentAccount.locationHis.Latitude, currentAccount.locationHis.Longitude).toStringAsFixed(2).toString() + ' Km',
                                style: TextStyle(
                                    fontFamily: 'DMSans_regu',
                                    fontSize: 100,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),

                          Container(height: 20,),

                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              height: 40,
                              child: DropdownButton<FoodDirectory>(
                                items: foodDirecList.map((e) => DropdownMenuItem<FoodDirectory>(
                                  value: e,
                                  child: Text(e.mainName),
                                )).toList(),
                                onChanged: (value) { dropdownCallback(value); },
                                value: chosenDirectory,
                                iconEnabledColor: Colors.redAccent,
                                isExpanded: true,
                                iconDisabledColor: Colors.grey,
                              ),
                            ),
                          ),

                          Container(height: 20,),

                          Container(
                            height: 340 * chosenList.length.toDouble(),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: chosenList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ITEMdanhsachmonan(width: screenWidth, height: 340, foodDirectory: chosenList[index], ontap: () { setState(() {
                                    total1 = 0;
                                    for (int i = 0 ; i < cartList.length ; i++) {
                                      total1 = total1 + cartList[i].cost;
                                    }
                                    totalText = getStringNumber(total1) + ' .đ';
                                  }); }, shop: selectShop,);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      child: Container(
                        width: screenWidth,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 10,
                              left: 10,
                              child: GestureDetector(
                                child: Container(
                                  width: screenWidth - 20,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 244, 164, 84),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 20,
                                        left: 20,
                                        child: Container(
                                          width: screenWidth - 20 - 40,
                                          height: 20,
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                                color: Colors.white,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Giỏ hàng   |  ',
                                                ),
                                                TextSpan(
                                                  text: cartList.length.toString() + ' món',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.normal, // Cài đặt FontWeight.normal cho "món"
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 20,
                                        right: 20,
                                        child: Container(
                                          width: screenWidth - 20 - 40,
                                          height: 20,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            totalText,
                                            style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (cartList.length == 0) {
                          toastMessage('Giỏ hàng chưa có sản phẩm nào');
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENfoodcart()));
                        }
                      },
                    ),
                  ),
                ],
              )
          )
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
