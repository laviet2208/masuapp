import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';

class CameraPreviewScreen extends StatefulWidget {
  final int type;

  CameraPreviewScreen({required this.type});

  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  CameraController? _controller;
  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    final secondCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    if(widget.type == 1) {
      _controller = CameraController(firstCamera, ResolutionPreset.high);
    } else {
      _controller = CameraController(secondCamera, ResolutionPreset.high);
    }
    await _controller!.initialize();
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeCamera();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Preview'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: CameraPreview(_controller!),
            ),
            ElevatedButton(
              onPressed: () {
                toastMessage('Vui lòng giữ yên máy 2 giây');
                _takePictureAndReturn(context);
              },
              child: Text('Chụp ảnh'),
            ),
          ],
        ),
      ),
    );
  }

  void _takePictureAndReturn(BuildContext context) async {
    try {
      final XFile file = await _controller!.takePicture();
      Navigator.of(context).pop(file.path);
    } catch (e) {
      print(e);
    }
  }
}
