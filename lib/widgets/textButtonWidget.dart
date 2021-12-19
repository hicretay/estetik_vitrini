import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Widget icon;
  const TextButtonWidget({ Key key, this.buttonText, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(right: maxSpace,left: maxSpace,bottom: minSpace),
     child     : Container(
     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(maxSpace)),
     color     : primaryColor),
     child     : TextButton(
     style     : ButtonStyle(),
     child     : icon == null ? 
     Text(buttonText,
     style     : TextStyle(
     color     : darkWhite,
     fontSize  : 15,
     fontFamily: contentFont)) :
     Row(mainAxisAlignment: MainAxisAlignment.center,
     children  : [Text(buttonText,
     style     : TextStyle(
     color     : darkWhite,
     fontSize  : 15,
     fontFamily: contentFont)),
     SizedBox(width: deviceWidth(context)*0.01),
     icon
     ]),
     onPressed : onPressed,
     ),
          ),
        );
  }
}