import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const TextButtonWidget({ Key key, this.buttonText, this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(right: defaultPadding*2,left: defaultPadding*2,bottom: minSpace),
     child     : Container(
     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(maxSpace)),
     color     : primaryColor),
     child     : TextButton(
     style     : ButtonStyle(),
     child     : Row(mainAxisAlignment: MainAxisAlignment.center,
     children  : [Text(buttonText,
     style     : TextStyle(
     color     : darkWhite,
     fontSize  : 15,
     fontFamily: contentFont)),
     SizedBox(width: deviceWidth(context)*0.01),
     FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: white)
     ]),
     onPressed : onPressed,
     ),
          ),
        );
  }
}