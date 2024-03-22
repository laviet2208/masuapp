import 'package:firebase_database/firebase_database.dart';
import '../Order/itemsendOrder.dart';

import '../Order/catchOrder.dart';

Future<void> pushCatchOrder(catchOrder catchorder) async {
  try {
// Khởi tạo kết nối đến Realtime Database
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

// Đẩy dữ liệu catchOrder lên mục catchOrder với khóa chính là id của catch
    await databaseRef.child('Order/catchOrder').child(catchorder.id).set(catchorder.toJson());

    print('Đẩy catchOrder thành công');
  } catch (error) {
    print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
    throw error;
  }
}

Future<void> pushitemSendOrder(itemsendOrder itemsend) async {
  try {
// Khởi tạo kết nối đến Realtime Database
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

// Đẩy dữ liệu catchOrder lên mục catchOrder với khóa chính là id của catch
    await databaseRef.child('itemsendOrder').child(itemsend.id).set(itemsend.toJson());

    print('Đẩy Order thành công');
  } catch (error) {
    print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
    throw error;
  }
}
