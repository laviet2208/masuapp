import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

import '../restaurant_main_screen/restaurant_main_screen.dart';
import '../restaurant_view_screen/restaurant_view_screen.dart';

class item_restaurant_in_directory extends StatefulWidget {
  final String shopId;
  const item_restaurant_in_directory({super.key, required this.shopId});

  @override
  State<item_restaurant_in_directory> createState() => _item_restaurant_in_directoryState();
}

class _item_restaurant_in_directoryState extends State<item_restaurant_in_directory> {
  ShopAccount account = ShopAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', phone: '', money: 0, type: 0, password: '', closeTime: getCurrentTime(), openTime: getCurrentTime(), openStatus: 0, discount_type: 0, area: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), listDirectory: []);

  void get_restaurant_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").child(widget.shopId).onValue.listen((event) {
      final dynamic restaurant = event.snapshot.value;
      if (restaurant != null) {
        account = ShopAccount.fromJson(restaurant);
        setState(() {

        });
      } else {

      }
    });
  }

  bool check_open_time(Time start, Time end) {
    DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, start.hour, start.minute, start.second);
    DateTime endTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, end.hour, end.minute, end.second);
    return DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);
  }

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('Restaurant').child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_restaurant_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width)/2.5;
    double height = width * 1.5;
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [account.discount_type == 1 ? Colors.yellow.withOpacity(0.1) : Colors.orange.withOpacity(0.1),account.discount_type == 1 ? Colors.white : Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 3.0],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 5,
              left: 5,
              right: 5,
              child: Container(
                height: width - 10,
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
              top: 15 + width - 10,
              left: 5,
              right: 5,
              bottom: 5,
              child: Container(
                child: Text(
                  account.name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'roboto',
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (account.openStatus == 1 && check_open_time(account.openTime, account.closeTime)) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => restaurant_view_screen(shopId: widget.shopId, beforeWidget: restaurant_main_screen())));
        } else {
          toastMessage('Nhà hàng tạm đóng cửa');
        }
      },
    );
  }
}
