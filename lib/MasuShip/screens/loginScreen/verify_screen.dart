import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/accountData/userAccount.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/controller/loginController.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/enter_name_screen.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/login_screen.dart';
import 'package:pinput/pinput.dart';
import '../../Data/otherData/Tool.dart';
import '../../Data/otherData/utils.dart';

class verify_screen extends StatefulWidget {
  final String verificationId;
  final String phoneNum;
  const verify_screen({Key? key, required this.verificationId, required this.phoneNum}) : super(key: key);

  @override
  State<verify_screen> createState() => _verify_screenState();
}

class _verify_screenState extends State<verify_screen> {
  String otp = '';
  bool loading = false;

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

                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: !loading ? Text(
                        'Xác minh số điện thoại',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ) : CircularProgressIndicator(color: Colors.black,),
                    ),
                  ),
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
                        if (await loginController.checkData(widget.phoneNum)) {
                          await loginController.getData(widget.phoneNum, context);
                          setState(() {
                            loading = false;
                          });
                        } else {
                          finalData.user_account = UserAccount(
                            id: generateID(15),
                            createTime: getCurrentTime(),
                            lockStatus: 1,
                            name: '',
                            area: 'ineSi92oGc1ZDlBBlddo',
                            phone: widget.phoneNum,
                            location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
                          );

                          await loginController.pushData(finalData.user_account);
                          setState(() {
                            loading = false;
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => enter_name_screen(),),);
                        }
                      } catch (e) {
                        toastMessage("Lỗi otp, vui lòng kiểm tra lại");
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                )
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
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
