import 'package:flutter/material.dart';
import '../../FINAL/finalClass.dart';
import '../../GENERAL/Tool/Tool.dart';
import '../../GENERAL/utils/utils.dart';
import '../../OTHER/Button/Buttontype1.dart';
import '../FEATURE/SCREEN_itemsend/SCREEN_LOCATION_ITEMSEND_ST2.dart';

class SCREENfillreceiverinfor extends StatefulWidget {
  final double Distance;
  const SCREENfillreceiverinfor({Key? key, required this.Distance}) : super(key: key);

  @override
  State<SCREENfillreceiverinfor> createState() => _SCREENfillreceiverinforState();
}

class _SCREENfillreceiverinforState extends State<SCREENfillreceiverinfor> {
  final locationNotecontroller = TextEditingController();
  final Nametroller = TextEditingController();
  final Phonecontroller = TextEditingController();
  final Notecontroller = TextEditingController();

  String getlocation = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (bikeGetLocation.firstText == "NA") {
      getlocation = bikeGetLocation.Longitude.toString() + " , " + bikeGetLocation.Latitude.toString();
    } else {
      getlocation = bikeGetLocation.firstText;
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                padding: EdgeInsets.only(left: 10, right: screenWidth - 40),
                child: GestureDetector(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst2(Distance: widget.Distance,)));
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
              ),

              Container(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Người nhận',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Địa chỉ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),

              Container(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    )
                  ),

                  child: Text(
                    "   " + compactString(45, getlocation),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'arial',
                      color: Colors.black
                    ),
                  ),
                )
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Số tầng , số nhà (không bắt buộc)',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),

              Container(height: 10,),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: locationNotecontroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ghi chú địa chỉ',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'arial',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tên người liên lạc (bắt buộc)',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),

              Container(height: 10,),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: Nametroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tên liên lạc',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'arial',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Số điện thoại (bắt buộc)',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),

              Container(height: 10,),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: Phonecontroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'số điện thoại',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'arial',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Ghi chú cho tài xế (không bắt buộc)',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),

              Container(height: 10,),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: Notecontroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ghi chú',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'arial',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ButtonType1(Height: 60, Width: screenWidth-20, color: Colors.green, radiusBorder: 30, title: 'Xác nhận', fontText: 'arial', colorText: Colors.white,
                    onTap: () {
                       if (Nametroller.text.isEmpty || Phonecontroller.text.isEmpty) {
                         toastMessage('vui lòng điền đủ mục bắt buộc');
                       } else {
                         currentReceiver.name = Nametroller.text.toString();
                         currentReceiver.phoneNum = Phonecontroller.text.toString();
                         if (locationNotecontroller.text.isNotEmpty) {
                           currentReceiver.locationNote = locationNotecontroller.text.toString();
                         }
                         if (Notecontroller.text.isNotEmpty) {
                           currentReceiver.note = Notecontroller.text.toString();
                         }
                         //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst2(Distance: widget.Distance,)));
                       }
                    }),
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
