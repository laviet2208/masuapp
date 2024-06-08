import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/express_step_1.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/location_title_custom_express.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/start_express_order_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/back_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import '../../../Data/otherData/Tool.dart';
import '../general/voucher_select.dart';

class express_step_2 extends StatefulWidget {
  final expressOrder order;
  const express_step_2({super.key, required this.order,});

  @override
  State<express_step_2> createState() => _express_step_2State();
}

class _express_step_2State extends State<express_step_2> {
  double weightFee = 0;
  String weightType = 'Dưới 10kg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.weightType == 1) {
      weightFee = 10000;
      weightType = 'Từ 10 -> 20kg';
    }

    if (widget.order.weightType == 2) {
      weightFee = 20000;
      weightType = 'Trên 20kg';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: get_usually_decoration_gradient(),
          child: ListView(
            children: [
              Container(height: 20,),

              back_button(beforeWidget: express_step_1()),

              Container(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 220,
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

                              location_title_custom_express(type: 'start', title: 'Điểm lấy hàng',),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: general_ingredient.get_location_text(widget.order.locationSet.mainText + ' ' + widget.order.locationSet.secondaryText, Colors.black),
                              ),

                              Container(
                                width: 40,
                              ),

                              location_title_custom_express(type: 'end', title: 'Điểm giao hàng',),

                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 10),
                                child: general_ingredient.get_location_text(widget.order.locationGet.mainText + ' ' + widget.order.locationGet.secondaryText, Colors.black),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.not_listed_location_outlined, title: 'Thông tin điểm lấy, giao hàng'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 260,
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Phí thu hộ', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(widget.order.codMoney) + ".đ", Colors.black, FontWeight.normal, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Tên hàng hóa', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(widget.order.item, Colors.black, FontWeight.normal, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Sđt người gửi', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(widget.order.sender.phone, Colors.black, FontWeight.normal, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Sđt người nhận', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(widget.order.receiver.phone, Colors.black, FontWeight.normal, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Trọng lượng', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(weightType, Colors.black, FontWeight.normal, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.delivery_dining, title: 'Thông tin hàng hóa'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 320,
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
                                child: Padding(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: FutureBuilder(
                                    future: getDistance(widget.order.locationSet, widget.order.locationGet),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Row(
                                          children: [
                                            Container(width: 10,),
                                            general_ingredient.get_cost_title('Chi phí di chuyển(...km)', Colors.black, FontWeight.bold, width),
                                            general_ingredient.get_cost_content('Đang tính toán giá tiền', Colors.black, FontWeight.bold, width)
                                          ],
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return Row(
                                          children: [
                                            Container(width: 10,),
                                            general_ingredient.get_cost_title('Chi phí di chuyển(Lỗi)', Colors.black, FontWeight.bold, width),
                                            general_ingredient.get_cost_content('Lỗi', Colors.black, FontWeight.bold, width)
                                          ],
                                        );
                                      }

                                      if (!snapshot.hasData) {
                                        return Row(
                                          children: [
                                            Container(width: 10,),
                                            general_ingredient.get_cost_title('Chi phí di chuyển(Lỗi)', Colors.black, FontWeight.bold, width),
                                            general_ingredient.get_cost_content('Lỗi', Colors.black, FontWeight.bold, width)
                                          ],
                                        );
                                      }

                                      return Row(
                                        children: [
                                          Container(width: 10,),
                                          general_ingredient.get_cost_title('Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + 'Km)', Colors.black, FontWeight.bold, width),
                                          general_ingredient.get_cost_content(getStringNumber(getShipCost(snapshot.data!, widget.order.costFee)) + '.đ', Colors.black, FontWeight.bold, width)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Phụ phí thời tiết', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content('Chưa có', Colors.black, FontWeight.bold, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Phụ phí cân nặng', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(weightFee) + ".đ", Colors.black, FontWeight.bold, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Người trả ship', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(widget.order.payer == 1 ? 'Người gửi' : 'Người nhận', Colors.black, FontWeight.bold, width),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Mã giảm giá', Colors.black, FontWeight.bold, width),
                                    ),

                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 7, bottom: 7),
                                        child: general_ingredient.get_cost_content(widget.order.voucher.id == '' ? "Chọn mã giảm giá" : ('- ' + getStringNumber(getVoucherSale(widget.order.voucher, widget.order.cost)) + '.đ'), Colors.redAccent, FontWeight.bold, width),
                                      ),
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return voucher_select(voucher: widget.order.voucher, ontap: () {setState(() {});}, cost: widget.order.cost);
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.red
                                  ),
                                ),
                              ),

                              Container(height: 10,),

                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: general_ingredient.get_cost_title('Tổng thanh toán', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: getDistance(widget.order.locationSet, widget.order.locationGet),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_content('Đang tính toán', Colors.black, FontWeight.bold, width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_content('Lỗi tính toán', Colors.black, FontWeight.bold, width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_content('Lỗi tính toán', Colors.black, FontWeight.bold, width);
                                            }

                                            return general_ingredient.get_cost_content(getStringNumber(getShipCost(snapshot.data!, widget.order.costFee) - getVoucherSale(widget.order.voucher, widget.order.cost) + weightFee + widget.order.subFee) + '.đ', Colors.black, FontWeight.bold, width);
                                            },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.monetization_on_outlined, title: 'Thông tin thanh toán'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              start_express_order_button(order: widget.order),

              Container(height: 20,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => express_step_1(),),);
        return true;
      },
    );
  }
}
