import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:orevahardware/screens/sign_in_screen.dart';
import 'package:orevahardware/screens/sign_up_screen.dart';

class Authenticate extends StatefulWidget {

  const Authenticate({Key? key, }) : super(key: key);

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
      return SignInScreen( toggleView: toggleView,);
    }else{
      return SignUpScreen(toggleView: toggleView,);
    }
  }
}



class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

  bool isUserAuthenticated = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    if(isUserAuthenticated){
      return DashBoard();
    }else{
     return Authenticate();
    }
  }
}
