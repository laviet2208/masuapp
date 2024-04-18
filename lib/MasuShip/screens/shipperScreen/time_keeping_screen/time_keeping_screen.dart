import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/shipper_main_screen.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/time_keeping_screen/action/keeping_actions_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Data/accountData/timeKeeping.dart';
import '../../../Data/otherData/Time.dart';

class time_keeping_screen extends StatefulWidget {
  const time_keeping_screen({super.key});

  @override
  State<time_keeping_screen> createState() => _time_keeping_screenState();
}

class _time_keeping_screenState extends State<time_keeping_screen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<timeKeeping> list = [];

  bool check_if_in_list(Time time) {
    return list.any((timeKeeping) => timeKeeping.dayOff == time);
  }

  Map<DateTime, List> _events = {
    DateTime.utc(2024, 4, 10): ['Event 1'],
    DateTime.utc(2024, 4, 15): ['Event 2'],
    DateTime.utc(2024, 4, 20): ['Event 3'],
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
          child: ListView(
            children: [
              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Container(width: 10,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),

                        Container(width: 10,),

                        Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 2),
                          child: Container(
                            width: width - 80,
                            child: AutoSizeText(
                              'Chi tiết chấm công',
                              style: TextStyle(
                                fontSize: 100,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli'
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => shipper_main_screen()), (route) => false,);
                  },
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: TableCalendar(
                    calendarFormat: CalendarFormat.month,
                    focusedDay: _focusedDay,
                    onFormatChanged: null,
                    availableCalendarFormats: {
                      CalendarFormat.month: 'Tháng',
                      CalendarFormat.week: 'Tuần',
                    },
                    firstDay: DateTime.utc(2024, 3, 3),
                    lastDay: DateTime.utc(2026, 12, 31),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    eventLoader: (day) {
                      return _events[day] ?? [];
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      showDialog(
                        context: context,
                        builder: (context) {
                          return keeping_action_dialog(time: Time(second: selectedDay.second, minute: selectedDay.minute, hour: selectedDay.hour, day: selectedDay.day, month: selectedDay.month, year: selectedDay.year),);
                        },
                      );
                    },
                    calendarStyle: CalendarStyle(
                      // Thay đổi màu nền của các ngày được chọn
                      selectedDecoration: BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      isTodayHighlighted: false,
                      defaultDecoration: BoxDecoration(),
                      markerSize: 20,
                      markerDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    // Chỉ cho người dùng chọn các ngày từ ngày hiện tại trở đi
                    enabledDayPredicate: (DateTime day) {
                      final now = DateTime.now();
                      return !day.isBefore(DateTime(now.year, now.month, now.day));
                    },
                  ),

                ),
              )
            ],
          )
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
