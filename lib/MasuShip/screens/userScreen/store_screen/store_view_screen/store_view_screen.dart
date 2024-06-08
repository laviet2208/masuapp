import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/product_order_screen/cart_screen/view_store_cart_screen.dart';

import '../../../../Data/accountData/shopData/Product.dart';
import '../../../../Data/accountData/shopData/productDirectory.dart';
import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/otherData/utils.dart';
import 'product_directory_page.dart';

class store_view_screen extends StatefulWidget {
  final String shopId;
  final Widget beforeWidget;
  const store_view_screen({super.key, required this.shopId, required this.beforeWidget});

  @override
  State<store_view_screen> createState() => _store_view_screenState();
}

class _store_view_screenState extends State<store_view_screen> {
  ShopAccount account = ShopAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', phone: '', money: 0, type: 0, password: '', closeTime: getCurrentTime(), openTime: getCurrentTime(), openStatus: 0, discount_type: 0, area: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), listDirectory: []);
  productDirectory chosenDirectory = productDirectory(id: '', mainName: '', foodList: [], ownerID: '');
  List<Product> productList = [];
  List<productDirectory> foodDirecList = [];
  List<productDirectory> chosenList = [];

  void get_restaurant_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Store").child(widget.shopId).onValue.listen((event) {
      final dynamic restaurant = event.snapshot.value;
      if (restaurant != null) {
        account = ShopAccount.fromJson(restaurant);
        setState(() {

        });
      } else {

      }
    });
  }

  void dropdownCallback(productDirectory? selectedValue) {
    if (selectedValue is productDirectory) {
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

  void get_directory_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ProductDirectory").orderByChild('ownerID').equalTo(widget.shopId).onValue.listen((event) {
      foodDirecList.clear();
      chosenList.clear();
      foodDirecList.add(productDirectory(id: 'all', mainName: 'Tất cả', foodList: [], ownerID: ''));
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        productDirectory acc = productDirectory.fromJson(value);
        foodDirecList.add(acc);
        chosenList.add(acc);
        setState(() {
          chosenDirectory = foodDirecList.first;
        });
      });

    });
  }

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('Store').child(imagePath);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_restaurant_data();
    get_directory_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  width: width,
                  height: width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: FutureBuilder(
                            future: _getImageURL(widget.shopId + '.png'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.black,),
                                );
                              }

                              if (snapshot.hasError) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.image_outlined, color: Colors.black, size: 30,),
                                );
                              }

                              if (!snapshot.hasData) {
                                return Text('Image not found');
                              }

                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(snapshot.data.toString())
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 40,
                        left: 10,
                        child: GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: width/5*3,
                left: 0,
                child: Container(
                  width: width,
                  height: height - (width/5*3) - 80,
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
                          child: Text(
                            account.name,
                            style: TextStyle(
                                fontFamily: 'DMSans_regu',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          child: Text(
                            '📍' + account.location.mainText + ' ' + account.location.secondaryText,
                            style: TextStyle(
                                fontFamily: 'DMSans_regu',
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),

                      Container(height: 10,),

                      Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Container(
                          child: FutureBuilder(
                            future: getDistance(finalData.user_account.location, account.location),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text('...', style: TextStyle(color: Colors.black, fontSize: 15),);
                              }

                              if (snapshot.hasError) {
                                return Text('Cách bạn...', style: TextStyle(color: Colors.black, fontSize: 15),);
                              }

                              if (!snapshot.hasData) {
                                return Text('...', style: TextStyle(color: Colors.black, fontSize: 15),);
                              }

                              return Container(
                                child: Text(
                                  '🚊 Cách bạn : ' + snapshot.data!.toStringAsFixed(1) + ' Km',
                                  style: TextStyle(
                                      fontFamily: 'DMSans_regu',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      Container(height: 20,),

                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: 40,
                          child: DropdownButton<productDirectory>(
                            items: foodDirecList.map((e) => DropdownMenuItem<productDirectory>(
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
                        height: 310 * chosenList.length.toDouble(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: chosenList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return product_directory_page(directory: chosenList[index], callback: () { setState(() {

                              });
                              }, account: account,);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  child: Container(
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
                              width: width - 20,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [Colors.yellow.withOpacity(0.4), Colors.yellow],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: Container(
                                      width: width - 20 - 40,
                                      height: 20,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Giỏ hàng   |  ',
                                            ),
                                            TextSpan(
                                              text: finalData.storeCartList.length.toString() + ' món',
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
                                      width: width - 20 - 40,
                                      height: 20,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        getStringNumber(get_total_cart_money()) + '.đ',
                                        style: TextStyle(
                                          fontFamily: 'muli',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold, // Cài đặt FontWeight.bold cho phần còn lại
                                          color: Colors.black,
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
                    if (finalData.storeCartList.length == 0) {
                      toastMessage('Giỏ hàng chưa có sản phẩm nào');
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_store_cart_screen(beforewidget: store_view_screen(shopId: widget.shopId, beforeWidget: widget.beforeWidget)),),);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget.beforeWidget,),);
        return Future.value(false);
      },
    );
  }
}
