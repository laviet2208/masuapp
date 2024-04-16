import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_food_order_detail/view_food_list_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../userScreen/express_screen/ingredient/location_title_custom_express.dart';

class restaurant_location extends StatelessWidget {
  final foodOrder order;
  const restaurant_location({super.key, required this.order});

  Container get_location_text(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  void openMaps(double destinationLatitude, double destinationLongitude) async {
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$destinationLatitude,$destinationLongitude';
    String appleMapsUrl = 'https://maps.apple.com/?q=$destinationLatitude,$destinationLongitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not launch Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
              spreadRadius: 2, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Đơn hàng: ' + order.id,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              child: ListView.builder(
                itemCount: order.shopList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        location_title_custom_express(type: 'start', title: 'Nhà hàng ' + (index + 1).toString(),),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              order.shopList[index].name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              order.shopList[index].phone,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Thanh toán: ',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontFamily: 'muli',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),

                                  TextSpan(
                                    text: getStringNumber(history_controller.get_cost_pay_for_restaurant(order.shopList[index], order.productList, order.resCost.discount)) + '.đ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'muli',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: get_location_text(order.shopList[index].location.mainText + ', ' + order.shopList[index].location.secondaryText),
                        ),

                        Container(height: 5,),

                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Xem món >',
                                style: TextStyle(
                                  fontFamily: 'muli',
                                  fontSize: 14,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return view_food_list_dialog(order: order, index: index);
                                },
                              );
                            },
                          ),
                        ),

                        Container(height: 20,),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
