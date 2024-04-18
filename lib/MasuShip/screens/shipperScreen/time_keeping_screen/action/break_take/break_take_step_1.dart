import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/accountData/timeKeeping.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/time_keeping_screen/action/break_take/break_take_controller.dart';

import '../../../../../Data/otherData/Time.dart';

class break_take_step_1 extends StatefulWidget {
  final Time time;
  const break_take_step_1({super.key, required this.time});

  @override
  State<break_take_step_1> createState() => _break_take_step_1State();
}

class _break_take_step_1State extends State<break_take_step_1> {
  bool loading = false;
  final noteController = TextEditingController();
  List<String> shiftTypes = ['Nghỉ cả ngày', 'Nghỉ ca sáng 8-12h', 'Nghỉ ca chiều ', 'Nghỉ ca tối'];
  List<String> reasonTypes = ['Gia đình có việc', 'Bản thân có việc', 'Có tang', 'Có hỉ', 'Lí do khác'];
  String chosenShift = '';
  int shiftType = 0;
  int reasonType = 0;
  String chosenReason = '';

  void dropdownReason(String? selectedValue) {
    if (selectedValue is String) {
      chosenReason = selectedValue;
    }
    setState(() {

    });
  }

  void dropdownShift(String? selectedValue) {
    if (selectedValue is String) {
      chosenShift = selectedValue;
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenShift = shiftTypes.first;
    chosenReason = reasonTypes.first;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    double height = MediaQuery.of(context).size.height * 2 / 3;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Chọn lí do nghỉ',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
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
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: Colors.black, width: 1)
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButton<String>(
                      items: reasonTypes.map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e, style: TextStyle(fontFamily: 'muli'),),
                      )).toList(),
                      onChanged: (value) { dropdownReason(value); },
                      value: chosenReason,
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      iconDisabledColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Chọn ca nghỉ',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
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
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: Colors.black, width: 1)
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButton<String>(
                      items: shiftTypes.map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e, style: TextStyle(fontFamily: 'muli'),),
                      )).toList(),
                      onChanged: (value) { dropdownReason(value); },
                      value: chosenShift,
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      iconDisabledColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Chi tiết lí do nghỉ(Bắt buộc)',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                ),
              ),
            ),

            Container(height: 5,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black
                  )
                ),
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
                      hintText: 'Lí do chi tiết(Bắt buộc)',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'muli',
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (noteController.text.isNotEmpty) {
              setState(() {
                loading = true;
              });
              if (await break_take_controller.check_if_can_keeping_request(widget.time)) {
                timeKeeping time = timeKeeping(reasonType: reasonTypes.indexOf(chosenReason), shift: shiftTypes.indexOf(chosenShift), reason: noteController.text.toString(), dayOff: widget.time, owner: finalData.shipper_account, status: 0, id: generateID(15));
                await break_take_controller.push_keeping_request(time);
                toastMessage('Gửi yêu cầu thành công');
              } else {
                toastMessage('Ngày này đã có lịch rồi');
              }
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              toastMessage('Bạn phải nhập chi tiết lí do');
            }
          },
          child: Text(
            'Gửi yêu cầu',
            style: TextStyle(
              fontFamily: 'muli',
              color: Colors.blueAccent
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () {

          },
          child: Text(
            'Quay lại',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.red
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.red,),
      ],
    );
  }
}
