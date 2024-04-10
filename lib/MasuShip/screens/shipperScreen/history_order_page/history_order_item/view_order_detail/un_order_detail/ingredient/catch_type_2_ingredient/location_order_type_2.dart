import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_2_controller/un_complete_catch_type_2_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/general/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:url_launcher/url_launcher.dart';

class location_info_order_type_2 extends StatelessWidget {
  final CatchOrder order;
  const location_info_order_type_2({super.key, required this.order});

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
    double width = MediaQuery.of(context).size.width;
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
            Container(height: 10,),

            location_title(type: 'start'),

            Padding(
              padding: EdgeInsets.only(left: 50, right: 10),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      order.owner.phone[0] == '0' ? order.owner.phone : '0' + order.owner.phone,
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),

                  Container(width: 5,),

                  GestureDetector(
                    child: Container(
                        child:Icon(
                          Icons.phone_enabled,
                          color: Colors.green,
                          size: 15,
                        )
                    ),
                    //onTap: () => _launchPhone(order.owner.phone[0] == '0' ? order.owner.phone : '0' + order.owner.phone),
                  )
                ],
              ),
            ),

            Container(height: 5,),

            Padding(
              padding: EdgeInsets.only(left: 50, right: 10),
              child: get_location_text(order.locationSet.mainText + ',' + order.locationSet.secondaryText),
            ),

            Container(height: 8,),

            Padding(
              padding: EdgeInsets.only(left: 50, right: 10),
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Xem trong map',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 14,
                        color: Colors.blueAccent
                    ),
                  ),
                ),
                onTap: () async {
                  openMaps(order.locationSet.latitude, order.locationSet.longitude);
                },
              ),
            ),

            Container(height: 7,),

            location_title(type: 'end'),

            Padding(
              padding: EdgeInsets.only(left: 50, right: 10),
              child: get_location_text(order.locationGet.longitude != 0 ? order.locationGet.mainText + ',' + order.locationGet.secondaryText : 'Hiện chưa đến nơi'),
            ),

            Container(height: 8,),

            Padding(
              padding: EdgeInsets.only(left: 50, right: 10),
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Xem trong map',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: order.locationGet.longitude == 0 ? 0 : 14,
                        color: Colors.blueAccent
                    ),
                  ),
                ),
                onTap: () async {
                  order.locationGet.longitude != 0 ? openMaps(order.locationGet.latitude, order.locationGet.longitude) : null;
                },
              ),
            ),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}

