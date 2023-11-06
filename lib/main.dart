import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/models/cart_items.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:orevahardware/screens/sign_in_screen.dart';
import 'package:orevahardware/screens/sign_up_screen.dart';
import 'package:orevahardware/screens/splashScreen.dart';
import 'package:provider/provider.dart';

import 'constants/kcolors.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBPHxQEmGsoQ0K1Bb3LhzKag77uvXKd7pU",
            appId: "1:884592395991:web:45ef8ad313f00e27229292",
            messagingSenderId: "884592395991",
            projectId: "oreva-65a7e"));
  }
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(
    ChangeNotifierProvider(
        create: (context) {
          return CartProvider();
        },
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final zoomController = ZoomDrawerController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Kcolor.primaryColor,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Kcolor.primaryColor,
              titleTextStyle: TextStyle(color: Kcolor.primaryColor))),
      home: SplashScreen(),
      // home: DashBoard(),
    );
  }
}
