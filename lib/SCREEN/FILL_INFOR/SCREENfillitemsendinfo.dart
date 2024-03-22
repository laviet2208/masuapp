import 'package:flutter/material.dart';
import '../../FINAL/finalClass.dart';
import '../../GENERAL/utils/utils.dart';
import '../../OTHER/Button/Buttontype1.dart';
import '../FEATURE/SCREEN_itemsend/SCREEN_LOCATION_ITEMSEND_ST2.dart';

class SCREENfillitemsendinfo extends StatefulWidget {
  final double Distance;
  const SCREENfillitemsendinfo({Key? key, required this.Distance}) : super(key: key);

  @override
  State<SCREENfillitemsendinfo> createState() => _SCREENfillitemsendinfoState();
}

class _SCREENfillitemsendinfoState extends State<SCREENfillitemsendinfo> {
  final Weighttroller = TextEditingController();
  final Typecontroller = TextEditingController();
  final Feecontroller = TextEditingController();

  bool isNumericString(String input) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(input);
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
                  'Chi tiết hàng hóa',
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
                  'Cân nặng (bắt buộc)',
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
                          controller: Weighttroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cân nặng(kg)',
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
                  'Loại hàng (bắt buộc)',
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
                          controller: Typecontroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ví dụ : thực phẩm , đồ gia dụng , ...',
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
                  'Thu hộ COD (bắt buộc)',
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
                          controller: Feecontroller,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phí thu hộ tối thiểu là 1.000 VND hoặc 0 VND',
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
                        if (Typecontroller.text.isEmpty || Weighttroller.text.isEmpty || Feecontroller.text.isEmpty) {
                          toastMessage('phải điền đầy đủ các mục bắt buộc');
                        } else {
                          if (isNumericString(Weighttroller.text.toString()) && isNumericString(Feecontroller.text.toString())) {
                            if (int.parse(Feecontroller.text.toString()) >= 1000 || int.parse(Feecontroller.text.toString()) == 0) {
                              if (int.parse(Weighttroller.text.toString()) > 0) {
                                currentitemdetail.codFee = double.parse(Feecontroller.text.toString());
                                currentitemdetail.type = Typecontroller.text.toString();
                                currentitemdetail.weight = double.parse(Weighttroller.text.toString());
                                //Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENlocationitemsendst2(Distance: widget.Distance,)));
                              } else {
                                toastMessage('cân nặng phải > 0');
                              }
                            } else {
                              toastMessage('phí thu hộ chưa hợp lệ');
                            }
                          } else {
                            toastMessage('phải điền đúng định dạng số');
                          }
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
