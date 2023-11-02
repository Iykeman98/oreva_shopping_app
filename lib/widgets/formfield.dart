import 'package:flutter/material.dart';

import '../constants/kcolors.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final Function()? onTap;
  final Function()? onTapSuffixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextEditingController? controller;

  const CustomFormField({
    required this.onTap,
    required this.label,
    required this.hintText,
    super.key,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTapSuffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            suffixIcon: GestureDetector(
                onTap: onTapSuffixIcon,
                child: Icon(
                  suffixIcon,
                  size: 16,
                  color: Kcolor.secondaryColor,
                ))),
      ),
    );
  }
}

class CustomSignInAndUpButton extends StatelessWidget {
  final bool isSigning;
  final Function() onTap;

  CustomSignInAndUpButton({
    required this.onTap,
    super.key,
    required this.isSigning,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSigning ? null : onTap,
      child: Container(
          // width: MediaQuery.of(context).size.height * 0.9,
          width: 120,
          color: Kcolor.primaryColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isSigning
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Sign in", style: AppTextStyles.textButtonTextStyle,),
            ),
          )),
    );
  }
}
