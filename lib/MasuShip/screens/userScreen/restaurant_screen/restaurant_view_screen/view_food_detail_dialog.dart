import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_view_screen/quantityFrame.dart';

import '../../../../Data/accountData/shopData/Product.dart';

class view_food_detail_dialog extends StatefulWidget {
  final Product product;
  final VoidCallback event;
  const view_food_detail_dialog({super.key, required this.product, required this.event});

  @override
  State<view_food_detail_dialog> createState() => _view_food_detail_dialogState();
}

class _view_food_detail_dialogState extends State<view_food_detail_dialog> {
  quantityFrame quantityframe = quantityFrame();

  Future<String> _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('Food').child(widget.product.id + '.png');
    final url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  void sortListAZ(List<cartProduct> cartList) {
    cartList.sort((a, b) => a.product.owner.compareTo(b.product.owner));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityframe.data.second = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
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

          Container(
            height: 15,
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.product.name,
                style: TextStyle(
                    fontFamily: 'muli',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
            ),
          ),

          Container(height: 5,),

          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.product.describle,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'muli',
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 16,
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
              child: quantityframe,
            ),
          ),

          Container(
            height: 20,
          ),

          Container(
            height: 40,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 10),
                    child: AutoSizeText(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'muli',
                          fontSize: 100
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (quantityframe.data.second >= 1) {
                    bool check = false;
                    cartProduct cartproduct = cartProduct(product: widget.product, number: quantityframe.data.second);
                    for (int i = 0; i < finalData.cartList.length; i++) {
                      if (cartproduct.product.id == finalData.cartList[i].product.id) {
                        finalData.cartList[i].number = cartproduct.number + finalData.cartList[i].number;
                        check = true;
                        break;
                      }
                    }
                    if (!check) {
                      finalData.cartList.add(cartproduct);
                    }
                    sortListAZ(finalData.cartList);
                    for (int i = 0; i < finalData.cartList.length; i++) {
                      print(finalData.cartList[i].product.name + '---' + finalData.cartList[i].number.toString() + '---' + finalData.cartList[i].product.owner);
                    }

                    widget.event();
                    Navigator.of(context).pop();
                  } else {
                    toastMessage('Số lượng tối thiểu là 1');
                  }
                },
              ),
            ),
          ),

          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}
