import 'package:flutter/material.dart';

import '../constants/kcolors.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final Function()? onTap;
  final Function()? onTapSuffixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextEditingController? controller;
  final bool? isPasswordField;

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
    this.isPasswordField,
  });
  

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  bool _obscureText = true;

  void _toggleIcon() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        style: AppTextStyles.formFieldTextStyle,
        decoration: InputDecoration(
            label: Text(
              widget.label,
            ),
            labelStyle: TextStyle(
              color: Kcolor.secondaryTextColor,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            hintText: widget.hintText,
            hintStyle: AppTextStyles.formFieldHintTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            suffixIcon: GestureDetector(
                // onTap: onTapSuffixIcon,
                onTap: _toggleIcon,
                child:
                  widget.isPasswordField ==true
                      ? Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText ==  false ? Colors.red[200]:  Colors.green[200], size: 16,) :Text('') ,

                )),
      ),
    );
  }
}

class CustomSignInAndUpButton extends StatelessWidget {
  final bool isSigning;
  final bool error;
  final Function() onTap;

  CustomSignInAndUpButton({
    required this.onTap,
    super.key,
    required this.isSigning,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: error ? onTap : null,
      child: Container(
          // width: MediaQuery.of(context).size.height * 0.9,
          width: 120,
          color: Kcolor.primaryColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isSigning
                  ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
                  : Text(
                      "Sign in",
                      style: AppTextStyles.textButtonTextStyle,
                    ),
            ),
          )),
    );
  }
}
