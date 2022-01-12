import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackLeadingWidget extends StatelessWidget {
  final Color? backColor;
  const BackLeadingWidget({
    Key? key, this.backColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: maxSpace, bottom: maxSpace),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
            iconSize: iconSize,
            icon: SvgPicture.asset("assets/icons/back.svg",height: 27,width: 27,color: white),
            onPressed: (){ Navigator.pop(context, false);}
            ),
            SizedBox(width: maxSpace),
            Text("estetik vitrini",
            style     : TextStyle(
            fontFamily: leadingFont, 
            fontSize  : 30, 
            color     : Colors.white),
            ),
          ],
        ),
      ],
    ),
    );
  }
}