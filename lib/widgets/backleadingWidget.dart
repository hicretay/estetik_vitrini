import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class BackLeadingWidget extends StatelessWidget {
  final Color backColor;
  const BackLeadingWidget({
    Key key, this.backColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(maxSpace),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(//iconun çevresini saran yapı tasarımı
              maxRadius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
              iconSize: iconSize,
              icon: Icon(Icons.arrow_back,color: backColor),
              onPressed: (){ Navigator.pop(context, false);}
              ),
            ),
            SizedBox(width: maxSpace),
            Text("Estetik Vitrini",
            style     : TextStyle(
            fontFamily: leadingFont, 
            fontSize  : 25, 
            color     : Colors.white),
            ),
          ],
        ),
      ],
    ),
    );
  }
}