import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/otherData/Temporary.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';

class change_name_and_phone extends StatefulWidget {
  final Temporary Nametemporary;
  final Temporary Phonetemporary;
  final int type; // 1: thông tin người gửi, 2: thông tin người nhận
  final VoidCallback event;
  const change_name_and_phone({super.key, required this.Nametemporary, required this.Phonetemporary, required this.event, required this.type,});

  @override
  State<change_name_and_phone> createState() => _change_name_and_phoneState();
}

class _change_name_and_phoneState extends State<change_name_and_phone> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.Nametemporary.stringData;
    phoneController.text = widget.Phonetemporary.stringData;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width - 30;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    widget.type == 1 ? 'Tên người gửi' : 'Tên người nhận',
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
                            hintText: 'Nhập họ và tên',
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
                    widget.type == 1 ? 'Số điện thoại người gửi' : 'Số điện thoại người nhận',
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
                          controller: phoneController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập số điện thoại',
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
            if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
              widget.Nametemporary.stringData = nameController.text.toString();
              widget.Phonetemporary.stringData = phoneController.text.toString();
              widget.event();
              Navigator.of(context).pop();
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
            widget.Nametemporary.stringData = nameController.text.toString();
            widget.Phonetemporary.stringData = phoneController.text.toString();
            widget.event();
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
