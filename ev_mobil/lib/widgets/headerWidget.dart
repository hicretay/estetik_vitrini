// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../settings/consts.dart';

//Sayfa başlığında yer alan circle içindeki icon, "Estetik Vitrini" texti ve bir child içerir.
class HeaderWidget extends StatelessWidget {
  final Widget primaryIcon; //Circle içinde yer alacak ikon
  final Widget secondaryIcon;
  final VoidCallback
      onPressedPrimary; //circleAvatar'a basıldığında yapılacak işlem
  final VoidCallback onPressedSecondary;

  HeaderWidget(
      {this.primaryIcon,
      this.onPressedPrimary,
      this.secondaryIcon,
      this.onPressedSecondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              //iconun çevresini saran yapı tasarımı
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                iconSize: iconSize,
                icon: primaryIcon,
                onPressed: onPressedPrimary,
              ),
            ),
            SizedBox(
              width: maxSpace,
            ),
            Text(
              "Estetik Vitrini",
              style: TextStyle(
                  fontFamily: leadingFont, fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: maxSpace),
          child: CircleAvatar(
            //iconun çevresini saran yapı tasarımı
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              iconSize: iconSize,
              icon: secondaryIcon,
              onPressed: onPressedSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
