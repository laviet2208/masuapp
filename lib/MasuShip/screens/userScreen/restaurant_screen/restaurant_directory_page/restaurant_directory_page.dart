import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopDirectory.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_directory_page/item_restaurant_in_directory.dart';

class restaurant_directory_page extends StatefulWidget {
  final shopDirectory directory;
  const restaurant_directory_page({super.key, required this.directory});

  @override
  State<restaurant_directory_page> createState() => _restaurant_directory_pageState();
}

class _restaurant_directory_pageState extends State<restaurant_directory_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.directory.mainName,
                style: TextStyle(
                  fontFamily: 'arial',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18
                ),
              ),
            ),
          ),

          Container(height: 5,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.directory.subName,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 14
                ),
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 0),
            child: Container(
              height: (MediaQuery.of(context).size.width)/2.5 * 1.4,
              child: ListView.builder(
                itemCount: widget.directory.restaurantList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: item_restaurant_in_directory(shopId: widget.directory.restaurantList[index]),
                  );
                },
              ),
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
