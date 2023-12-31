import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/global/common/toast.dart';
import 'package:orevahardware/screens/dash_board.dart';
import 'package:orevahardware/user_auth/firebase_auth_service.dart';

import '../widgets/dismissKeyboardOnTap.dart';
import '../widgets/formfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key,   this.toggleView})
      : super(key: key);

  final Function? toggleView;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final Firebase_Auth_Service _auth = Firebase_Auth_Service();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String firstname = "";
  String lastname = "";
  String email = "";
  String password = "";
  String error = "";
  bool _creating = false;
  bool _isCreatingError = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            )),
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
                              controller: _firstnameController,
                              onTap: () {},
                              validator: (val) =>
                              val!.isEmpty
                                  ? "Enter firstname"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  firstname = val!;
                                });
                              },
                              label: 'Firstname',
                              hintText: 'Firstname',
                            ),
                            SizedBox(height: 15),
                            CustomFormField(
                              controller: _lastnameController,
                              onTap: () {},
                              validator: (val) =>
                              val!.isEmpty
                                  ? "Enter Lastname"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  lastname = val!;
                                });
                              },
                              label: 'Lastname',
                              hintText: 'Lastname',
                            ),
                            SizedBox(height: 15),
                            CustomFormField(
                              controller: _emailController,
                              onTap: () {},
                              validator: (val) =>
                              val!.isEmpty
                                  ? "Enter email"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val!;
                                });
                              },

                              label: 'Email',
                              hintText: 'email',
                            ),
                            SizedBox(height: 15),
                            CustomFormField(
                              controller: _passwordController,
                              validator: (val) =>
                              val!.length < 8
                                  ? "Enter a password ranging 8 character"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val!;
                                });
                              },
                              onTap: () {},
                              label: 'Password',
                              hintText: '* * * * * * * *',
                            ),
                            SizedBox(height: 15),
                            // CustomFormField(
                            //   validator: (val) =>
                            //   val!.length < 8
                            //       ? "Enter a password ranging 8 character"
                            //       : null,
                            //   onChanged: (val) {
                            //     setState(() {
                            //       password = val!;
                            //     });
                            //   },
                            //   onTap: () {},
                            //   label: 'Password',
                            //   hintText: '* * * * * * * *',
                            // ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
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
                                    "Log in",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            CustomSignInAndUpButton(
                              onTap: _signUp,
                              isSigning: _creating,
                              error: true,
                            )
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

  void _signUp() async {
    setState(() {
      _creating = true;
    });

    String firstname = _firstnameController.text;
    String lastname = _lastnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    setState(() {
      _creating = false;
    });

    if (user != null) {
      successShowToast(message: 'user sign up is success');
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => DashBoard()));
    }else{
      setState(() {
        _isCreatingError = true;
      });
    failedShowToast(message: 'Some error');
    }
  }
}
