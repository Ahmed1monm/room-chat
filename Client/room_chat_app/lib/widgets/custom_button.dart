import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String text;
  final Color? color;
  final void Function()? onPressed;
  const CustomButton(
      {Key? key,
      required this.width,
      required this.text,
      this.onPressed,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? const Color(0xff3ABEF0),
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: MaterialButton(
        height: 50,
        minWidth: width,
        onPressed: onPressed,
        // color: ,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
