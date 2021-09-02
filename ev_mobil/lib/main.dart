import 'package:estetikvitrini/providers/jsonDataProvider.dart';
import 'package:estetikvitrini/screens/splashPage.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<JsonDataProvider>(create: (_) => JsonDataProvider()),
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
