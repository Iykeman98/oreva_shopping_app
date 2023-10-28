
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/models/cart_items.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:provider/provider.dart';

import 'constants/kcolors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) {
      return CartProvider();
    },
      child: MyApp()
  ),
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
      theme: ThemeData(
        primaryColor: Kcolor.primaryColor,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
         backgroundColor : Kcolor.primaryColor,
          titleTextStyle: TextStyle(color: Kcolor.primaryColor)
        )
      ),
      home:  ZoomDrawer(
        controller: zoomController,
        style: DrawerStyle.defaultStyle, // Choose your desired style
        menuScreen: MyDrawer(launchInstagram: () {  }, zoomController: zoomController,), // Your drawer content
        mainScreen: DashBoard(zoomController: zoomController, instagramUrl: 'https://www.instagram.com/orevahardware/related_profiles/',), // Make sure this line is correct
      ),
    );
  }
}


