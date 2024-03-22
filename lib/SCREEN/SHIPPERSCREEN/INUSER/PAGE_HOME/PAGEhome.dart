import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Order/itemsendOrder.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91%E1%BB%93%20%C4%83n/Page%20%C4%91%E1%BB%93%20%C4%83n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91i%20ch%E1%BB%A3/Page%20%C4%91i%20ch%E1%BB%A3.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20g%E1%BB%8Di%20xe/Page%20g%E1%BB%8Di%20xe.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20giao%20h%C3%A0ng/Page%20giao%20h%C3%A0ng%20nh%E1%BB%8F.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Th%E1%BB%91ng%20k%C3%AA/Container%20th%E1%BB%91ng%20k%C3%AA.dart';
import '../../../../GENERAL/Order/catchOrder.dart';
import '../../../../GENERAL/Order/foodOrder.dart';
import '../../../../GENERAL/Tool/Time.dart';
import '../../../../GENERAL/utils/utils.dart';
import '../../../INUSER/PAGE_HOME/Tính khoảng cách.dart';
import '../../ITEM/ITEMcatch.dart';


class PAGEhome extends StatefulWidget {
  const PAGEhome({Key? key}) : super(key: key);

  @override
  State<PAGEhome> createState() => _PAGEhomeState();
}

class _PAGEhomeState extends State<PAGEhome> {
  //Chọn loại đơn
  int index = 0;

  //Tổng số đơn hoàn thành trong ngày
  int totalCatch = 0;
  int totalItemSend = 0;
  int totalFood = 0;

  //Tổng số đơn hoàn thành trong ngày 3 mục đầu lưu giao hàng , đồ ăn , đặt xe
  Time nearOrder = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('CCCD').child(imagePath);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + currentAccount.id + '/WorkStatus').set(status);
      if (status == 0) {
        toastMessage('Bạn đang ở trạng thái offline');
      }
      if (status == 1) {
        toastMessage('Bạn đang ở trạng thái online');
      }

    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Widget getContainer(double height, double width) {
    if(index == 0) {
      return Pagegiaohang(height: height, width: width, data: nearOrder, restartEvent: () {
        setState(() {

        });
      });
    }

    if(index == 1) {
      return Pagedoan(height: height, width: width, data: nearOrder, restartEvent: () {
        setState(() {

        });
      });
    }

    if(index == 2) {
      return Pagegoixe(height: height, width: width, data: nearOrder, restartEvent: () {
        setState(() {

        });
      });
    }

    if(index == 3) {
      return Pagedicho(height: height, width: width, data: nearOrder, restartEvent: () {
        setState(() {

        });
      });
    }

    return Container();
  }

  void getDataFood() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/foodOrder").onValue.listen((event) {
      nearOrder.minute = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if (foodorder.status == "B" && CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(foodorder.productList[0].owner.location)[0], CaculateDistance.parseDoubleString(foodorder.productList[0].owner.location)[1], currentLocatio.Latitude, currentLocatio.Longitude) <= 25) {
          nearOrder.minute++;
        }
        setState(() {
          
        });
      });
      setState(() {

      });
    });
  }

  void getDataMarket() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/productOrder").onValue.listen((event) {
      nearOrder.day = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if (foodorder.status == "B" && CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(foodorder.productList[0].owner.location)[0], CaculateDistance.parseDoubleString(foodorder.productList[0].owner.location)[1], currentLocatio.Latitude, currentLocatio.Longitude) <= 25) {
          nearOrder.day++;
        }
        setState(() {
          
        });
      });
      setState(() {

      });
    });
  }

  void getDataCatch() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/catchOrder").orderByChild('owner/Area').equalTo(currentAccount.Area).onValue.listen((event) {
      nearOrder.hour = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        catchOrder catchorder = catchOrder.fromJson(value);
        print(catchorder.toJson().toString());
        if (catchorder.status == "A" && catchorder.owner.Area == currentAccount.Area) {
          if ((currentAccount.type % 2 == 0 && catchorder.type % 2 != 0)) {
            nearOrder.hour++;
          }

          if ((currentAccount.type % 2 != 0 && catchorder.type % 2 == 0)) {
            nearOrder.hour++;
          }
          setState(() {
            
          });
        }
      });
      setState(() {
      });
    });
  }

  void getDataSend() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/itemsendOrder").orderByChild('owner/Area').equalTo(currentAccount.Area).onValue.listen((event) {
      nearOrder.second = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        itemsendOrder itemorder = itemsendOrder.fromJson(value);
        if (itemorder.status == "A" && CaculateDistance.calculateDistance(itemorder.locationset.Latitude, itemorder.locationset.Longitude, currentLocatio.Latitude, currentLocatio.Longitude) <= 25) {
          nearOrder.second++;
        }
        setState(() {

        });
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataCatch();
    getDataFood();
    getDataMarket();
    getDataSend();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [currentAccount.WorkStatus == 1 ? Colors.orangeAccent : Colors.black26,currentAccount.WorkStatus == 1 ? Color.fromARGB(255, 255, 123, 64) : Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          children: [
            Container(height: 50,),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 10,
                      bottom: 10,
                      left: 10,
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(currentAccount.id + '_Ava.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto', fontSize: 10),textAlign: TextAlign.center,),
                              );
                            }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitWidth,);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      top: 10,
                      left: 90,
                      child: Container(
                        width: screenWidth/3,
                        height: 18,
                        child: AutoSizeText(
                          'Tài xế',
                          maxLines: 1,
                          style : TextStyle(
                            fontSize: 100,
                            fontFamily: 'arial',
                            color: Colors.grey
                          )
                        ),
                      ),
                    ),

                    Positioned(
                      top: 32,
                      left: 90,
                      child: Container(
                        width: screenWidth/3,
                        height: 20,
                        child: AutoSizeText(
                            currentAccount.name,
                            maxLines: 1,
                            style : TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'arial'
                            )
                        ),
                      ),
                    ),

                    Positioned(
                      top: 56,
                      left: 90,
                      child: Container(
                        width: screenWidth/3,
                        height: 20,
                        child: AutoSizeText(
                            (currentAccount.type == 2 ? 'Xe máy | ' : 'Ô tô | ') + currentAccount.license,
                            maxLines: 1,
                            style : TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontFamily: 'arial'
                            )
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      right: 20,
                      child: GestureDetector(
                        child: Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: currentAccount.WorkStatus == 0 ? Colors.grey : Colors.orange,
                        ),
                        onTap: () async {
                          if (currentAccount.WorkStatus == 0) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text('Bạn có muốn bật hoạt động không?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        await pushData(1);
                                        Navigator.of(context).pop();
                                        setState(() {

                                        });
                                      },
                                      child: Text('Có', style: TextStyle(color: Colors.blue),),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (currentAccount.WorkStatus == 1) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text('Bạn có muốn tắt hoạt động không?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        await pushData(0);
                                        Navigator.of(context).pop();
                                        setState(() {

                                        });
                                      },
                                      child: Text('Có', style: TextStyle(color: Colors.blue),),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: ContainerDash(screenWidth: screenWidth, screenHeight: screenHeight),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 22,
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'Các đơn gần bạn',
                  style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: (screenWidth - 30 - 24)/2,
                          decoration: BoxDecoration(
                              color: index == 0 ? Colors.redAccent : Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 9,
                                bottom: 9,
                                left: 5,
                                right: 20,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    'Giao hàng',
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: index == 0 ? Colors.white : Colors.redAccent,
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 9,
                                bottom: 9,
                                right: 4,
                                child: Container(
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        width: 0.7,
                                        color: index == 0 ? Colors.white : Colors.redAccent
                                      )
                                  ),
                                  child: AutoSizeText(
                                    currentAccount.WorkStatus == 0 ? '0' : nearOrder.second.toString(),
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.redAccent,
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),

                      Container(width: 5,),

                      GestureDetector(
                        child: Container(
                          width: (screenWidth - 30 - 24)/2,
                          decoration: BoxDecoration(
                              color: index == 1 ? Colors.redAccent : Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 9,
                                bottom: 9,
                                left: 5,
                                right: 20,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    'Đơn đồ ăn',
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: index == 1 ? Colors.white : Colors.redAccent,
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 9,
                                bottom: 9,
                                right: 4,
                                child: Container(
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 0.7,
                                          color: index == 1 ? Colors.white : Colors.redAccent
                                      )
                                  ),
                                  child: AutoSizeText(
                                    currentAccount.WorkStatus == 0 ? '0' : nearOrder.minute.toString(),
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.redAccent,
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: (screenWidth - 30 - 24)/2,
                            decoration: BoxDecoration(
                                color: index == 3 ? Colors.redAccent : Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 9,
                                  bottom: 9,
                                  left: 5,
                                  right: 20,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      'Đơn đi chợ',
                                      style: TextStyle(
                                          fontSize: 100,
                                          color: index == 3 ? Colors.white : Colors.redAccent,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 9,
                                  bottom: 9,
                                  right: 4,
                                  child: Container(
                                    width: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 0.7,
                                            color: index == 3 ? Colors.white : Colors.redAccent
                                        )
                                    ),
                                    child: AutoSizeText(
                                      currentAccount.WorkStatus == 0 ? '0' : nearOrder.day.toString(),
                                      style: TextStyle(
                                          fontSize: 100,
                                          color: Colors.redAccent,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              index = 3;
                            });
                          },
                        ),

                        Container(width: 5,),

                        GestureDetector(
                          child: Container(
                            width: (screenWidth - 30 - 24)/2,
                            decoration: BoxDecoration(
                                color: index == 2 ? Colors.redAccent : Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 9,
                                  bottom: 9,
                                  left: 5,
                                  right: 20,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      'Đơn gọi xe',
                                      style: TextStyle(
                                          fontSize: 100,
                                          color: index == 2 ? Colors.white : Colors.redAccent,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 9,
                                  bottom: 9,
                                  right: 4,
                                  child: Container(
                                    width: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 0.7,
                                            color: index == 2 ? Colors.white : Colors.redAccent
                                        )
                                    ),
                                    child: AutoSizeText(
                                      currentAccount.WorkStatus == 0 ? '0' : nearOrder.hour.toString(),
                                      style: TextStyle(
                                          fontSize: 100,
                                          color: Colors.redAccent,
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              index = 2;
                            });
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: screenHeight - 10 - 10 - 40 - 50 - 90 - 22 - 120 - 90 - 100,
                child: currentAccount.WorkStatus == 0 ? null : getContainer(screenHeight - 10 - 10 - 40 - 50 - 90 - 22 - 120 - 90 - 100, screenWidth-30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
