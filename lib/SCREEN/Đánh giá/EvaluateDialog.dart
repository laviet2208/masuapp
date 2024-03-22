import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/FINAL/finalClass.dart';
import 'package:masuapp/GENERAL/Tool/Tool.dart';
import 'package:masuapp/OTHER/Button/Buttontype1.dart';

import '../../GENERAL/Evaluate.dart';
import '../../GENERAL/utils/utils.dart';

class EvaluateDialog extends StatefulWidget {
  final double width;
  final double height;
  final String receiver; // Người nhận đánh giá
  final String orderCode;
  final int type;
  const EvaluateDialog({Key? key, required this.width, required this.height, required this.receiver, required this.orderCode, required this.type}) : super(key: key);

  @override
  State<EvaluateDialog> createState() => _EvaluateDialogState();
}

class _EvaluateDialogState extends State<EvaluateDialog> {
  int star = -1;
  bool loading = false;
  final contentController = TextEditingController();

  Future<void> pushData(Evaluate evaluate) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Evaluate/' + evaluate.id).set(evaluate.toJson());
      toastMessage('Cảm ơn bạn đánh giá');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height*3,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 2, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
        color: Colors.white
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            right: 10,
            child: GestureDetector(
              child: Container(
                child: Text(
                  'Đóng',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontFamily: 'roboto'
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          Positioned(
            top: 40,
            left: (widget.width - 150)/6,
            child: GestureDetector(
              child: Icon(
                star >= 1 ? Icons.star : Icons.star_border_purple500_outlined,
                size: 30,
                color: star >= 1 ? Colors.orange : Colors.grey,
              ),
              onTap: () {
                star = 1;
                setState(() {

                });
              },
            ),
          ),

          Positioned(
            top: 40,
            left: 2*(widget.width - 150)/6 + 30,
            child: GestureDetector(
              child: Icon(
                star >= 2 ? Icons.star : Icons.star_border_purple500_outlined,
                size: 30,
                color: star >= 2 ? Colors.orange : Colors.grey,
              ),
              onTap: () {
                star = 2;
                setState(() {

                });
              },
            ),
          ),

          Positioned(
            top: 40,
            left: 3*(widget.width - 150)/6 + 60,
            child: GestureDetector(
              child: Icon(
                star >= 3 ? Icons.star : Icons.star_border_purple500_outlined,
                size: 30,
                color: star >= 3 ? Colors.orange : Colors.grey,
              ),
              onTap: () {
                star = 3;
                setState(() {

                });
              },
            ),
          ),

          Positioned(
            top: 40,
            right: (widget.width - 150)/6,
            child: GestureDetector(
              child: Icon(
                star >= 5 ? Icons.star : Icons.star_border_purple500_outlined,
                size: 30,
                color: star >= 5 ? Colors.orange : Colors.grey,
              ),
              onTap: () {
                star = 5;
                setState(() {

                });
              },
            ),
          ),

          Positioned(
            top: 40,
            right: 2*(widget.width - 150)/6 + 30,
            child: GestureDetector(
              child: Icon(
                star >= 4 ? Icons.star : Icons.star_border_purple500_outlined,
                size: 30,
                color: star >= 4 ? Colors.orange : Colors.grey,
              ),
              onTap: () {
                star = 4;
                setState(() {

                });
              },
            ),
          ),

          Positioned(
            top: 80,
            bottom: widget.height * 3 / 2.5,
            left: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  maxLines: null, // Để TextField tự động xuống dòng
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: 'Nhập thông tin',
                    border: InputBorder.none, // Ẩn dấu gạch dưới
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            top: 80 + (widget.height*3 - 80 - (widget.height*3/2.5)) + 20,
            bottom: widget.height*3/5,
            left: 15,
            right: 15,
            child: Container(
              child: ButtonType1(Height: 100, Width: widget.width, color: Colors.orange, radiusBorder: 5, title: "Đánh giá", fontText: 'roboto', colorText: Colors.white,
                  onTap: () async {
                     if (star >= 1) {
                       setState(() {
                         loading = true;
                       });
                       Evaluate evaluate = Evaluate(
                           id: generateID(30),
                           Area: currentAccount.Area,
                           type: widget.type,
                           owner: currentAccount.id,
                           receiver: widget.receiver,
                           creatTime: getCurrentTime(),
                           orderCode: widget.orderCode,
                           star: star,
                           content: contentController.text.isNotEmpty ? contentController.text.toString() : ''
                       );
                       await pushData(evaluate);
                       setState(() {
                         loading = false;
                       });
                       toastMessage('Cảm ơn bạn đã đánh giá');
                       Navigator.of(context).pop();
                     } else {
                       toastMessage('Chưa chọn số sao');
                     }
                  },loading: loading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
