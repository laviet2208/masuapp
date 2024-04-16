import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/location_title.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/type_one_bike_step_2.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/search_location_dialog.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';
import '../../general/title_gradient_container.dart';

class type_one_bike_step_1 extends StatefulWidget {
  const type_one_bike_step_1({super.key});

  @override
  State<type_one_bike_step_1> createState() => _type_one_bike_step_1State();
}

class _type_one_bike_step_1State extends State<type_one_bike_step_1> {
  bool loading = false;
  String locationName = '';
  Location start_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
  Location end_location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');

  Container get_location_text(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.start,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    start_location = finalData.user_account.location;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: ListView(
            children: [
              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.yellow.withOpacity(0.2), Colors.yellow],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: -70,
                                bottom: 0,
                                child: Container(

                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/image/bikeLogo1.png')
                            )
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Bạn muốn\n',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),

                                TextSpan(
                                  text: 'Gọi xe ôm',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),

                                TextSpan(
                                  text: ' đi đến đâu',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 30,),

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

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    location_title(type: 'start'),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return search_location_dialog(location: start_location, title: 'Chọn điểm đón', event: () {
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
                                child: FutureBuilder(
                                  future: fetchLocationName(start_location),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return get_location_text('Đang tải vị trí...');
                                    }

                                    if (snapshot.hasError) {
                                      return get_location_text('Lỗi vị trí, vui lòng thử lại');
                                    }

                                    if (!snapshot.hasData) {
                                      return get_location_text('Lỗi vị trí, vui lòng thử lại');
                                    }

                                    return get_location_text(snapshot.data!.toString());
                                  },
                                ),
                              ),

                              Container(
                                width: 30,
                              ),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    location_title(type: 'end'),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return search_location_dialog(location: end_location, title: 'Chọn điểm đến', event: () {
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
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: get_location_text(end_location.latitude == 0 ? 'Hãy chọn điểm đến nhé !' : (end_location.mainText + ' ' + end_location.secondaryText),),
                                ),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.add_location_alt_outlined, title: 'Đặt xe chỉ với 2 bước'),
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
                    height: end_location.longitude != 0 ? 45 : 0,
                    decoration: end_location.longitude != 0 ?  BoxDecoration(
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
                    ) : null,
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
                    if (start_location.latitude != 0 && start_location.longitude != 0 && end_location.latitude != 0 && end_location.longitude != 0) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_one_bike_step_2(start_location: start_location, end_location: end_location),),);
                    } else {
                      toastMessage('Cần chọn điểm đón, trả');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => user_main_screen()));
        return true;
      },
    );
  }
}


