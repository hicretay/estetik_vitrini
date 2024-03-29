import 'package:estetikvitrini/screens/splashPage.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'providers/themeDataProvider.dart';

Future main() async{ 
  WidgetsFlutterBinding.ensureInitialized(); // main de runApp'ten önce işlem yapılabilmesini sağlar
  await ThemeDataProvider().createSharedPrefObj(); 
  initializeDateFormatting().then(
    (_) => 
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((_) => 
    runApp(
      ChangeNotifierProvider<ThemeDataProvider>(
      create: (BuildContext context) => ThemeDataProvider(),
      child: App()),
    ))
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeDataProvider>(context, listen: false).loadTheme();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ThemeDataProvider>(
        create: (BuildContext context) => ThemeDataProvider(),
        child: App()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: Provider.of<ThemeDataProvider>(context).themeColor,
            onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
