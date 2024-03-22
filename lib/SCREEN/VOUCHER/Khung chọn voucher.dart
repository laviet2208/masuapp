import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/foodOrder.dart';
import 'package:masuapp/GENERAL/Product/Useruse.dart';
import 'package:masuapp/GENERAL/Product/Voucher.dart';
import 'package:masuapp/SCREEN/VOUCHER/Item%20ch%E1%BB%8Dn%20voucher.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/Tool/Time.dart';
import '../../GENERAL/Tool/Tool.dart';
import '../../GENERAL/utils/utils.dart';
import 'ITEMvoucherview.dart';

class ChosenVoucherWhenOrder extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final Voucher chosenVoucher;
  final double cost;
  final VoidCallback setstateEvent;
  final TextEditingController voucherController;
  final String Otype;
  const ChosenVoucherWhenOrder({Key? key, required this.screenHeight, required this.chosenVoucher, required this.screenWidth, required this.setstateEvent, required this.cost,required this.voucherController, required this.Otype}) : super(key: key);

  @override
  State<ChosenVoucherWhenOrder> createState() => _ChosenVoucherWhenOrderState();
}

class _ChosenVoucherWhenOrderState extends State<ChosenVoucherWhenOrder> {
  final List<Voucher> voucherList = [];
  int count = 0;
  void getVoucherData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        Voucher voucher = Voucher.fromJson(value);
        if (voucher.LocationId == currentAccount.Area) {
          voucherList.add(voucher);
        }
      });
      setState(() {

      });
    });
  }

  int getUseCount(Voucher voucher){
    for(Useruse useruse in voucher.CustomList) {
      if (useruse.id == currentAccount.id) {
        return useruse.count;
      }
    }
    return 0;
  }

  void VoucherChange(Voucher voucher) {
    if (voucher.id != '') {
      widget.voucherController.text = (voucher.type == 0) ? (getStringNumber(voucher.totalmoney) + 'đ') : (getStringNumber(voucher.totalmoney) + '%');
    } else {
      widget.voucherController.text = (voucher.type == 0) ? '0đ' : '0%';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVoucherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.screenWidth,
        height: widget.screenHeight/2,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Bỏ chọn voucher',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent
                        ),
                      ),
                      onTap: () {
                        widget.chosenVoucher.changeToDefault();
                        VoucherChange(widget.chosenVoucher);
                        widget.setstateEvent();
                        setState(() {

                        });
                        Navigator.of(context).pop();
                      },
                    ),

                    Container(width: 20,),

                    GestureDetector(
                      child: Text(
                        'Đóng   ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Container(
                height: widget.screenHeight/2-40,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: voucherList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                        child: InkWell(
                          onTap: () {

                          },
                          child: ItemVoucherChosen(voucher: voucherList[index], width: widget.screenWidth - 20,
                            chosenTap: () {
                            int count = 0;
                            for (int i = 0 ; i < voucherList[index].CustomList.length ; i++) {
                              count = count + voucherList[index].CustomList.elementAt(i).count;
                            }
                              if (count < voucherList[index].maxCount) {
                                if (compareTimes(Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year), voucherList[index].endTime) && compareTimes(voucherList[index].startTime, Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year))) {
                                  if (voucherList[index].mincost <= widget.cost) {
                                    if (voucherList[index].totalmoney < widget.cost) {
                                      if (voucherList[index].LocationId == currentAccount.Area) {
                                        if ((voucherList[index].Otype == '1' && widget.Otype == '1') || widget.Otype == '3') {
                                          if (getUseCount(voucherList[index]) < voucherList[index].perCustom) {
                                            toastMessage(voucherList[index].tenchuongtrinh);
                                            widget.chosenVoucher.Setdata(voucherList[index]);
                                            VoucherChange(voucherList[index]);
                                            widget.setstateEvent();
                                            Navigator.of(context).pop();
                                            setState(() {

                                            });
                                          } else {
                                            toastMessage('Bạn đã hết lượt sử dụng voucher này');
                                          }
                                        } else {
                                          toastMessage('Voucher không áp dụng');
                                        }
                                      } else {
                                        toastMessage('Voucher không áp dụng cho khu vực này');
                                      }
                                    } else {
                                      toastMessage('Giá trị đơn phái lớn hơn số tiền giảm');
                                    }
                                  } else {
                                    toastMessage('Đơn của bạn chưa đủ điều kiện áp dụng');
                                  }
                                } else {
                                  toastMessage('Voucher không trong thời hạn dùng');
                                }
                              } else {
                                toastMessage('Voucher này đã hết lượt dùng');
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
