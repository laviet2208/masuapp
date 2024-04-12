import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/type_two_bike_gradient/next_to_step_3_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/back_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';

import '../type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'type_two_bike_step_1.dart';

class type_two_bike_step_2 extends StatefulWidget {
  final Location start_location;
  const type_two_bike_step_2({super.key, required this.start_location});

  @override
  State<type_two_bike_step_2> createState() => _type_two_bike_step_2State();
}

class _type_two_bike_step_2State extends State<type_two_bike_step_2> {

  double getCost(double distance) {
    double cost = 0;
    if (distance >= finalData.bikeCost.departKM) {
      cost += finalData.bikeCost.departKM.toInt() * finalData.bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= finalData.bikeCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - finalData.bikeCost.departKM) * finalData.bikeCost.perKMcost);
    } else {
      cost += (distance * finalData.bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  Container get_cost_text(double distance, double width) {
    return Container(
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
              child: AutoSizeText(
                'Giá tiền cho ' + distance.toStringAsFixed(0) + 'km',
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Container(
              height: 30,
              width: (width - 40 - 20)/2,
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: getStringNumber(getCost(distance)) + ".đ",
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [Colors.yellow.shade700 , Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button(beforeWidget: type_two_bike_step_1()),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: height/5,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
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

                              location_title(type: 'start'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.start_location.mainText,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 30,
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.add_location_alt_outlined, title: 'Thông tin điểm đón'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: width/3*2,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
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

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Masu cung cấp một bảng giá dự tính cho quý khách tham khảo',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 14,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                              ),

                              get_cost_text(5, width),

                              Container(height: 10,),

                              get_cost_text(7, width),

                              Container(height: 10,),

                              get_cost_text(10, width),

                              Container(height: 10,),

                              Container(height: 10,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.monetization_on_outlined, title: 'Chi phí ước tính'),
                      ),
                    ],
                  ),
                ),
              ),

              next_to_step_3_button(startLocation: widget.start_location),

              Container(height: 10,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_two_bike_step_1(),),);
        return true;
      },
    );
  }
}
