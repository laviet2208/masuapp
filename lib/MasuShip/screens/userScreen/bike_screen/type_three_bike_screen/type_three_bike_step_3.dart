import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/Ingredient/start_order_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/controller/general_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_three_bike_screen/type_three_bike_step_1.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/back_button.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../general/voucher_select.dart';

class type_three_bike_step_3 extends StatefulWidget {
  final Location startLocation;
  final List<Location> customerLocations;
  final List<Location> bikeLocations;
  const type_three_bike_step_3({super.key, required this.customerLocations, required this.bikeLocations, required this.startLocation});

  @override
  State<type_three_bike_step_3> createState() => _type_three_bike_step_3State();
}

class _type_three_bike_step_3State extends State<type_three_bike_step_3> {
  motherOrder order = motherOrder(id: generateID(25), locationSet: finalData.shipper_account.location, locationGet: finalData.shipper_account.location, cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: 'UC', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), orderList: [], createTime: getCurrentTime());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    order.locationSet = widget.startLocation;
    order.locationGet = widget.startLocation;
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
              Container(height: 30,),

              back_button(beforeWidget: type_three_bike_step_1()),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 86 * widget.customerLocations.length + 40,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 25),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.customerLocations.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 15,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            child: FutureBuilder(
                                              future: getDistance(widget.startLocation,widget.customerLocations[index]),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return general_ingredient.get_distance_text('Chi phí đưa khách về ' + widget.customerLocations[index].mainText, width);
                                                }

                                                if (snapshot.hasError) {
                                                  return general_ingredient.get_distance_text('Vui lòng chọn hoặc cho phép vị trí', width);
                                                }

                                                if (!snapshot.hasData) {
                                                  return general_ingredient.get_distance_text('Vui lòng chọn hoặc cho phép vị trí', width);
                                                }

                                                return general_ingredient.get_distance_text('Chi phí đưa khách về ' + widget.customerLocations[index].mainText + ' (' + snapshot.data!.toStringAsFixed(1) + ' Km)', width);
                                              },
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            alignment: Alignment.centerRight,
                                            child: FutureBuilder(
                                              future: getShipCostByAPI(widget.startLocation, widget.customerLocations[index], 0, finalData.bikeShipCost),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return general_ingredient.get_loading(width);
                                                }

                                                if (snapshot.hasError) {
                                                  return general_ingredient.get_money_text('Lỗi tính toán, hãy thử lại nhé', width);
                                                }

                                                if (!snapshot.hasData) {
                                                  return general_ingredient.get_money_text('Lỗi tính toán, hãy thử lại nhé', width);
                                                }

                                                return general_ingredient.get_money_text(getStringNumber(snapshot.data!) + '.đ', width);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      height: index == widget.customerLocations.length - 1 ? 0 : 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  Container(height: 5,)
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.monetization_on_outlined, title: 'Hóa đơn chở khách hàng'),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 86 * widget.bikeLocations.length + 40,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: get_usually_decoration(),
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 25),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.bikeLocations.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            child: FutureBuilder(
                                              future: getDistance(widget.startLocation ,widget.bikeLocations[index]),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return general_ingredient.get_distance_text('Chi phí đưa khách về ' + widget.bikeLocations[index].mainText, width);
                                                }

                                                if (snapshot.hasError) {
                                                  return general_ingredient.get_distance_text('Vui lòng chọn hoặc cho phép vị trí', width);
                                                }

                                                if (!snapshot.hasData) {
                                                  return general_ingredient.get_distance_text('Vui lòng chọn hoặc cho phép vị trí', width);
                                                }

                                                return general_ingredient.get_distance_text('Chi phí lái xe về ' + widget.bikeLocations[index].mainText + ' (' + snapshot.data!.toStringAsFixed(1) + ' Km)', width);
                                              },
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: 7, bottom: 7),
                                          child: Container(
                                            height: 60,
                                            width: (width - 40 - 20)/2,
                                            alignment: Alignment.centerRight,
                                            child: FutureBuilder(
                                              future: getShipCostByAPI(widget.startLocation, widget.bikeLocations[index], 0, finalData.bikeShipCost),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return general_ingredient.get_loading(width);
                                                }

                                                if (snapshot.hasError) {
                                                  return general_ingredient.get_money_text('Lỗi tính toán, hãy thử lại nhé', width);
                                                }

                                                if (!snapshot.hasData) {
                                                  return general_ingredient.get_money_text('Lỗi tính toán, hãy thử lại nhé', width);
                                                }

                                                return general_ingredient.get_money_text(getStringNumber(snapshot.data!) + '.đ', width);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      height: index == widget.bikeLocations.length - 1 ? 0 : 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  Container(height: 5,)
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.money, title: 'Hóa đơn lái xe hộ'),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 250,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
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

                                    general_ingredient.get_cost_title('Tổng hóa đơn', width, 7),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: general_controller.get_total(widget.customerLocations, widget.bikeLocations, widget.startLocation, finalData.bikeShipCost),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_loading(width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_money('Lỗi tính toán', width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_money('Lỗi tính toán', width);
                                            }

                                            return general_ingredient.get_cost_money(getStringNumber(double.parse(snapshot.data.toString())) + '.đ', width);
                                          },
                                        ),
                                      ),
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

                                    general_ingredient.get_cost_title('Phụ thu', width, 7),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: general_ingredient.get_cost_money('0.đ', width),
                                      ),
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

                                    general_ingredient.get_cost_title('Mã giảm giá', width, 7),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: GestureDetector(
                                        child: Container(
                                          height: 30,
                                          width: (width - 40 - 20)/2,
                                          alignment: Alignment.centerRight,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: order.voucher.id == '' ? "Chọn mã giảm giá" : ('- ' + getStringNumber(getVoucherSale(order.voucher, order.cost)) + '.đ'),
                                                  style: TextStyle(
                                                    fontFamily: 'muli',
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: order.voucher.id == '' ? 12 : 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return voucher_select(voucher: order.voucher, ontap: () {
                                                setState(() {

                                                });
                                              }, cost: order.cost);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 0.5,
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

                                    general_ingredient.get_cost_title('Tổng thanh toán', width, 4),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: general_controller.get_total(widget.customerLocations, widget.bikeLocations, widget.startLocation, finalData.bikeShipCost),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_loading(width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_money('Lỗi tính toán', width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_money('Lỗi tính toán', width);
                                            }

                                            return general_ingredient.get_cost_money(getStringNumber(double.parse(snapshot.data.toString()) - getVoucherSale(order.voucher, order.cost)) + '.đ', width);
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
                        child: title_gradient_container(icon: Icons.attach_money, title: 'Tổng hóa đơn đơn hàng'),
                      ),
                    ],
                  ),
                ),
              ),

              start_order_button(startLocation: widget.startLocation, customerLocations: widget.customerLocations, bikeLocations: widget.bikeLocations, order: order,),

              Container(height: 40,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => type_three_bike_step_1(),),);
        return true;
      },
    );
  }
}
