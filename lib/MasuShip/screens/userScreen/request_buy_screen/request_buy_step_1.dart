import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestProduct.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/action/add_product.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/action/edit_product.dart';

import '../../../Data/locationData/Location.dart';
import '../../../Data/otherData/Tool.dart';
import '../general/search_location_dialog.dart';
import '../main_screen/user_main_screen.dart';

class request_buy_step_1 extends StatefulWidget {
  const request_buy_step_1({super.key});

  @override
  State<request_buy_step_1> createState() => _request_buy_step_1State();
}

class _request_buy_step_1State extends State<request_buy_step_1> {
  double product_fee = 0;
  List<requestProduct> productList = [];
  List<Location> start_location_list = [];
  Location end_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    end_location = finalData.user_account.location;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: [
              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,

                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withOpacity(0.2), Colors.yellow],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: -70,
                                bottom: 0,
                                child: Container(

                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image/bikeLogo2.png')
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Bạn ngại đi chợ\n',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),

                                  TextSpan(
                                    text: 'Có Masu Ship',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),

                                  TextSpan(
                                    text: ' đi hộ',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 150,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/image/redcircle.png')
                                          )
                                      ),
                                    ),

                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: width - 40 - 30 - 30 - 10,
                                        child: AutoSizeText(
                                          'Điểm nhận hàng',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    ),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return search_location_dialog(location: end_location, title: 'Chọn điểm nhận hàng', event: () {
                                                setState(() {

                                                });
                                              });
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: FutureBuilder(
                                  future: fetchLocationName(end_location),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Đang tải vị trí...',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Lỗi dữ liệu vị trí, vui lòng thoát ra thử lại',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }

                                    if (!snapshot.hasData) {
                                      print(snapshot.hasData.toString());
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Lỗi dữ liệu vị trí, vui lòng thoát ra thử lại',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      );
                                    }

                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data.toString(),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Container(
                                width: 30,
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.edit_location_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Bạn muốn nhận hàng tại',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80 * start_location_list.length.toDouble() + 50 + 50,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 80 * start_location_list.length.toDouble(),
                                child: ListView.builder(
                                  itemCount: start_location_list.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                ),

                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage('assets/image/orangecircle.png')
                                                      )
                                                  ),
                                                ),

                                                Container(
                                                  width: 10,
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                                  child: Container(
                                                    height: 30,
                                                    width: width - 40 - 30 - 50 - 10,
                                                    child: AutoSizeText(
                                                      'Điểm mua hàng ' + (index + 1).toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'muli',
                                                          color: Colors.black,
                                                          fontSize: 200,
                                                          fontWeight: FontWeight.normal
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                GestureDetector(
                                                  child: Container(
                                                    child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return search_location_dialog(location: start_location_list[index], title: 'Chọn điểm mua hàng', event: () {
                                                            setState(() {

                                                            });
                                                          });
                                                        }
                                                    );
                                                  },
                                                ),

                                                GestureDetector(
                                                  child: Container(
                                                    child: Icon(Icons.delete_outline, color: Colors.redAccent,size: 20,),
                                                  ),
                                                  onTap: () {
                                                    start_location_list.removeAt(index);
                                                    setState(() {
                                                      
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(left: 50, right: 10),
                                            child: FutureBuilder(
                                              future: fetchLocationName(start_location_list[index]),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Đang tải vị trí...',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'muli',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  );
                                                }

                                                if (snapshot.hasError) {
                                                  print(snapshot.error.toString());
                                                  return Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Lỗi dữ liệu vị trí, vui lòng thoát ra thử lại',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'muli',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  );
                                                }

                                                if (!snapshot.hasData) {
                                                  print(snapshot.hasData.toString());
                                                  return Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Lỗi dữ liệu vị trí, vui lòng thoát ra thử lại',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'muli',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  );
                                                }

                                                return Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    snapshot.data.toString(),
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),

                                          Container(height: 10,),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 18,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: AutoSizeText(
                                      'Thêm vị trí mua hàng',
                                      style: TextStyle(
                                          fontFamily: 'muli',
                                          color: Colors.blueAccent,
                                          fontSize: 100
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Location location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return search_location_dialog(location: location, title: 'Thêm vị trí mua hàng',
                                          event: () {
                                            start_location_list.add(location);
                                            setState(() {});
                                          }
                                      );
                                    },
                                  );
                                },
                              ),

                              Container(height: 10,),

                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Bạn muốn mua hàng ở đâu',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80 + 45 * productList.length.toDouble(),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 45 * productList.length.toDouble(),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: productList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                ),

                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ),

                                                Container(
                                                  width: 10,
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                                  child: Container(
                                                    height: 30,
                                                    width: width - 40 - 30 - 40 - 10,
                                                    child: RichText(
                                                      overflow: TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: productList[index].name,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily: 'muli',
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold, // Để in đậm
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '-Số lượng: ' + productList[index].number.toStringAsFixed(0) + ' ' + productList[index].unit,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily: 'muli',
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.normal, // Để in đậm
                                                            ),
                                                          ),
                                                        ]
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                GestureDetector(
                                                  child: Container(
                                                    child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return edit_product(product: productList[index], event: () {setState(() {});});
                                                        },
                                                    );
                                                  },
                                                ),

                                                GestureDetector(
                                                  child: Container(
                                                    child: Icon(Icons.delete_outline, color: Colors.redAccent,size: 20,),
                                                  ),
                                                  onTap: () {
                                                    productList.removeAt(index);
                                                    product_fee = 10000 * ((productList.length/3).toInt()).toDouble();
                                                    setState(() {

                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(height: 15,),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 18,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: AutoSizeText(
                                      'Thêm mặt hàng',
                                      style: TextStyle(
                                          fontFamily: 'muli',
                                          color: Colors.blueAccent,
                                          fontSize: 100
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return add_product(list: productList, event: () {
                                        product_fee = 10000 * ((productList.length/3).toInt()).toDouble();
                                        setState(() {

                                        });
                                      });
                                    },
                                  );
                                },
                              ),

                              Container(height: 10,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Hàng hóa cần mua hộ',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 280,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: start_location_list.length != 0 ? FutureBuilder(
                                          future: getDistance(start_location_list.first, end_location),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Text('Chi phí di chuyển(...km)', style: TextStyle(color: Colors.black, fontSize: 15),);
                                            }

                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return Text('Lỗi vị trí, vui lòng thử lại', style: TextStyle(color: Colors.black, fontSize: 15),);
                                            }

                                            if (!snapshot.hasData) {
                                              return Text('Lỗi vị trí, vui lòng thử lại', style: TextStyle(color: Colors.black, fontSize: 15),);
                                            }

                                            return Container(
                                              height: 30,
                                              width: (width - 40 - 20)/2,
                                              child: AutoSizeText(
                                                'Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + ' Km)',
                                                style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 200,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            );
                                          },
                                        ) : Container(child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Phí di chuyển",
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: start_location_list.length != 0 ? FutureBuilder(
                                          future: getCost(start_location_list.first, end_location, height),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Đang tính toán giá tiền",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            return Container(
                                              height: 30,
                                              width: (width - 40 - 20)/2,
                                              child: AutoSizeText(
                                                getStringNumber(double.parse(snapshot.data.toString())) + '.đ',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.black,
                                                    fontSize: 200,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            );
                                          },
                                        ) : Container(child: RichText(
                                          textAlign: TextAlign.end,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Chưa chọn vị trí",
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Phụ thu thời tiết',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "0.đ",
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
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

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Phụ thu hàng hóa(' + productList.length.toString() + ' điểm)',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: getStringNumber(product_fee) + ".đ",
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: product_fee == 0 ? FontWeight.normal : FontWeight.bold,
                                                  fontSize: 14,
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

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Mã giảm giá',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      // child: GestureDetector(
                                      //   child: Container(
                                      //     height: 30,
                                      //     width: (width - 40 - 20)/2,
                                      //     alignment: Alignment.centerRight,
                                      //     child: RichText(
                                      //       text: TextSpan(
                                      //         children: [
                                      //           TextSpan(
                                      //             text: order.voucher.id == '' ? "Chọn mã giảm giá" : ('- ' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'),
                                      //             style: TextStyle(
                                      //               fontFamily: 'muli',
                                      //               color: Colors.redAccent,
                                      //               fontWeight: FontWeight.normal,
                                      //               fontSize: order.voucher.id == '' ? 12 : 14,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   onTap: () {
                                      //     showModalBottomSheet(
                                      //       context: context,
                                      //       builder: (context) {
                                      //         return voucher_select(voucher: order.voucher, ontap: () {
                                      //           setState(() {
                                      //
                                      //           });
                                      //         }, cost: order.cost + weightFee);
                                      //       },
                                      //     );
                                      //   },
                                      // ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange
                                  ),
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: AutoSizeText(
                                          'Tổng thanh toán',
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: Colors.black,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: start_location_list.length != 0 ? FutureBuilder(
                                          future: getCost(start_location_list.first, end_location, height),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Đang tính toán giá tiền",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (snapshot.hasError) {
                                              print(snapshot.error.toString());
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData) {
                                              return RichText(
                                                textAlign: TextAlign.end,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Lỗi khi tính toán",
                                                      style: TextStyle(
                                                        fontFamily: 'muli',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            return AutoSizeText(
                                              getStringNumber(double.parse(snapshot.data.toString()) + product_fee) + '.đ',
                                              //getStringNumber(double.parse(snapshot.data.toString()) - getVoucherSale(order.voucher, order.cost) + weightFee) + '.đ',
                                              style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontSize: 200,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            );
                                          },
                                        ) : Container(child: RichText(
                                          textAlign: TextAlign.end,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Chưa chọn vị trí",
                                                style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.monetization_on_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Thông tin thanh toán',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
