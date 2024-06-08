import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/restaurant_view_screen/item_food_in_directory.dart';

import '../../../../Data/accountData/shopData/productDirectory.dart';

class view_all_product_in_directory extends StatefulWidget {
  final Widget beforeWidget;
  final productDirectory directory;
  final VoidCallback event;
  const view_all_product_in_directory({super.key, required this.beforeWidget, required this.directory, required this.event});

  @override
  State<view_all_product_in_directory> createState() => _view_all_product_in_directoryState();
}

class _view_all_product_in_directoryState extends State<view_all_product_in_directory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
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
                        bottom: 20,
                        left: 10,
                        child: GestureDetector(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget.beforeWidget,),);
                          },
                        ),
                      ),

                      Positioned(
                        bottom: 25,
                        left: 40,
                        right: 40,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '🔥 ' + widget.directory.mainName,
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                fontFamily: 'arial',
                                color: Colors.black
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 100,
                bottom: 20,
                left: (width-165*2)/3,
                right: (width-165*2)/3,
                child: Container(
                  child: GridView.builder(
                    itemCount: widget.directory.foodList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // số phần tử trên mỗi hàng
                      mainAxisSpacing: 20, // khoảng cách giữa các hàng
                      crossAxisSpacing: (width-165*2)/3, // khoảng cách giữa các cột
                      childAspectRatio: 165/249, // tỷ lệ chiều rộng và chiều cao
                    ),
                    itemBuilder: (context, index) {
                      return item_food_in_directory(foodID: widget.directory.foodList[index], ontap: widget.event);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}