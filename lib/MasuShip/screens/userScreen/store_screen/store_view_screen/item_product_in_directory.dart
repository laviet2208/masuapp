import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/store_view_screen/view_product_detail_dialog.dart';

import '../../../../Data/accountData/shopData/Product.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/otherData/utils.dart';

class item_product_in_directory extends StatefulWidget {
  final String foodID;
  final VoidCallback ontap;
  const item_product_in_directory({super.key, required this.foodID, required this.ontap});

  @override
  State<item_product_in_directory> createState() => _item_product_in_directoryState();
}

class _item_product_in_directoryState extends State<item_product_in_directory> {
  Product product = Product(id: '', cost: 0, name: '', describle: '', owner: '', status: 1, createTime: getCurrentTime());

  Future<String> _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('Product').child(widget.foodID + '.png');
    final url = await ref.getDownloadURL();
    return url;
  }

  void get_food_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Product/" + widget.foodID).onValue.listen((event) {
      final dynamic food = event.snapshot.value;
      if (food != null) {
        product = Product.fromJson(food);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_food_data();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 165,
        height: 249,
        decoration: BoxDecoration(
          color : product.status == 1 ? Colors.white : Colors.black.withOpacity(0.1),
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
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: _getImageURL(),
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
              left: 10,
              right: 30,
              child: Container(
                height: 14,
                alignment: Alignment.centerLeft,

                child: AutoSizeText(
                  product.describle,
                  style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.deepOrange,
                      overflow: TextOverflow.ellipsis,
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
                          child: Icon(
                            Icons.star_rounded,
                            color: Colors.orange,
                            size: 10,
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
      onTap: () {
        if (product.status == 0) {
          toastMessage('Sản phẩm đang tạm hết');
        } else {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            isScrollControlled: true,
            builder: (context) {
              return view_product_detail_dialog(product: product, event: widget.ontap);
            },
          );
        }
      },
    );
  }
}
