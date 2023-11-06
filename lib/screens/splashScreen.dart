import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:orevahardware/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final Function? toggleView;
  const SplashScreen({Key? key,  this.toggleView}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() async {
    // Simulate checking if the user is logged in using SharedPreferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool isUserAuthenticated = FirebaseAuth.instance.currentUser != null;


    // Delay for a few seconds to show the splash screen.
    await Future.delayed(Duration(seconds: 3));

    if (isUserAuthenticated) {
      // Navigate to the dashboard.
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => DashBoard(),),
              (route) => false);
    } else {
      // Navigate to the login screen.
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => SignInScreen(),),
              (route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Oreva Hardware",
          style: AppTextStyles.headerTextStyle,
        ),
      ),
    );
  }
}
