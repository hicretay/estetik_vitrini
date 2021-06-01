import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BackGroundContainer extends StatelessWidget {
  // Uygulama arka planındaki renk geçişini oluşturuyor
  // favoritePage, locationPage sayfalarında kullanıldı
  final Widget child;
  List<Color> colors;
  BackGroundContainer({this.child,this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: colors
        ),
      ),
    );
  }
}
