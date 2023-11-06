import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/global/common/toast.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:orevahardware/widgets/dismissKeyboardOnTap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_auth/firebase_auth_service.dart';
import '../widgets/formfield.dart';

class SignInScreen extends StatefulWidget {
  final Function? toggleView;

  const SignInScreen({   this.toggleView});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Firebase_Auth_Service _auth = Firebase_Auth_Service();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  String email = "";
  String password = "";
  String error = "";
  bool _isFirstIcon = true;
  bool _isSigning = false;
  bool _isSigningError = false;


  void _toggleIcon() {
    setState(() {
      _isFirstIcon = !_isFirstIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OrevaHardware", style: AppTextStyles.appBarTextStyle),
            centerTitle: true,
      ),
      body: DismissKeyboardOnTap(
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Container(
                      // width: MediaQuery.of(context).size.height * 1,
                      child: Form(
                        child: Column(
                          children: [
                            Text(
                              'Sign In',
                              style: AppTextStyles.headerTextStyle,
                            ),
                            SizedBox(
                              height: 25,
                            ),


                            CustomFormField(
                              validator: (val)=> val!.isEmpty ? "Enter an email" : null,
                              onChanged: (val) {
                                setState(() =>  email = val!);
                                return null;
                              },
                              onTap: () {},

                              controller: _emailController,
                              label: 'Email',
                              hintText: 'Enter your email',

                            ),
                            SizedBox(height: 15),
                            CustomFormField(
                              isPasswordField: true,
                              validator: (val) => val!.length < 8
                                  ? "Enter a password ranging 8 character"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val!;
                                });
                                return null;
                              },
                              controller: _passwordController,
                              onTap: () {},
                              label: 'Password',
                              hintText: 'Enter password',
                              suffixIcon: _isFirstIcon
                                  ?
                              FontAwesomeIcons.eyeSlash
                                  :
                              FontAwesomeIcons.eye,
                              onTapSuffixIcon: _toggleIcon,

                            ),

                            SizedBox(height: 25),
                            CustomSignInAndUpButton(
                              isSigning: _isSigning,
                              onTap: _signIn, error: true,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't, have an account?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () => widget.toggleView!(),
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _signIn() async {
setState(() {
  _isSigning = true;
});

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = true;
    });
    if (user != null) {
      successShowToast(message: 'user sign in is successful');
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => DashBoard()));
    }else{
      setState(() {
        _isSigningError = true;
      });
      failedShowToast(message: 'Some error');
    }
  }
  void updateUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
