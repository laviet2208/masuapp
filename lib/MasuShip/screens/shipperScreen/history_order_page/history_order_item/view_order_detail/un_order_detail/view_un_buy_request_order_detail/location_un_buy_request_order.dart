import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import '../../../../../../../Data/otherData/Tool.dart';
import '../../../../../../userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import '../../../../../../userScreen/request_buy_screen/ingredient/item_market_location_wait.dart';

class location_un_buy_request_order extends StatelessWidget {
  final requestBuyOrder order;
  const location_un_buy_request_order({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: get_usually_decoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 20,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '     Danh sách địa chỉ',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(height: 5,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '     Đơn: ' + order.id,
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              child: ListView.builder(
                itemCount: order.buyLocation.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return item_market_location_wait(index: index, list: order.buyLocation,);
                },
              ),
            ),

            location_title(type: 'end'),

            Padding(
              padding: EdgeInsets.only(left: 50, right: 10),
              child: general_ingredient.get_location_text(order.locationGet.mainText, Colors.black),
            ),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}
