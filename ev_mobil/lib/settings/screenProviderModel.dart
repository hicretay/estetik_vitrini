import 'package:flutter/material.dart';

class Screen {
  //Ekran verilecek
  final Widget child;

  //Ekranlar için rota oluşturucu
  final RouteFactory onGenerateRoute;

  //Başlangıç rotası tanımı
  final String initialRoute;

  //BottomNavigationBar'da gösterilecek olan başlık
  final String title;

  //BottomNavigationBar'da gösterilecek olan ikon
  final Widget icon;

  //Aktfi icon tasarımı
  final Widget activeIcon;

  //Ekranların navigator state'i
  final GlobalKey<NavigatorState> navigatorState;

  Screen({
    @required this.activeIcon,
    @required this.title,
    @required this.icon,
    @required this.child,
    @required this.onGenerateRoute,
    @required this.initialRoute,
    @required this.navigatorState,
  });
}
