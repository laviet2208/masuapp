import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Product/Product.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/ShopUser/accountShop.dart';
import '../../../GENERAL/Tool/Time.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../INUSER/PAGE_HOME/Tính khoảng cách.dart';
import '../Khung tăng giảm số lượng.dart';
import '../SCREENshopview.dart';
class ITEMfoodIndirect extends StatefulWidget {
  final String id;
  final VoidCallback ontap;
  const ITEMfoodIndirect({Key? key, required this.id, required this.ontap}) : super(key: key);

  @override
  State<ITEMfoodIndirect> createState() => _ITEMrestaurantIndirectState();
}

class _ITEMrestaurantIndirectState extends State<ITEMfoodIndirect> {
  final Product product = Product(id: '', name: '', content: '', owner: accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0), cost: 0, imageList: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), OpenStatus: 0);
  final QuantitySelector quantitySelector = QuantitySelector();
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Food/" + widget.id).onValue.listen((event) {
      final dynamic restaurant = event.snapshot.value;
      Product acc = Product.fromJson(restaurant);
      product.id = acc.id;
      product.name = acc.name;
      product.owner = acc.owner;
      product.cost = acc.cost;
      product.content = acc.content;
      product.imageList = acc.imageList;
      product.OpenStatus = acc.OpenStatus;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 165,
        height: 249,
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
              spreadRadius: 2, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),

        child: Stack(
          children: <Widget>[
            Positioned(
              top: 15,
              left: 13,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(

                ),
                child: Image.network(product.imageList,fit: BoxFit.cover),
              ),
            ),


            Positioned(
              top: 170,
              left: 10,
              child: Container(
                width: 156,
                height: 18,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  compactString(13, product.name),
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Color(0xff000000),
                      fontSize: 150,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Positioned(
              top: 190,
              left: 13,
              child: Container(
                width: 156,
                height: 14,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  product.content,
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.deepOrange,
                      fontSize: 130,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Positioned(
              top: 214,
              left: 13,
              child: Container(
                width: 130,
                height: 17,
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 11,
                          height: 11,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/nowshopping-493ca.appspot.com/o/icon%2Fstar.png?alt=media&token=15f73b76-62ab-46fc-98f0-af7600f40936',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 14,
                        child: Container(
                            child: Text(
                              "5.0",
                              style: TextStyle(
                                  fontFamily: 'Dmsan_regular',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 214,
              right: 10,
              child: Container(
                width: 70,
                height: 16,
                alignment: Alignment.centerRight,
                child: AutoSizeText(
                  getStringNumber(product.cost) + ' đ',
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 130,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () async {
        if (product.OpenStatus == 0) {
          toastMessage('Món ăn đang tạm hết');
        } else {
          quantitySelector.data.second = 0;
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(product.imageList)
                            )
                        ),
                      ),

                      Container(
                        height: 10,
                      ),

                      Container(
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: AutoSizeText(
                            product.name,
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 100
                            ),
                          ),
                        ),
                      ),

                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            product.content,
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 10,
                      ),

                      Container(
                        height: 40,
                        child: Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3 , right: MediaQuery.of(context).size.width/3),
                          child: quantitySelector,
                        ),
                      ),

                      Container(
                        height: 10,
                      ),

                      Container(
                        height: 40,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: GestureDetector(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 244, 164, 84),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 10),
                                child: AutoSizeText(
                                  'Thêm vào giỏ hàng',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontFamily: 'arial',
                                      fontSize: 100
                                  ),
                                ),
                              ),
                            ),

                            onTap: () {
                              if (cartList.isEmpty) {
                                for (int i = 0 ; i < quantitySelector.data.second ; i++) {
                                  cartList.add(product);
                                }
                                setState(() {

                                });
                                toastMessage('Bạn đã thêm ' + quantitySelector.data.second.toString() + " " + product.name);
                                widget.ontap();
                                Navigator.of(context).pop();
                              } else {
                                if (product.owner.id == cartList[0].owner.id) {
                                  for (int i = 0 ; i < quantitySelector.data.second ; i++) {
                                    cartList.add(product);
                                  }
                                  setState(() {

                                  });
                                  toastMessage('Bạn đã thêm ' + quantitySelector.data.second.toString() + " " + product.name);
                                  widget.ontap();
                                  Navigator.of(context).pop();
                                } else {
                                  toastMessage('Bạn không thể thêm món từ 2 nhà hàng khác nhau');
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
      },
    );
  }
}

