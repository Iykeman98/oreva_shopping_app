import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/screens/sign_in_screen.dart';

import '../widgets/dismissKeyboardOnTap.dart';
import '../widgets/formfield.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.zoomController}) : super(key: key);

  final ZoomDrawerController zoomController;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){ Navigator.pop(context);},
            icon: Icon(Icons.arrow_back, color:Kcolor.secondaryColor,)),
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
                          CustomFormField(onTap: () {  }, label: 'Firstname', hintText: 'Firstname',), SizedBox(height: 15),
                          CustomFormField(onTap: () {  }, label: 'Lastname', hintText: 'Firstname',), SizedBox(height: 15),
                          CustomFormField(onTap: () {  }, label: 'Email', hintText: 'Firstname',), SizedBox(height: 15),
                          CustomFormField(onTap: () {  }, label: 'Password', hintText: 'Firstname',), SizedBox(height: 15),
                          CustomFormField(onTap: () {  }, label: 'Password', hintText: 'Firstname',), SizedBox(height: 25),
                          CustomSignInAndUpButton(
                            text: "Create",
                            onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(zoomController:widget.zoomController),
                              ),
                            );

                          },)
                        ],
                      ), ),
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
}

