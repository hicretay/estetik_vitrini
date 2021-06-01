import 'package:flutter/material.dart';

class Screen {
  
  //Ekran verilecek
  final Widget child;

  //Ekranlar için rota oluşturucu
  final RouteFactory onGenerateRoute;

  //Başlangıç rotası tanımı
  final String initialRoute;

  //Ekranların navigator state2i
  final GlobalKey<NavigatorState> navigatorState;

  Screen({
    @required this.child,
    @required this.onGenerateRoute,
    @required this.initialRoute,
    @required this.navigatorState,
  });
}