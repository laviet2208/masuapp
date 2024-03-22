import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../Data/otherData/Tool.dart';
import '../../Data/finalData/finalData.dart';

class AppStateListener extends StatefulWidget {
  final Widget child;

  AppStateListener({required this.child});

  @override
  _AppStateListenerState createState() => _AppStateListenerState();
}

class _AppStateListenerState extends State<AppStateListener> with WidgetsBindingObserver {

  //Trạng thái online
  void change_online_status(int status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Account/" + finalData.shipper_account.id).child('onlineStatus').set(status);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
      // Ứng dụng được mở lại từ background
      //   if (finalData.shipper_account.orderHaveStatus == 0 && finalData.shipper_account.onlineStatus == 0) {
      //     change_online_status(0);
      //   }
      //   if (finalData.shipper_account.orderHaveStatus == 0 && finalData.shipper_account.onlineStatus == 1) {
      //     change_online_status(1);
      //   }
        break;

      case AppLifecycleState.inactive:
      // Ứng dụng đang không active, ví dụ như bị đẩy vào background hoặc có một cuộc gọi đến

        break;

      case AppLifecycleState.paused:
      // Ứng dụng bị tạm dừng hoặc chuyển sang background

        break;

      case AppLifecycleState.detached:

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}