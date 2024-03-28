import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_step_3.dart';

import '../../../../Data/locationData/Location.dart';
import '../../general/search_location_dialog.dart';

class type_three_bike_step_2 extends StatefulWidget {
  final Widget beforeWidget;
  final Location startLocation;
  final int customer_number;
  final int bike_number;
  const type_three_bike_step_2({super.key, required this.beforeWidget, required this.customer_number, required this.bike_number, required this.startLocation});

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
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

              Container(
                height: 30,
                child: Row(
                  children: [
                    Container(width: 10,),

                    GestureDetector(
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
                      },
                    ),

                  ],
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 100 * widget.customer_number.toDouble() + 90,
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
                          child: ListView.builder(
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
                                    child: GestureDetector(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          customerLocations[index].latitude == 0 ? 'Hãy chọn điểm đến nhé !' : (customerLocations[index].mainText + ' ' + customerLocations[index].secondaryText),
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: customerLocations[index].latitude == 0 ? Colors.red :Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      onTap: () {

                                      },
                                    ),
                                  ),

                                  Container(height: 10,)
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.people_outline,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Chọn vị trí trả khách - ' + widget.customer_number.toString() + ' người',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 100 * widget.bike_number.toDouble() + 90,
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
                          child: ListView.builder(
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
                                    child: GestureDetector(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          bikeLocations[index].latitude == 0 ? 'Hãy chọn điểm trả xe !' : (bikeLocations[index].mainText + ' ' + bikeLocations[index].secondaryText),
                                          style: TextStyle(
                                              fontFamily: 'muli',
                                              color: bikeLocations[index].latitude == 0 ? Colors.red :Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      onTap: () {

                                      },
                                    ),
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
                        child: Container(
                          height: 40,
                          width: width/3*2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 2, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.sports_motorsports_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),

                                Container(width: 5,),

                                Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Container(
                                    width: width/3*2 - 50,
                                    child: AutoSizeText(
                                      'Chọn vị trí trả xe - ' + widget.bike_number.toString() + ' xe',
                                      style: TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => type_three_bike_step_3(customerLocations: customerLocations, bikeLocations: bikeLocations, startLocation: widget.startLocation)));
                    } else {
                      toastMessage('Bạn cần điền đủ các điểm trả');
                    }
                  },
                ),
              ),
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
