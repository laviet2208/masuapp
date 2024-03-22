import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/NormalUser/accountLocation.dart';
import '../../GENERAL/NormalUser/accountNormal.dart';
import '../../GENERAL/Tool/Tool.dart';
import '../../GENERAL/utils/utils.dart';
import '../../OTHER/Button/Buttontype1.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'SCREEN_entername.dart';
import 'SCREEN_loginbyphonenum.dart';
import 'SCREEN_selectLocation.dart';


class SCREENverify extends StatefulWidget {
  final String verificationId;
  final String phoneNum;
  const SCREENverify({Key? key, required this.verificationId, required this.phoneNum}) : super(key: key);

  @override
  State<SCREENverify> createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<SCREENverify> {
  String otp = '';
  bool loading = false;

  Future<bool> checkData(String phoneNumber) async {
    final reference = FirebaseDatabase.instance.reference().child('normalUser');
    final snapshot = await reference.orderByChild('phoneNum').equalTo(phoneNumber).once();

    return snapshot.snapshot.value != null;
  }

  Future<void> getData(String phoneNumber) async {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('normalUser').onValue.listen((event) {
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if (value['phoneNum'].toString() == phoneNumber) {
          currentAccount.changeData(value);
          if (currentAccount.status == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENentername(),),);
          } else if (currentAccount.status == 1 && currentAccount.type == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENselectLocation(),),);
          } else if (currentAccount.status == 1 && currentAccount.type == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
          }
        }
      }
      );
    }).onDone(() {

    });
  }


  Future<void> pushData(accountNormal account) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("normalUser/" + account.id).set(account.toJson());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/mainLogo.png')
                    )
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Xác minh số điện thoại",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Chúng tôi đã gửi 1 mã tới số điện thoại của bạn, vui lòng xác minh",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (pin) {
                  setState(() {
                    otp = pin;
                  });
                },
                onCompleted: (pin) {
                  setState(() {
                    otp = pin;
                  });
                },
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,

                child: ButtonType1(Height: 45, Width: screenWidth - 50, color: Color.fromARGB(255, 244, 164, 84), radiusBorder: 10, title: "Xác minh", fontText: 'arial', colorText: Colors.white,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });

                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otp,
                      );
                      await FirebaseAuth.instance.signInWithCredential(credential);
                      if (await checkData(widget.phoneNum)) {
                        await getData(widget.phoneNum);
                        setState(() {
                          loading = false;
                        });
                      } else {
                        currentAccount.phoneNum = widget.phoneNum;
                        currentAccount.type = 1;
                        currentAccount.status = 0;
                        currentAccount.id = generateID(15);
                        currentAccount.name = 'NA';
                        currentAccount.locationHis = accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: '');
                        currentAccount.createTime = getCurrentTime();
                        currentAccount.avatarID = 'NA';
                        await pushData(currentAccount);
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENentername(),),);
                      }
                    } catch (e) {
                      toastMessage("Lỗi otp, vui lòng kiểm tra lại");
                      setState(() {
                        loading = false;
                      });
                    }
                  }, loading: loading,),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SCREENlogin(),),);
                      },
                      child: Text(
                        "Bạn muốn sử dụng số khác ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}