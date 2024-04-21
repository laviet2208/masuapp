import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/ingredient/location_title_custom_express.dart';
import 'package:masuapp/MasuShip/screens/userScreen/general/title_gradient_container.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/food_order_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/food_order_step_1/item_food_view.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/ingredient/start_food_order_button.dart';
import '../../../general/search_location_dialog.dart';
import '../../../general/voucher_select.dart';

class food_order_step_1 extends StatefulWidget {
  final Widget beforeWidget;
  final foodOrder order;
  const food_order_step_1({super.key, required this.beforeWidget, required this.order});

  @override
  State<food_order_step_1> createState() => _food_order_step_1State();
}

class _food_order_step_1State extends State<food_order_step_1> {
  TextEditingController noteController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.withAlpha(200) ,Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
          child: ListView(
            children: [
              Container(height: 20,),

              Container(
                height: 30,
                child: Row(
                  children: [
                    Container(width: 10,),

                    GestureDetector(
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
                      },
                    ),

                  ],
                ),
              ),

              Container(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 150,
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
                                    location_title_custom_express(type: 'start', title: 'Điểm nhận đồ ăn'),

                                    GestureDetector(
                                      child: Container(
                                        child: Icon(Icons.mode_edit_outline_outlined, color: Colors.grey,size: 20,),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return search_location_dialog(location: widget.order.locationGet, title: 'Chọn điểm nhận hàng', event: () {
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
                                  future: fetchLocationName(widget.order.locationGet),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return general_ingredient.get_location_text('Đang tải vị trí...', Colors.black);
                                    }

                                    if (snapshot.hasError) {
                                      return general_ingredient.get_location_text('Vui lòng chọn hoặc cho phép vị trí', Colors.black);
                                    }

                                    if (!snapshot.hasData) {
                                      return general_ingredient.get_location_text('Vui lòng chọn hoặc cho phép vị trí', Colors.black);
                                    }

                                    return general_ingredient.get_location_text(snapshot.data!.toString(), Colors.black);
                                  },
                                ),
                              ),

                              Container(height: 30,),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.add_location_alt_outlined, title: 'Vị trí nhận đồ ăn'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 80 * finalData.cartList.length.toDouble() + 50,
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
                            padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
                            child: Container(
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 20),
                                itemCount: finalData.cartList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: item_food_view(product: finalData.cartList[index],),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 30,
                        child: title_gradient_container(icon: Icons.fastfood_outlined, title: 'Danh sách món ăn'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 170,
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
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        widget.order.note = 'Không có ghi chú';
                                      } else {
                                        widget.order.note = value.toString();
                                      }
                                    },
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

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 370,
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
                                      child: general_ingredient.get_cost_title('Giá tiền món ăn', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(get_total_cart_money()) + '.đ', Colors.black, FontWeight.bold, width),
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
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        child: FutureBuilder(
                                          future: food_order_controller.getMaxDistance(widget.order),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_title('Chi phí ship(...km)', Colors.black, FontWeight.bold, width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_title('Lỗi khoảng cách', Colors.black, FontWeight.bold, width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_title('Lỗi khoảng cách', Colors.black, FontWeight.bold, width);
                                            }

                                            return general_ingredient.get_cost_title('Chi phí ship(' + snapshot.data!.toStringAsFixed(1) + ' Km)', Colors.black, FontWeight.bold, width);
                                          },
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: food_order_controller.getMaxCost(widget.order),
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

                                            return general_ingredient.get_cost_content(getStringNumber(double.parse(snapshot.data.toString())) + '.đ', Colors.black, FontWeight.bold, width);
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_title('Phụ thu thêm điểm(' + widget.order.shopList.length.toString() + ' điểm)', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content(getStringNumber(widget.order.pointFee) + '.đ', Colors.black,widget.order.shopList.length == 0 ? FontWeight.normal : FontWeight.bold, width),
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
                                      child: general_ingredient.get_cost_title('Phụ thu thời tiết', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content('Chưa có', Colors.black, FontWeight.normal, width),
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
                                      child: general_ingredient.get_cost_title('Phụ thu chờ món', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: general_ingredient.get_cost_content('Chưa có', Colors.black, FontWeight.normal, width),
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
                                        child: general_ingredient.get_cost_content(widget.order.voucher.id == '' ? 'Chọn mã giảm giá' : ('-' + getStringNumber(getVoucherSale(widget.order.voucher, widget.order.cost)) + '.đ'), Colors.red, FontWeight.normal, width),
                                      ),

                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return voucher_select(voucher: widget.order.voucher, ontap: () {setState(() {});}, cost: widget.order.cost);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Container(height: 10,),

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
                                      child: general_ingredient.get_cost_title('Tổng thanh toán', Colors.black, FontWeight.bold, width),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4),
                                      child: Container(
                                        height: 30,
                                        width: (width - 40 - 20)/2,
                                        alignment: Alignment.centerRight,
                                        child: FutureBuilder(
                                          future: food_order_controller.getMaxCost(widget.order),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return general_ingredient.get_cost_content('Đang tính toán', Colors.black, FontWeight.bold, width);
                                            }

                                            if (snapshot.hasError) {
                                              return general_ingredient.get_cost_content('Lỗi dữ liệu', Colors.black, FontWeight.bold, width);
                                            }

                                            if (!snapshot.hasData) {
                                              return general_ingredient.get_cost_content('Lỗi dữ liệu', Colors.black, FontWeight.bold, width);
                                            }

                                            return general_ingredient.get_cost_content(getStringNumber(double.parse(snapshot.data.toString()) + get_total_cart_money() + widget.order.pointFee - getVoucherSale(widget.order.voucher, widget.order.cost)) + '.đ', Colors.black, FontWeight.bold, width);
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
                        child: title_gradient_container(icon: Icons.money_outlined, title: 'Thông tin thanh toán'),
                      ),
                    ],
                  ),
                ),
              ),

              Container(height: 20,),

              start_food_order_button(order: widget.order),

              Container(height: 20,),
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
