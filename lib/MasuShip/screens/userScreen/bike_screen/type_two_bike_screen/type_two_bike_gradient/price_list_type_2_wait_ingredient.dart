import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/general/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_two_bike_screen/controller/type_two_wait_controller.dart';

import '../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../Data/otherData/Tool.dart';

class price_list_type_2_wait_ingredient extends StatefulWidget {
  final String id;
  const price_list_type_2_wait_ingredient({super.key, required this.id});

  @override
  State<price_list_type_2_wait_ingredient> createState() => _price_list_type_2_wait_ingredientState();
}

class _price_list_type_2_wait_ingredientState extends State<price_list_type_2_wait_ingredient> {
  Padding get_left_title_text(String title, double width) {
    return Padding(
      padding: EdgeInsets.only(top: 7, bottom: 7),
      child: Container(
        height: 30,
        width: (width - 40 - 20)/2,
        child: AutoSizeText(
          title,
          style: TextStyle(
              fontFamily: 'muli',
              color: Colors.black,
              fontSize: 200,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Padding get_right_content_text(String title, double width, Color color) {
    return Padding(
      padding: EdgeInsets.only(top: 7, bottom: 7),
      child: Container(
        height: 30,
        width: (width - 40 - 20)/2,
        alignment: Alignment.centerRight,
        child: Container(
          height: 30,
          width: (width - 40 - 20)/2,
          child: AutoSizeText(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontFamily: 'muli',
                color: color,
                fontSize: 200,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Column data_container(CatchOrder order, double width) {
    return Column(
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
                child: Container(
                  height: 30,
                  width: (width - 40 - 20)/2,
                  child: FutureBuilder(
                    future: getDistance(order.locationSet, order.locationGet),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Chi phí di chuyển(...km)', style: TextStyle(color: Colors.black, fontSize: 15),);
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return Text('Lỗi vị trí, vui lòng thử lại', style: TextStyle(color: Colors.black, fontSize: 15),);
                      }

                      if (!snapshot.hasData) {
                        return Text('Lỗi vị trí, vui lòng thử lại', style: TextStyle(color: Colors.black, fontSize: 15),);
                      }

                      return Container(
                        height: 30,
                        width: (width - 40 - 20)/2,
                        child: AutoSizeText(
                          order.locationGet.longitude != 0 ? 'Chi phí di chuyển(' + snapshot.data!.toStringAsFixed(1) + ' Km)' : 'Chi phí di chuyển(...Km)',
                          style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontSize: 200,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              get_right_content_text(order.locationGet.longitude != 0 ? (getStringNumber(order.cost) + '.đ') : ('Chưa đến nơi'), width, Colors.black),
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

              get_left_title_text('Phí phụ thu', width),

              get_right_content_text(getStringNumber(order.subFee) + ".đ", width, Colors.black),
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

              get_left_title_text('Mã giảm giá', width),

              get_right_content_text(order.voucher.id == '' ? "Không áp giảm giá" : ('- ' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'), width, Colors.red),
            ],
          ),
        ),

        Container(height: 10,),

        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                color: Colors.deepOrange
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
                child: Container(
                  height: 30,
                  width: (width - 40 - 20)/2,
                  child: AutoSizeText(
                    'Tổng thanh toán',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 200,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Container(
                  height: 30,
                  width: (width - 40 - 20)/2,
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    order.locationGet.longitude != 0 ? (getStringNumber(order.cost - getVoucherSale(order.voucher, order.cost)) + '.đ') : 'Chưa đến nơi',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 200,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(height: 10,),
      ],
    );
  }

  void setStateEvent() {
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: get_usually_decoration(),
      child: StreamBuilder<CatchOrder>(
        stream: type_two_wait_controller.getUnCompleteOrderDataStream(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return general_ingredient.loading_container();
          }

          if (snapshot.hasError) {
            return general_ingredient.error_container();
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return general_ingredient.error_container();
          }

          return data_container(snapshot.data!, width);
        },
      ),
    );
  }
}
