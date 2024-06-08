import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/store_screen/store_directory_page/item_store_in_directory.dart';

import '../../../../Data/accountData/shopData/shopDirectory.dart';

class store_directory_page extends StatefulWidget {
  final shopDirectory directory;
  const store_directory_page({super.key, required this.directory});

  @override
  State<store_directory_page> createState() => _store_directory_pageState();
}

class _store_directory_pageState extends State<store_directory_page> {
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
                    fontFamily: 'muli',
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
                    fontFamily: 'muli',
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
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: item_store_in_directory(shopId: widget.directory.restaurantList[index]),
                    ),
                    onTap: () {

                    },
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
