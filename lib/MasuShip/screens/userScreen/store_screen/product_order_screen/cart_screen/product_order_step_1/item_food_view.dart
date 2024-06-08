import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

class item_product_view extends StatefulWidget {
  final cartProduct product;
  const item_product_view({super.key, required this.product,});

  @override
  State<item_product_view> createState() => _item_food_viewState();
}

class _item_food_viewState extends State<item_product_view> {

  Future<String> _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('Product').child(widget.product.product.id + '.png');
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return Container(
      width: width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
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
            top: 5,
            bottom: 5,
            left: 5,
            child: Container(
              width: 60,
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
            top: 5,
            left: 75,
            right: 15,
            bottom: 5,
            child: Container(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.product.product.name,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Container(
                    child: Text(
                      'Số lượng: ' + widget.product.number.toString(),
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),

                  Container(
                    child: Text(
                      'Thành tiền: ' + getStringNumber(widget.product.number.toDouble() * widget.product.product.cost) + '.đ',
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.grey,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
