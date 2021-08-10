import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Widget child;
  const ListTileWidget({Key key, this.onTap, this.text, this.child}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: minSpace),
      GestureDetector(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: maxSpace),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
                  child : Container(
                  height: deviceHeight(context)*0.07,
                  color : primaryColor,
                  child : Row(
                    children: <Widget>[
                      SizedBox(width: defaultPadding),
                      Expanded(child: Text(text,style: TextStyle(fontSize: 18, color:  white))),
                      child,
                      SizedBox(width: defaultPadding),
                    ],
                  ),
                ),
              ),
            ),
            onTap: onTap,
    ),
    ]);
  }
}