import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/cartProduct.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

class item_cart_product extends StatefulWidget {
  final cartProduct product;
  final VoidCallback event;
  const item_cart_product({super.key, required this.product, required this.event});

  @override
  State<item_cart_product> createState() => _item_cart_productState();
}

class _item_cart_productState extends State<item_cart_product> {
  String shopName = '';

  Future<String> _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('Food').child(widget.product.product.id + '.png');
    final url = await ref.getDownloadURL();
    return url;
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").child(widget.product.product.owner).child('name').onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      shopName = orders.toString();
      setState(() {

      });
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
    double width = MediaQuery.of(context).size.width - 20;
    return Container(
      width: width,
      height: 110,
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
            top: 5,
            bottom: 5,
            left: 5,
            child: Container(
              width: 100,
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
            left: 115,
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

                 Container(height: 5,),

                 Container(
                   alignment: Alignment.centerLeft,
                   child: Text(
                     shopName,
                     maxLines: 1,
                     style: TextStyle(
                         fontFamily: 'muli',
                         color: Colors.grey,
                         fontSize: 15,
                         overflow: TextOverflow.ellipsis,
                         fontWeight: FontWeight.bold
                     ),
                   ),
                 ),

                 Container(height: 5,),

                 Container(
                   alignment: Alignment.centerLeft,
                   child: Row(
                     children: [
                       Text(
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

                       Text(
                         '     Đơn giá: ' + getStringNumber(widget.product.product.cost) + '.đ',
                         maxLines: 1,
                         style: TextStyle(
                             fontFamily: 'muli',
                             color: Colors.blueAccent,
                             fontSize: 15,
                             overflow: TextOverflow.ellipsis,
                             fontWeight: FontWeight.normal
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
            ),
          ),

          Positioned(
            bottom: 5,
            right: 5,
            child: GestureDetector(
              child: Icon(
                Icons.delete_outline_outlined,
                color: Colors.redAccent,
                size: 22,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Xác nhận xóa', style: TextStyle(fontFamily: 'mulibold', color: Colors.black,),),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            finalData.cartList.remove(widget.product);
                            widget.event();
                            toastMessage('Xóa thành công');
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Đồng ý',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontFamily: 'muli'
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Hủy',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontFamily: 'muli'
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
