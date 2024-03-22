import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/itemsendOrder.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/OTHER/Button/Buttontype1.dart';

import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/accountLocation.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Product/Useruse.dart';
import '../../../GENERAL/Product/Voucher.dart';
import '../../../GENERAL/Tool/Time.dart';
import '../../../GENERAL/utils/utils.dart';
import '../../FILL_INFOR/SCREENfillitemsendinfo.dart';
import '../../FILL_INFOR/SCREENfillreceiverinfor.dart';
import '../../INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../../VOUCHER/Khung chọn voucher.dart';
import '../../VOUCHER/SCREENvoucherchosen.dart';
import 'SCREENitemsend.dart';

class SCREENlocationitemsendst2 extends StatefulWidget {
  final double Distance;
  final accountLocation diemdon;
  final accountLocation diemtra;
  const SCREENlocationitemsendst2({Key? key, required this.Distance, required this.diemdon, required this.diemtra}) : super(key: key);

  @override
  State<SCREENlocationitemsendst2> createState() => _SCREENlocationitemsendst2State();
}

class _SCREENlocationitemsendst2State extends State<SCREENlocationitemsendst2> {
  String setlocation = "";
  String getlocation = "";
  Color receiverMancolor = Color.fromARGB(255, 244, 164, 84);
  Color inforordercolor = Color.fromARGB(255, 244, 164, 84);
  String receiverManText = 'Thêm thông tin người nhận';
  String infororderText = 'Thêm thông tin hàng hóa';
  final locationNotecontroller = TextEditingController();
  final Nametroller = TextEditingController();
  final Phonecontroller = TextEditingController();
  final Notecontroller = TextEditingController();
  final Weighttroller = TextEditingController();
  final Typecontroller = TextEditingController();
  final Feecontroller = TextEditingController();
  double cost = 0;
  bool isLoading = false;
  final voucherController = TextEditingController();
  Voucher chosenVoucher = Voucher(id: '', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0);

  bool bookingloading = false;
  bool voucherloading = false;

  int getCost(double distance) {
    int cost = 0;
    if (distance >= ItemCost.departKM) {
      cost += ItemCost.departKM.toInt() * ItemCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
      distance -= ItemCost.departKM; // Trừ đi 2km đã tính giá cước
      cost = cost + ((distance - ItemCost.departKM) * ItemCost.perKMcost).toInt();
    } else {
      cost += (distance * ItemCost.departCost).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  Future<void> pushitemSendOrder(itemsendOrder itemsend) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/itemsendOrder').child(itemsend.id).set(itemsend.toJson());
      print('Đẩy Order thành công');
      setState(() {
        bookingloading = false;
      });
      if (mounted) {
        toastMessage('Đặt đơn thành công , vui lòng kiểm tra lịch sử');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SCREENmain()));
      }
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  double getLastCost(double cost, Voucher voucher) {
    if (voucher.id != '') {
      if (voucher.type == 0) {
        cost = cost - voucher.totalmoney;
      } else {
        double sale = cost * (voucher.totalmoney.toDouble()/100);
        if (sale > voucher.maxSale) {
          return cost - voucher.maxSale;
        } else {
          return cost - sale;
        }
      }
    }
    return cost;
  }

  void VoucherChange() {
    if (chosenVoucher.id != '') {
      voucherController.text = (chosenVoucher.type == 0) ? (getStringNumber(chosenVoucher.totalmoney) + 'đ') : (getStringNumber(chosenVoucher.totalmoney) + '%');
    } else {
      voucherController.text = (chosenVoucher.type == 0) ? '0đ' : '0%';
    }
  }

  Future<void> pushUserCountData(String id, Voucher voucher) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child("VoucherStorage/" + id).set(voucher.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  bool isNumericString(String input) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(input);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.diemdon.firstText == "NA") {
      setlocation = widget.diemdon.Longitude.toString() + " , " + widget.diemdon.Latitude.toString();
    } else {
      setlocation = widget.diemdon.firstText;
    }

  }
  @override
  Widget build(BuildContext context) {
    cost = getCost(widget.Distance).toDouble();
    currentReceiver.location = widget.diemtra;
    if (currentReceiver.name != "NA") {
      receiverManText = currentReceiver.name + '-' + currentReceiver.phoneNum;
    }

    if (widget.diemtra.firstText == "NA") {
      getlocation = widget.diemtra.Longitude.toString() + " , " + widget.diemtra.Latitude.toString();
    } else {
      getlocation = widget.diemtra.firstText;
    }

    if (currentitemdetail.weight != -1) {
      infororderText = currentitemdetail.weight.toString() + " kg. " + currentitemdetail.type + " .Thu hộ : " + getStringNumber(currentitemdetail.codFee) + 'đ';
      if (currentitemdetail.codFee > 0) {
        cost = cost + 5000;
      }
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),

            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight/5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 255, 217, 169), Color.fromARGB(255, 255, 123, 64)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                    ),

                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 40,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              currentReceiver.changeToDefault();
                              currentitemdetail.changeToDefault();
                              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENitemsend()));
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
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: screenHeight/7,
                  left: 18,
                  child: Container(
                    width: screenWidth - 36,
                    height: screenHeight / 2.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Stack(
                      children: <Widget>[
                        ///điểm lấy hàng
                        Positioned(
                          top: 15,
                          left: 15,
                          child: Container(
                            height: screenWidth / 17,
                            width: screenWidth / 17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/bluecircle.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 18,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            compactString(35, setlocation),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 18 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            currentAccount.name + "-" + currentAccount.phoneNum,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black45,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        ///điểm nhận hàng
                        Positioned(
                          top: 75,
                          left: 15,
                          child: Container(
                            height: screenWidth / 17,
                            width: screenWidth / 17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/iconlocation.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 78,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            compactString(35, getlocation),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 78 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {
                              currentReceiver.phoneNum = 'NA';
                              currentReceiver.name = 'NA';
                              currentReceiver.note = 'NA';
                              currentReceiver.locationNote = 'NA';
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: screenHeight * 0.75,
                                        width: screenWidth,
                                        child: ListView(
                                          children: [
                                            Container(height: 20,),

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
                                                          hintText: 'Số điện thoại',
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

                                            Container(height: 30,),

                                            Padding(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: ButtonType1(Height: 60, Width: screenWidth-20, color: Color.fromARGB(255, 244, 164, 84), radiusBorder: 30, title: 'Xác nhận', fontText: 'arial', colorText: Colors.white,
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
                                                      setState(() {

                                                      });
                                                      Navigator.of(context).pop();
                                                    }
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Container(
                              child: Text(
                                receiverManText,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'arial',
                                  color: receiverMancolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///làm màu
                        Positioned(
                          top: 110 + screenWidth / 17,
                          left: 20,
                          child: Container(
                            height: 1,
                            width: screenWidth - 36 - 40,
                            decoration: BoxDecoration(
                                color: Colors.grey
                            ),
                          ),
                        ),

                        Positioned(
                          top: 145,
                          left: 10,
                          child: Container(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/linhtinh3.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 148,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            'Lấy hàng ngay(Trong 15 phút)',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 145 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              child: Text(
                                'Nhanh chóng và tiện lợi',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'arial',
                                  color: receiverMancolor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 195,
                          left: 10,
                          child: Container(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/linhtinh4.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 198,
                          left: 20 + screenWidth / 17,
                          child: Text(
                            'Xe máy',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 195 + screenWidth / 17,
                          left: 20 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              child: Text(
                                'Tối đa 50kg (50x50x50cm)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'arial',
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 235 + screenWidth / 17,
                          left: 20,
                          child: Container(
                            height: 1,
                            width: screenWidth - 36 - 40,
                            decoration: BoxDecoration(
                                color: Colors.grey
                            ),
                          ),
                        ),

                        ///thông tin hàng hóa
                        Positioned(
                          top: 265,
                          left: 15,
                          child: Container(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image/linhtinh5.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 268,
                          left: 25 + screenWidth / 17,
                          child: Text(
                            'Thông tin hàng hóa',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Positioned(
                          top: 268 + screenWidth / 17,
                          left: 25 + screenWidth / 17,
                          child: GestureDetector(
                            onTap: () {
                              currentitemdetail.weight = -1;
                              currentitemdetail.type = 'NA';
                              currentitemdetail.codFee = -1;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(
                                        width: screenWidth,
                                        height: screenHeight * 0.5,
                                        child: ListView(
                                          children: [
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
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'arial',
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: 'Chỉ nhập số',
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
                                                          hintText: 'Ví dụ : thực phẩm , đồ gia dụng , ...',
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
                                                'Phí thu hộ (bắt buộc)',
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
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'arial',
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: 'Tối thiểu 0đ,chỉ nhập số',
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
                                              child: ButtonType1(Height: 60, Width: screenWidth-20, color: Color.fromARGB(255, 244, 164, 84), radiusBorder: 30, title: 'Xác nhận', fontText: 'arial', colorText: Colors.white,
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
                                                            setState(() {

                                                            });
                                                            Navigator.of(context).pop();
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
                                    );
                                  }
                              );
                            },
                            child: Container(
                              child: Text(
                                infororderText,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'arial',
                                  color: inforordercolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: screenHeight/5 + 40,
                  left: 20,
                  child: Container(
                    height: 1,
                    width: screenWidth - 40,
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                  ),
                ),

                Positioned(
                  bottom: screenHeight/5,
                  left: 18,
                  child: Text(
                    "Tổng tiền ",
                    style: TextStyle(
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),

                Positioned(
                  bottom: screenHeight/5,
                  right: 18,
                  child: Text(
                    getStringNumber(cost.toDouble()) + "đ",
                    style: TextStyle(
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),

                Positioned(
                  bottom: 115,
                  left: 20,
                  child: Container(
                    child: Text(
                      'Chi phí vận chuyển(' + double.parse(widget.Distance.toStringAsFixed(1)).toString() + "km)",
                      style: TextStyle(
                          fontFamily: 'arial',
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 140,
                  left: 10,
                  right: 10,
                  child: Container(
                    width: screenWidth,
                    height: 18,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: screenWidth,
                            height: 18,
                            child: AutoSizeText(
                              '  Mã khuyến mãi',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 180
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 10,
                          child: Container(
                            width: screenWidth-10,
                            height: 18,
                            child: AutoSizeText(
                              "- " + voucherController.text,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Positioned(
                  bottom: 115,
                  right: 18,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: getStringNumber(getLastCost(cost, chosenVoucher)) + "đ",
                          style: TextStyle(
                            fontFamily: 'arial',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 40,
                  left: 18,
                  child: Container(
                    width: screenWidth/2 - 28,
                    height: 60,
                    child: ButtonType1(Height: 60, Width: screenWidth/2 - 28, color: Color.fromARGB(255, 244, 164, 84), radiusBorder: 30, title: 'Đặt đơn', fontText: 'arial', colorText: Colors.white,
                        onTap: () async {
                           if (currentReceiver.name != 'NA') {
                             if (currentitemdetail.type != 'NA') {
                               setState(() {
                                 bookingloading = true;
                               });

                               itemsendOrder itemorder = itemsendOrder(
                                   id: generateID(20),
                                   cost: getLastCost(cost, chosenVoucher),
                                   owner: currentAccount,
                                   shipper: accountNormal(id: "NA", avatarID: "NA", createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 1, name: "NA", phoneNum: "NA", type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), totalMoney: 0, Area: '', license: '', WorkStatus: 0),
                                   status: 'A',
                                   S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                   S1time: getCurrentTime(),
                                   S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                   S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                                   locationset: widget.diemdon,
                                   receiver: currentReceiver,
                                   itemdetails: currentitemdetail,
                                   voucher: chosenVoucher,
                                   costFee: ItemCost
                               );

                               if (chosenVoucher.id != '') {
                                 Useruse user = Useruse(id: '', count: 0);
                                 int index = -1;
                                 for(Useruse useruse in chosenVoucher.CustomList) {
                                   if (useruse.id == currentAccount.id) {
                                     user.id = useruse.id;
                                     user.count = useruse.count;
                                     index = chosenVoucher.CustomList.indexOf(useruse);
                                   }
                                 }

                                 if (user.id == '') {
                                   user.id = currentAccount.id;
                                   user.count = 1;
                                   chosenVoucher.CustomList.add(user);
                                   await pushUserCountData(chosenVoucher.id, chosenVoucher);
                                 } else {
                                   user.count = user.count + 1;
                                   chosenVoucher.CustomList[index].count = user.count;
                                   await pushUserCountData(chosenVoucher.id, chosenVoucher);
                                 }
                               }

                               await pushitemSendOrder(itemorder);
                             } else {
                               toastMessage('Bạn vui lòng hoàn thiện thông tin hàng hóa');
                             }
                           } else {
                             toastMessage('Bạn vui lòng hoàn thiện thông tin người nhận');
                           }
                        }, loading: bookingloading),
                  ),
                ),

                //Nút ưu đãi
                Positioned(
                  bottom: 40,
                  right: 18,
                  child: Container(
                    width: screenWidth/2 - 28,
                    height: 60,
                    child: ButtonType1(Height: 60, Width: screenWidth/2 - 28, color: Color.fromARGB(255, 255, 247, 237), radiusBorder: 30, title: 'Ưu đãi', fontText: 'arial', colorText: Color.fromARGB(255, 255, 123, 64),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ChosenVoucherWhenOrder(screenHeight: screenHeight, chosenVoucher: chosenVoucher, screenWidth: screenWidth,
                                setstateEvent: () {
                                  setState(() {
                                    VoucherChange();
                                    print(chosenVoucher.toJson().toString());
                                  });
                                }, cost: cost, voucherController: voucherController, Otype: '1',);
                            },
                          );
                        },
                        loading: voucherloading),
                  ),
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
