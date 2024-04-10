import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

class accept_weather_sub_fee_dialog extends StatefulWidget {
  final CatchOrder order;
  const accept_weather_sub_fee_dialog({super.key, required this.order});

  @override
  State<accept_weather_sub_fee_dialog> createState() => _accept_weather_sub_fee_dialogState();
}

class _accept_weather_sub_fee_dialogState extends State<accept_weather_sub_fee_dialog> {
  bool loading = false;

  Future<void> change_sub_fee(String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('subFee').set(finalData.weathercost.cost);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    double height = MediaQuery.of(context).size.height/2;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Phụ phí thời tiết'),
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
                'Xác nhận thu phụ phí',
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
                    Icons.warning,
                    color: Colors.redAccent,
                    size: 50,
                  ),
                )
            ),

            Container(height: 20,),

            Container(
              alignment: Alignment.center,
              child: Text(
                'Bạn có chắc chắn yêu cầu phụ phí và chịu trách nhiệm liên quan không?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'muli',
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
                        'Tôi đồng ý',
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
                setState(() {
                  loading = true;
                });
                await change_sub_fee(widget.order.id);
                setState(() {
                  loading = false;
                });
                toastMessage('Đã áp dụng phụ phí');
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
