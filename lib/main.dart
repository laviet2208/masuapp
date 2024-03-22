import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/loading_screen.dart';
import 'MasuShip/Data/appState/app_state_controller.dart';
import 'SCREEN/BEFORE/SCREEN_firstloading.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //       apiKey: "AIzaSyD-09bxgKHW4FKs3xfZ2QijmEYIhTkHtz8",
    //       authDomain: "masuship-5b377.firebaseapp.com",
    //       databaseURL: "https://masuship-5b377-default-rtdb.firebaseio.com",
    //       projectId: "masuship-5b377",
    //       storageBucket: "masuship-5b377.appspot.com",
    //       messagingSenderId: "788990781107",
    //       appId: "1:788990781107:web:95d970ed04837970df72c6",
    //       measurementId: "G-7ZRQF8P3MS"
    //   ),
  );
  finalData.lastOrderTime = DateTime.now().add(Duration(seconds: 90));

  runApp(AppStateListener(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masu Ship',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const loading_screen(),
      // home: const SCREENlocationbikest1test(),
    );
  }
}
