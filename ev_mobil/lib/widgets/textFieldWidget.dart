import 'package:ev_mobil/settings/consts.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;

  const TextFieldWidget({
    Key key,
    this.hintText,
    this.textEditingController,
    this.keyboardType,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cardCurved),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: 18,
          fontFamily: contentFont
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:secondaryColor),borderRadius: BorderRadius.circular(cardCurved)),
      ),
    );
  }
}