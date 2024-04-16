import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/back_button_in_wait.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/action/change_name_and_phone.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/express_step_2.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/location_title_custom_express.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import '../../../Data/OrderData/expressOrder/expressOrder.dart';
import '../../../Data/OrderData/expressOrder/personInfo.dart';
import '../../../Data/otherData/Time.dart';
import '../../../Data/otherData/utils.dart';
import '../../../Data/voucherData/Voucher.dart';
import '../general/search_location_dialog.dart';
import '../main_screen/user_main_screen.dart';

class express_step_1 extends StatefulWidget {
  const express_step_1({super.key});

  @override
  State<express_step_1> createState() => _express_step_1State();
}

class _express_step_1State extends State<express_step_1> {
  bool loading = false;
  int weightType = 0;
  final itemController = TextEditingController();
  final moneyController = TextEditingController();
  final noteController = TextEditingController();
  String chosenWeight = '';
  String chosenPayer = '';
  List<String> weightList = ['Dưới 10kg', 'Từ 10 - 25kg', 'Trên 25kg'];
  List<String> payerList = ['Người nhận trả ship', 'Người gửi trả ship'];


  expressOrder order = expressOrder(
    id: generateID(25),
    locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    cost: 0,
    owner: finalData.user_account,
    shipper: finalData.shipper_account,
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    costFee: finalData.bikeCost,
    subFee: 0,
    codMoney: 0,
    sender: personInfo(name: '', phone: ''),
    receiver: personInfo(name: '', phone: ''),
    item: '',
    weightType: 1,
    note: '',
    payer: 1,
  );

  void dropdownWeight(String? selectedValue) {
    if (selectedValue is String) {
      chosenWeight = selectedValue;
      if (chosenWeight == 'Dưới 10kg') {
        weightType = 0;
      }

      if (chosenWeight == 'Từ 10 - 25kg') {
        weightType = 1;
      }

      if (chosenWeight == 'Trên 25kg') {
        weightType = 2;
      }
    }
    setState(() {

    });
  }

  void dropdownPayer(String? selectedValue) {
    if (selectedValue is String) {
      chosenPayer = selectedValue;
    }
    setState(() {

    });
  }

  bool check_fill_data() {
    if (itemController.text.isNotEmpty) {
      if (order.locationSet.longitude != 0 && order.locationSet.latitude != 0 && order.locationGet.longitude != 0 && order.locationGet.latitude != 0) {
        if (order.sender.name != '' && order.sender.phone != '' && order.receiver.name != '' && order.receiver.name != '') {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenWeight = weightList.first;
    chosenPayer = payerList.first;
    order.sender.name = finalData.user_account.name;
    order.sender.phone = finalData.user_account.phone;
    order.locationSet.longitude = finalData.user_account.location.longitude;
    order.locationSet.latitude = finalData.user_account.location.latitude;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
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

              back_button_in_wait(),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 350,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 20),
                            children: [
                              Container(height: 15,),

                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Mặt hàng cần gửi',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black, width: 1)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Form(
                                        child: TextFormField(
                                          controller: itemController,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'muli',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Bạn muốn gửi mặt hàng gì vậy?',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'muli',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 15,),

                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Trọng lượng',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black, width: 1)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: DropdownButton<String>(
                                        items: weightList.map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e, style: TextStyle(fontFamily: 'muli'),),
                                        )).toList(),
                                        onChanged: (value) { dropdownWeight(value); },
                                        value: chosenWeight,
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 15,),

                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Người trả phí ship',
                                  style: TextStyle(
                                      fontFamily: 'muli',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black
                                  ),
                                ),
                              ),

                              Container(height: 5,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black, width: 1)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: DropdownButton<String>(
                                        items: payerList.map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e, style: TextStyle(fontFamily: 'muli'),),
                                        )).toList(),
                                        onChanged: (value) { dropdownPayer(value); },
                                        value: chosenPayer,
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        iconDisabledColor: Colors.grey,
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
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.add_shopping_cart, title: 'Thông tin hàng gửi'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,
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
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(1000)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
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
                                          'Người gửi',
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
                                              return change_name_and_phone(event: () {setState(() {});}, type: 1, info: order.sender,);
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: general_ingredient.get_location_text(order.sender.name + ' - ' + (order.sender.phone[0] != '0' ? '0' + order.sender.phone : order.sender.phone), Colors.black),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    location_title_custom_express(type: 'start', title: 'Chọn điểm lấy hàng'),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return search_location_dialog(location: order.locationSet, title: 'Chọn điểm lấy hàng', event: () {
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
                                  future: fetchLocationName(order.locationSet),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return general_ingredient.get_location_text('Đang tải vị trí ...',Colors.black);
                                    }

                                    if (snapshot.hasError) {
                                      return general_ingredient.get_location_text('Lỗi vị trí vui lòng thử lại',Colors.black);
                                    }

                                    if (!snapshot.hasData) {
                                      return general_ingredient.get_location_text('Lỗi vị trí vui lòng thử lại', Colors.black);
                                    }

                                    return general_ingredient.get_location_text(snapshot.data!.toString(), Colors.black);
                                  },
                                ),
                              ),

                              Container(height: 20,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.send_and_archive_outlined, title: 'Thông tin người gửi'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,
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
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(1000)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
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
                                          'Người nhận',
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
                                              return change_name_and_phone(info: order.receiver, event: () {setState(() {});}, type: 2);
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: general_ingredient.get_location_text(order.receiver.name == '' ? 'Thêm thông tin người nhận' : (order.receiver.name + ' - ' + (order.receiver.phone[0] != '0' ? '0' + order.receiver.phone : order.receiver.phone)), order.receiver.name == '' ? Colors.redAccent : Colors.black),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    location_title_custom_express(type: 'end', title: 'Chọn điểm giao hàng'),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return search_location_dialog(location: order.locationGet, title: 'Chọn điểm giao', event: () {
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
                                child: general_ingredient.get_location_text(order.locationGet.mainText + ',' + order.locationGet.secondaryText, Colors.black),
                              ),

                              Container(height: 20,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.emoji_people, title: 'Thông tin người nhận'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 120,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                        child: Form(
                                          child: TextFormField(
                                            controller: moneyController,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'muli',
                                            ),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số và dấu chấm
                                            ],
                                            keyboardType: TextInputType.numberWithOptions(decimal: true), // Hiển thị bàn phím số với dấu chấm
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Số tiền thu hộ',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: 'muli',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 35,
                                right: 30,
                                child: Text(
                                  '.đ',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.money, title: 'Phí thu hộ'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 240,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: Padding(
                            padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                child: Form(
                                    child: TextFormField(
                                      maxLines: null,
                                      controller: noteController,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'muli',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Ghi chú đơn hàng(không bắt buộc)',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'muli',
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.note_alt_outlined, title: 'Ghi chú đơn hàng'),
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
                    height: 45,
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
                      child: !loading ? Text(
                        'Bước tiếp theo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ) : CircularProgressIndicator(color: Colors.black,),
                    ),
                  ),
                  onTap: () async {
                    if (check_fill_data()) {
                      setState(() {
                        loading = true;
                      });
                      order.note = noteController.text.isNotEmpty ? noteController.text.toString() : 'Không có ghi chú';
                      order.item = itemController.text.toString();
                      order.locationSet.mainText = await fetchLocationName(order.locationSet);
                      order.locationGet.mainText = await fetchLocationName(order.locationGet);
                      order.weightType = weightType;
                      order.payer = chosenPayer == 'Người gửi trả ship' ? 1 : 2;
                      if (moneyController.text.isNotEmpty) {
                        order.codMoney = double.parse(moneyController.text.toString());
                      }
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => express_step_2(order: order),),);
                    } else {
                      toastMessage('Bạn cần điền đủ thông tin');
                    }
                  },
                ),
              ),

              Container(height: 30,),


            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
        return true;
      },
    );
  }
}
