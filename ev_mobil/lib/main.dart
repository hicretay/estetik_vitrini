import 'package:ev_mobil/screens/splashPage.dart';
import 'package:ev_mobil/settings/navigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      App(),
    ),
  );
}

class App extends StatelessWidget {
  final ThemeData theme = new ThemeData(fontFamily: "futura_medium_bt").copyWith();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: theme,
            onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
