import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/screens/sign_in_screen.dart';
import 'package:orevahardware/screens/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  final ZoomDrawerController zoomController;

  const Authenticate({Key? key, required this.zoomController}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
//toggle between authentication pages

bool showSignIn = true;
void toggleView(){
  setState(() {
    showSignIn = !showSignIn;
  });
}
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignInScreen( toggleView: toggleView, zoomController: widget.zoomController,);
    }else{
      return SignUpScreen(toggleView: toggleView, zoomController: widget.zoomController,);
    }
  }
}
