import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:orevahardware/widgets/dismissKeyboardOnTap.dart';

import '../user_auth/firebase_auth_service.dart';
import '../widgets/formfield.dart';

class SignInScreen extends StatefulWidget {
  final ZoomDrawerController zoomController; // Define zoomController as a property.
  final Function? toggleView;

  const SignInScreen({Key? key, required this.zoomController, this.toggleView})
      : super(key: key);

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


  void _toggleIcon() {
    setState(() {
      _isFirstIcon = !_isFirstIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Kcolor.secondaryColor,
          ),
        ),
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
                              'Create account',
                              style: AppTextStyles.headerTextStyle,
                            ),
                            SizedBox(
                              height: 25,
                            ),


                            CustomFormField(
                              validator: (val)=> val!.isEmpty ? "Enter an email" : null,
                              onChanged: (val) {
                                setState(() =>  email = val!);
                              },
                              onTap: () {},

                              controller: _emailController,
                              label: 'Email',
                              hintText: 'Enter your email',

                            ),
                            SizedBox(height: 15),
                            CustomFormField(
                              validator: (val) => val!.length < 8
                                  ? "Enter a password ranging 8 character"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val!;
                                });
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
                              text: "Sign in",
                              onTap: _signIn,
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

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print('user sign in is success');
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => DashBoard(
                zoomController: widget.zoomController, instagramUrl: '',)));
    }else{
      print('Some error');
    }
  }
}
