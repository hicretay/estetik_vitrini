import 'package:estetikvitrini/screens/splashPage.dart';
import 'package:estetikvitrini/settings/googleSignInProvider.dart';
import 'package:estetikvitrini/settings/navigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // google sign için
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
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
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
