import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/general_ingredient.dart';
import '../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../Data/otherData/Tool.dart';

class price_list_type_1_wait_ingredient extends StatelessWidget {
  final CatchOrder order;
  const price_list_type_1_wait_ingredient({super.key, required this.order});

  Padding get_right_content_text(String title, double width) {
    return Padding(
      padding: EdgeInsets.only(top: 7, bottom: 7),
      child: Container(
        height: 30,
        width: (width - 40 - 20)/2,
        alignment: Alignment.centerRight,
        child: Container(
          height: 30,
          width: (width - 40 - 20)/2,
          child: AutoSizeText(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontSize: 200,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), // màu của shadow
            spreadRadius: 2, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 30,),

          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    height: 30,
                    width: (width - 40 - 20)/2,
                    child: FutureBuilder(
                      future: getDistance(order.locationSet, order.locationGet),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Chi phí di chuyển(...km)', style: TextStyle(color: Colors.black, fontSize: 15),);
                        }

                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Text('Vui lòng chọn hoặc cho phép vị trí', style: TextStyle(color: Colors.black, fontSize: 15),);
                        }

                        if (!snapshot.hasData) {
                          return Text('Vui lòng chọn hoặc cho phép vị trí', style: TextStyle(color: Colors.black, fontSize: 15),);
                        }

                        return general_ingredient.get_cost_title('Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + 'Km)', width, 0);
                      },
                    ),
                  ),
                ),

                get_right_content_text(getStringNumber(order.cost) + '.đ', width),
              ],
            ),
          ),

          Container(height: 10,),

          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                general_ingredient.get_cost_title(order.subFee == 0 ? 'Phụ thu' : ('Phụ thu ' + finalData.weathercost.weatherTitle), width, 7),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: general_ingredient.get_cost_money(getStringNumber(order.subFee) + ".đ", width),
                ),

              ],
            ),
          ),

          Container(height: 10,),

          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                general_ingredient.get_cost_title('Mã giảm giá', width, 7),

                get_right_content_text(order.voucher.id == '' ? "Không áp giảm giá" : ('- ' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'), width),
              ],
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 0.5,
              decoration: BoxDecoration(
                  color: Colors.deepOrange
              ),
            ),
          ),

          Container(height: 10,),

          Container(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 10,
                ),

                general_ingredient.get_cost_title('Tổng thanh toán', width, 4),

                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  child: general_ingredient.get_cost_money(getStringNumber(order.cost + order.subFee  - getVoucherSale(order.voucher, order.cost)) + '.đ', width),
                ),
              ],
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
