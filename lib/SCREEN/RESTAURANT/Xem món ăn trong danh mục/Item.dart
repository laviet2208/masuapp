import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/Product/Product.dart';
import '../../../GENERAL/ShopUser/accountShop.dart';
import '../../../GENERAL/Tool/Time.dart';
import '../../../GENERAL/Tool/Tool.dart';
import '../../../GENERAL/utils/utils.dart';
import '../Khung tăng giảm số lượng.dart';

class Itemmonandoc extends StatefulWidget {
  final double width;
  final String id;
  final VoidCallback ontap;
  final int Type;
  const Itemmonandoc({Key? key, required this.width, required this.id, required this.ontap, required this.Type}) : super(key: key);

  @override
  State<Itemmonandoc> createState() => _ItemmonandocState();
}

class _ItemmonandocState extends State<Itemmonandoc> {
  final Product product = Product(id: '', name: '', content: '', owner: accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0), cost: 0, imageList: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), OpenStatus: 0);
  final QuantitySelector quantitySelector = QuantitySelector();
  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child((widget.Type == 0 ? 'Food' : 'Product') + "/" + widget.id).onValue.listen((event) {
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
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
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
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(product.imageList)
                    )
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 110,
              right: 10,
              child: Text(
                product.name,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              left: 110,
              right: 10,
              child: Text(
                getStringNumber(product.cost) + '.đ',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
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
                              if (widget.Type == 0) {
                                if(product.OpenStatus == 0) {
                                  toastMessage('Món tạm hết');
                                } else {
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
                                }
                              } else {
                                if (product.OpenStatus == 0) {
                                  toastMessage('Sản phẩm tạm hết');
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
                                                      if (storeList.isEmpty) {
                                                        for (int i = 0 ; i < quantitySelector.data.second ; i++) {
                                                          storeList.add(product);
                                                        }
                                                        toastMessage('Bạn đã thêm ' + quantitySelector.data.second.toString() + " " + product.name);
                                                        widget.ontap();
                                                        Navigator.of(context).pop();
                                                      } else {
                                                        if (product.owner.id == storeList[0].owner.id) {
                                                          for (int i = 0 ; i < quantitySelector.data.second ; i++) {
                                                            storeList.add(product);
                                                          }
                                                          toastMessage('Bạn đã thêm ' + quantitySelector.data.second.toString() + " " + product.name);
                                                          widget.ontap();
                                                          Navigator.of(context).pop();
                                                        } else {
                                                          toastMessage('Bạn không thể thêm món từ 2 cửa hàng khác nhau');
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      )
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
