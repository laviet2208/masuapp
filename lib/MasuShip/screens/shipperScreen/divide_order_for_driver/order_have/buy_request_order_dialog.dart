import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';

class buy_request_order_dialog extends StatefulWidget {
  final requestBuyOrder order;
  const buy_request_order_dialog({Key? key, required this.order}) : super(key: key);

  @override
  State<buy_request_order_dialog> createState() => _buy_request_order_dialogState();
}

class _buy_request_order_dialogState extends State<buy_request_order_dialog> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //order_have_dialog_controller.change_Order_Status(widget.order, 'B');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    double height = MediaQuery.of(context).size.height/2;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Masu có đơn'),
      content: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 20,),

            Container(
              height: 20,
              alignment: Alignment.center,
              child: AutoSizeText(
                'Chúc mừng, bạn có đơn mới',
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(height: 20,),

            Container(
                height: 50,
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.green,
                    size: 50,
                  ),
                )
            ),

            Container(height: 20,),

            Container(
              alignment: Alignment.center,
              child: Text(
                'Đơn mua hộ\n' + widget.order.id,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(height: 20,),

            GestureDetector(
              child: Container(
                height: 45,
                child: Center(
                  child: Container(
                    width: width/2,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: AutoSizeText(
                        'Xem đơn ngay',
                        style: TextStyle(
                            fontSize: 100,
                            fontFamily: 'roboto',
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
              },
            ),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}
