import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.onSave,
    this.mOnChange,
    this.mValidator,
    Key? key,
    required this.hint,
    required this.obscure,
    required this.type,
    this.width,
    this.icon,
    this.iconColor,
    this.mPrefixIconPressed,
    //required this.onClick,
    // required this.iconColor,
  }) : super(key: key);
  final String hint;
  final bool obscure;
  final String? type;
  double? width;
  IconData? icon;
  Color? iconColor;
  final String? Function(String?)? mValidator;
  final void Function()? mPrefixIconPressed;
  final void Function(String)? mOnChange;
  final void Function(String?)? onSave;

  // final OutlineInputBorder border = const OutlineInputBorder(
  //     borderRadius: BorderRadius.only(),
  //     borderSide: BorderSide(color: Colors.grey));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double
          .infinity, //width == null ? MediaQuery.of(context).size.width : width,
      child: TextFormField(
        onSaved: onSave,
        onChanged: mOnChange,
        //  onSaved: onClick,
        validator: mValidator,
        obscureText: obscure,
        //cursorColor: kMainColor,
        decoration: InputDecoration(
            prefixIconColor: iconColor,
            prefixIcon: IconButton(
              icon: Icon(icon),
              onPressed: mPrefixIconPressed,
            ),
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 15)),
      ),
    );
  }
}
