import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/productDirectory.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_main_screen/restaurant_main_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_view_screen/item_food_in_directory.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_view_screen/restaurant_view_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_view_screen/view_all_food_in_directory.dart';

class food_directory_page extends StatefulWidget {
  final productDirectory directory;
  final ShopAccount account;
  final VoidCallback callback;
  const food_directory_page({super.key, required this.directory, required this.account, required this.callback});

  @override
  State<food_directory_page> createState() => _food_directory_pageState();
}

class _food_directory_pageState extends State<food_directory_page> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    double height = 310;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                  size: 30,
                ),
              )
          ),

          Positioned(
            top: 5,
            left: 40,
            right: 10,
            child: Text(
              widget.directory.mainName,
              style: TextStyle(
                  fontFamily: 'DMSans_regu',
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: width/18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              child: Text(
                'Tất cả',
                style: TextStyle(
                    fontFamily: 'DMSans_regu',
                    color: Colors.blueAccent,
                    fontSize: width/22,
                    fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_all_food_in_directory(beforeWidget: restaurant_view_screen(shopId: widget.directory.ownerID, beforeWidget: restaurant_main_screen()), directory: widget.directory, event: widget.callback,),),);
              },
            ),
          ),

          Positioned(
            top: 50,
            left: 0,
            child: Container(
              width: width,
              height: 248,
              decoration: BoxDecoration(
                  color: Colors.white
              ),

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.directory.foodList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: item_food_in_directory(foodID: widget.directory.foodList[index], ontap: () { widget.callback(); },),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
