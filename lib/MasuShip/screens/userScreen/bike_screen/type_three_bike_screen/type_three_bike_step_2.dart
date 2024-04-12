import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_step_3.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/back_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';

import '../../../../Data/locationData/Location.dart';
import '../../general/search_location_dialog.dart';

class type_three_bike_step_2 extends StatefulWidget {
  final Widget beforeWidget;
  final Location start_location;
  final int customer_number;
  final int bike_number;
  const type_three_bike_step_2({super.key, required this.beforeWidget, required this.customer_number, required this.bike_number, required this.start_location});

  @override
  State<type_three_bike_step_2> createState() => _type_three_bike_step_2State();
}

class _type_three_bike_step_2State extends State<type_three_bike_step_2> {
  List<Location> customerLocations = [];
  List<Location> bikeLocations = [];

  bool check_fill_all_location(List<Location> list) {
    for (Location location in list) {
      if (location.latitude == 0 || location.longitude == 0) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //thêm vị trí cho các list
    for (int i = 0; i < widget.customer_number; i++) {
      customerLocations.add(Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''));
    }
    for (int i = 0; i < widget.bike_number; i++) {
      bikeLocations.add(Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''));
    }
  }

  Container get_location_text(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: 'muli',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button(beforeWidget: widget.beforeWidget),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 150,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 30,),

                              location_title(type: 'start'),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: get_location_text(widget.start_location.mainText + ' ' + widget.start_location.secondaryText),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.add_location_alt_outlined, title: 'Vị trí hiện tại của bạn'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 90 * widget.customer_number.toDouble() + 60,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 30),
                            itemCount: customerLocations.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                        ),

                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('assets/image/redcircle.png')
                                              )
                                          ),
                                        ),

                                        Container(
                                          width: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: width - 40 - 30 - 30 - 10,
                                            child: AutoSizeText(
                                              'Điểm trả khách ' + (index + 1).toString(),
                                              style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontSize: 200,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          child: Container(
                                            child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return search_location_dialog(location: customerLocations[index], title: 'Chọn điểm đến', event: () {
                                                    setState(() {

                                                    });
                                                  });
                                                }
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 50, right: 10),
                                    child: get_location_text(customerLocations[index].latitude == 0 ? 'Hãy chọn điểm đến nhé !' : (customerLocations[index].mainText + ' ' + customerLocations[index].secondaryText)),
                                  ),

                                  Container(height: 20,)
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.people_outline, title: 'Chọn vị trí trả khách - ' + customerLocations.length.toString() + ' người'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 90 * widget.bike_number.toDouble() + 60,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 20),
                            itemCount: bikeLocations.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Container(width: 10,),

                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('assets/image/redcircle.png')
                                              )
                                          ),
                                        ),

                                        Container(
                                          width: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 30,
                                            width: width - 40 - 30 - 30 - 10,
                                            child: AutoSizeText(
                                              'Điểm trả xe ' + (index + 1).toString(),
                                              style: TextStyle(
                                                  fontFamily: 'muli',
                                                  color: Colors.black,
                                                  fontSize: 200,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          child: Container(
                                            child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return search_location_dialog(location: bikeLocations[index], title: 'Chọn điểm trả xe', event: () {
                                                    setState(() {

                                                    });
                                                  });
                                                }
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 50, right: 10),
                                    child: get_location_text(bikeLocations[index].latitude == 0 ? 'Hãy chọn điểm trả xe !' : (bikeLocations[index].mainText + ' ' + bikeLocations[index].secondaryText)),
                                  ),

                                  Container(height: 20,),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.motorcycle_outlined, title: 'Chọn vị trí trả xe - ' + bikeLocations.length.toString() + ' xe'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.yellow],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // màu của shadow
                          spreadRadius: 2, // bán kính của shadow
                          blurRadius: 7, // độ mờ của shadow
                          offset: Offset(0, 3), // vị trí của shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Bước tiếp theo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (check_fill_all_location(customerLocations) && check_fill_all_location(bikeLocations)) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_three_bike_step_3(customerLocations: customerLocations, bikeLocations: bikeLocations, startLocation: widget.start_location)));
                    } else {
                      toastMessage('Bạn cần điền đủ các điểm trả');
                    }
                  },
                ),
              ),

              Container(height: 40,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget.beforeWidget,),);
        return true;
      },
    );
  }
}
