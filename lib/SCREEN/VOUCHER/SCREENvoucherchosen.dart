import 'package:flutter/material.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/utils/utils.dart';
import '../FEATURE/SCREEN_BIKEORDER/SCREEN_LOCATION_BIKE_ST2.dart';
import '../FEATURE/SCREEN_CARORDER/SCREEN_LOCATION_CAR_ST2.dart';
import '../RESTAURANT/Đặt đơn món ăn/SCREEN_LOCATION_FOOD1.dart';
import '../FEATURE/SCREEN_itemsend/SCREEN_LOCATION_ITEMSEND_ST2.dart';
import 'ITEMvoucherview.dart';

class SCREENvoucherchosen extends StatefulWidget {
  final int type;
  final double distance;
  const SCREENvoucherchosen({Key? key, required this.type, required this.distance}) : super(key: key);

  @override
  State<SCREENvoucherchosen> createState() => _SCREENvoucherchosenState();
}

class _SCREENvoucherchosenState extends State<SCREENvoucherchosen> {
  int getCost(double distance) {
    int cost = 0;
    if (distance >= 2.0) {
      cost += 20000; // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= 2.0; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - 2) * 5000).toInt();
    } else {
      cost += (distance * 10000).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),

            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 100,
                    left: 10,
                    child: Container(
                        height: screenHeight - 100,
                        width: screenWidth - 20,
                        decoration: BoxDecoration(

                        ),
                        child: GridView.builder(
                          //itemCount: currentAccount.voucherList.length,
                          itemCount: 0,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // số phần tử trên mỗi hàng
                            mainAxisSpacing: 0, // khoảng cách giữa các hàng
                            crossAxisSpacing: 0, // khoảng cách giữa các cột
                            childAspectRatio: 2.3, // tỷ lệ chiều rộng và chiều cao
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                              child: InkWell(
                                onTap: () {
                                  // if (getCost(widget.distance) >= currentAccount.voucherList[index].mincost) {
                                  //   if (getCost(widget.distance) >= currentAccount.voucherList[index].totalmoney) {
                                  //     chosenvoucher.id = currentAccount.voucherList[index].id;
                                  //     chosenvoucher.totalmoney = currentAccount.voucherList[index].totalmoney;
                                  //     chosenvoucher.mincost = currentAccount.voucherList[index].mincost;
                                  //     if (widget.type == 1) {
                                  //       //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest2(Distance: widget.distance,)));
                                  //     } else if (widget.type == 2) {
                                  //       //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationcarst2(Distance: widget.distance,)));
                                  //     } else if (widget.type == 3) {
                                  //       //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst2(Distance: widget.distance,)));
                                  //     } else if (widget.type == 4) {
                                  //       //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationfood1(Distance: widget.distance,)));
                                  //     }
                                  //
                                  //   } else {
                                  //     toastMessage('Giá tiền đơn hàng ít hơn giá trị voucher');
                                  //   }
                                  // } else {
                                  //   toastMessage('Đơn hàng không thể áp dụng voucher');
                                  // }

                                },
                                // child: ITENvoucherview(voucher: currentAccount.voucherList[index], width: screenWidth - 20, height: screenWidth/2,),
                              ),
                            );
                          },
                        )
                    ),
                  ),

                Positioned(
                  top: 60,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.type == 1) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationbikest2(Distance: widget.distance,)));
                      } else if (widget.type == 2) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationcarst2(Distance: widget.distance,)));
                      } else if (widget.type == 3) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst2(Distance: widget.distance,)));
                      } else if (widget.type == 4) {
                        //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationfood1(Distance: widget.distance,)));
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/backicon1.png'),
                        ),
                      ),
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
