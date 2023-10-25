import 'package:flutter/material.dart';

import '../constants/kcolors.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final Function()? onTap;
  final IconData? icon;

  const CustomFormField({
    required this.onTap,
    required this.label,
    required this.hintText,
    super.key,
   this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextField(
        style: AppTextStyles.formFieldTextStyle,
        decoration: InputDecoration(
          label: Text(
            label,
          ),
          labelStyle: TextStyle(
            color: Kcolor.secondaryTextColor,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.formFieldHintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          suffixIcon: Icon(icon, size: 16,color: Kcolor.secondaryColor,)
        ),
      ),
    );
  }
}

class CustomSignInAndUpButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  CustomSignInAndUpButton({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: MediaQuery.of(context).size.height * 0.9,
        width: 120,
        color: Kcolor.primaryColor,
        child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,style: AppTextStyles.appBarTextStyle,),
        ) ,)

      ),
    ) ;
  }

}
