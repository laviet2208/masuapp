import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/express_order_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/view_un_express_order.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../../../../Data/OrderData/expressOrder/expressOrder.dart';

class camera_express_screen extends StatefulWidget {
  final expressOrder order;
  const camera_express_screen({Key? key, required this.order}) : super(key: key);

  @override
  camera_express_screenState createState() => camera_express_screenState();
}

class camera_express_screenState extends State<camera_express_screen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool loading = false;
  // Future<void> uploadImageToFirebaseStorage(XFile? imageFile) async {
  //   if (imageFile == null) {
  //     print('XFile không tồn tại hoặc không hợp lệ.');
  //     return;
  //   }
  //
  //   // Kiểm tra xem đường dẫn của XFile trỏ đến tệp hợp lệ hay không
  //   final file = File(imageFile.path);
  //   if (!file.existsSync()) {
  //     print('Tệp ảnh không tồn tại hoặc không hợp lệ.');
  //     return;
  //   }
  //
  //   // Tạo một tham chiếu đến thư mục CCCD trong Firebase Storage
  //   final ref = FirebaseStorage.instance.ref().child('expressImage');
  //
  //   // Tạo tên file ngẫu nhiên hoặc sử dụng tên file tùy ý
  //   String fileName = widget.order.id;
  //   try {
  //     // Đọc dữ liệu của tệp ảnh
  //     final fileData = File(imageFile.path);
  //
  //     // Chuyển đổi tệp ảnh thành định dạng PNG
  //     final originalImage = img.decodeImage(fileData.readAsBytesSync());
  //     final pngImage = img.encodePng(originalImage!);
  //
  //     // Tạo một tệp ảnh tạm thời với định dạng PNG
  //     final tempFile = File('${(await getTemporaryDirectory()).path}/$fileName.png');
  //     tempFile.writeAsBytesSync(pngImage);
  //
  //     // Tải ảnh lên Firebase Storage
  //     await ref.child('$fileName.png').putFile(tempFile);
  //
  //     // Xóa tệp ảnh tạm thời
  //     tempFile.delete();
  //
  //     print('Đã tải ảnh lên Firebase Storage');
  //   } catch (e) {
  //     print('Lỗi khi tải ảnh lên Firebase Storage: $e');
  //   }
  // }

  Future<void> uploadImageToFirebaseStorage(XFile? imageFile) async {
    if (imageFile == null) {
      print('XFile không tồn tại hoặc không hợp lệ.');
      return;
    }

    // Tạo một tham chiếu đến thư mục expressImage trong Firebase Storage
    final ref = FirebaseStorage.instance.ref().child('expressImage');

    // Tạo tên file ngẫu nhiên hoặc sử dụng tên file tùy ý
    String fileName = widget.order.id;

    try {
      // Tải ảnh lên Firebase Storage
      await ref.child('$fileName.png').putFile(File(imageFile.path));

      print('Đã tải ảnh lên Firebase Storage');
    } catch (e) {
      print('Lỗi khi tải ảnh lên Firebase Storage: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _controller!.initialize();
    _initializeControllerFuture = _controller.initialize();
    setState(() {

    });
    if (!mounted) {
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Chụp ảnh món hàng nhé', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_un_express_order(id: widget.order.id),),);
          },
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            setState(() {
              loading = true;
            });
            toastMessage('Vui lòng giữ nguyên máy 3s');
            await _initializeControllerFuture;
            final XFile picture = await _controller.takePicture();
            await uploadImageToFirebaseStorage(picture);
            await express_order_controller.C_status_event(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_un_express_order(id: widget.order.id),),);

          } catch (e) {
            print(e);
          }
        },
        backgroundColor: Colors.yellow,
        child: !loading ? Icon(Icons.camera_alt, color: Colors.black,) : CircularProgressIndicator(color: Colors.black,),
      ),
    ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_un_express_order(id: widget.order.id),),);
        return true;
      },
    );
  }
}
