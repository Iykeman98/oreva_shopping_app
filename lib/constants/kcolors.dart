
import 'package:flutter/material.dart';

class Kcolor{
  static const primaryColor = Color(0xFF2c307e);
  static const secondaryColor = Color(0xFFe0d8cf);
  static const primaryTextColor = Color(0xFFFFFFFF);
  static const blackHeaderTextColor = Color(0xFF2c307e);
  static const secondaryTextColor = Color(0xFF616161);


}



class AppTextStyles {
  static const TextStyle appBarTextStyle = TextStyle(
    color: Kcolor.primaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 18
  );

  static const TextStyle textButtonTextStyle = TextStyle(
      color: Kcolor.primaryTextColor,
      fontWeight: FontWeight.w400,
      fontSize: 20
  );

  static const TextStyle headerTextStyle = TextStyle(
    color: Kcolor.blackHeaderTextColor,
    letterSpacing: 2,
    fontWeight: FontWeight.bold,
    fontSize: 20
  );

  static const TextStyle secondaryTextStyle = TextStyle(
    color: Kcolor.secondaryTextColor,
    letterSpacing: 2,
    fontWeight: FontWeight.w500,
    fontSize: 16
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    color: Kcolor.secondaryTextColor,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  ); static const TextStyle descriptionTextStyle2 = TextStyle(
    color: Kcolor.primaryColor,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
  static const TextStyle formFieldHintTextStyle = TextStyle(
    color: Kcolor.secondaryTextColor,
    letterSpacing: 1,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );
  static const TextStyle formFieldTextStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const TextStyle addToTextStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}