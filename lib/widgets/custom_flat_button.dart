import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:orevahardware/screens/checkout_screen.dart';
import '../constants/kcolors.dart';

class CustomFlatButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final double width;
 final ZoomDrawerController? zoomController;



  const CustomFlatButton({
  super.key, this.onTap, required this.text,  this.color, required this.width,   this.zoomController,
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(color: color == null ? Kcolor.primaryColor : color,
          height: 50,
          width:width,
          child: Center(
            child:  Text(text, style: AppTextStyles.textButtonTextStyle,),
          ),
        ),
      ),
    );
  }
}