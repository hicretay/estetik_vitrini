import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Widget? child;
  const ListTileWidget({Key? key, this.onTap, this.text, this.child}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: maxSpace,left: maxSpace,top: minSpace),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(maxSpace),
            child : Container(
            height: deviceHeight(context)*0.06,
            color : primaryColor,
            child : Padding(
              padding: const EdgeInsets.only(right: maxSpace,left: maxSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Text(text!,style: TextStyle(fontSize: 18, color:  white))),
                  child!,
                ],
              ),
            ),
          ),
        ),
      ),
            onTap: onTap,
    ),
    ]);
  }
}