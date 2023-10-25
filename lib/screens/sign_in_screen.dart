import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/constants/kcolors.dart';
import 'package:orevahardware/screens/dash_board.dart';

import '../widgets/formfield.dart';



class SignInScreen extends StatefulWidget {
  final ZoomDrawerController zoomController; // Define zoomController as a property.

  const SignInScreen({Key? key, required this.zoomController}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(onPressed: (){ Navigator.pop(context);},
            icon: Icon(Icons.arrow_back, color:Kcolor.secondaryColor,),),
      ),
      body: SafeArea(
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
                         CustomFormField(onTap: () {  }, label: 'Email', hintText: 'Firstname',), SizedBox(height: 15),
                          CustomFormField(onTap: () {  }, label: 'Password', hintText: 'Firstname',), SizedBox(height: 25),
                          CustomSignInAndUpButton(
                            text: "Sign in", onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                          DashBoard( instagramUrl: 'https://www.instagram.com/orevahardware/related_profiles/', zoomController: widget.zoomController),),);
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
    );
  }
}

