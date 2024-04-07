import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestProduct.dart';
import '../../../../Data/otherData/utils.dart';

class edit_product extends StatefulWidget {
  final requestProduct product;
  final VoidCallback event;
  const edit_product({super.key, required this.product, required this.event});

  @override
  State<edit_product> createState() => _edit_productState();
}

class _edit_productState extends State<edit_product> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final unitController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.product.name;
    unitController.text = widget.product.unit;
    numberController.text = widget.product.number.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width - 30;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text(
        'Chỉnh sửa sản phẩm',
        style: TextStyle(
          fontFamily: 'muli',
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      content: Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tên sản phẩm cần mua',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ),
              ),

              Container(height: 5,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: nameController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập tên sản phẩm',
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

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Số lượng cần mua',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ),
              ),

              Container(height: 5,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: numberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Chỉ cho phép nhập số và dấu chấm
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập số lượng',
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

              Container(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đơn vị(kg, cái, thùng,...)',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ),
              ),

              Container(height: 5,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: unitController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập đơn vị',
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

              Container(height: 15,),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (nameController.text.isNotEmpty && numberController.text.isNotEmpty && unitController.text.isNotEmpty) {
              if (int.parse(numberController.text.toString()) > 0) {
                widget.product.name = nameController.text.toString();
                widget.product.number = double.parse(numberController.text.toString());
                widget.product.unit = unitController.text.toString();
                widget.event();
                Navigator.of(context).pop();
              } else {
                toastMessage('Số lượng phải lớn hơn 0');
              }
            } else {
              toastMessage('Bạn cần điền đủ thông tin');
            }
          },
          child: Text(
            'Lưu thông tin',
            style: TextStyle(
              fontFamily: 'muli',
              color: Colors.blueAccent,
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
              fontFamily: 'muli',
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
