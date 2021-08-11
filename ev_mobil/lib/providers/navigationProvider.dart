import 'package:estetikvitrini/screens/favoritePage.dart';
import 'package:estetikvitrini/screens/homePage.dart';
import 'package:estetikvitrini/screens/locationPage.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/screens/registerPage.dart';
import 'package:estetikvitrini/screens/reservationPage.dart';
import 'package:estetikvitrini/screens/settingsPage.dart';
import 'package:estetikvitrini/screens/splashPage.dart';
import 'package:estetikvitrini/settings/root.dart';
import 'package:estetikvitrini/model/screenProviderModel.dart';
import 'package:estetikvitrini/widgets/exitAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../settings/consts.dart';

const HOME_PAGE = 0;
const FAVORITE_PAGE = 1;
const RESERVATION_PAGE = 2;
const LOCATION_PAGE = 3;
const SETTINGS_PAGE = 4;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) => Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = LOCATION_PAGE; // Başlangıç sayfası locationPage

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == SplashPage.route) {
      return MaterialPageRoute(builder: (_) => SplashPage());
    } 
    else if(settings.name == LoginPage.route){
      return MaterialPageRoute(builder: (_) => LoginPage());
    }
    else if(settings.name == RegisterPage.route){
      return MaterialPageRoute(builder: (_) => RegisterPage());
    }
    else{
      return MaterialPageRoute(builder: (_) => Root());
    }
  }

  final Map<int, Screen> _screens = {
    HOME_PAGE: Screen(
      child: HomePage(),
      title: "",
      icon: SvgPicture.asset("assets/icons/ev.svg"),
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/ev.svg"),
      ),
      initialRoute: HomePage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => HomePage());
        }
      },
    ),
    FAVORITE_PAGE: Screen(
      icon: SvgPicture.asset("assets/icons/kalp.svg"),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/kalp.svg"),
      ),
      child: FavoritePage(),
      initialRoute: FavoritePage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => FavoritePage());
        }
      },
      scrollController: ScrollController(),
    ),
    RESERVATION_PAGE: Screen(
      icon: SvgPicture.asset("assets/icons/takvim.svg"),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/takvim.svg"),
      ),
      child: ReservationPage(),
      initialRoute: ReservationPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => ReservationPage());
        }
      },
    ),
    LOCATION_PAGE: Screen(    
      icon: SvgPicture.asset("assets/icons/haritanoktası.svg"),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/haritanoktası.svg"),
      ),
      child: LocationPage(),
      initialRoute: LocationPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => LocationPage());
        }
      },
    ),
    SETTINGS_PAGE: Screen(
      icon: SvgPicture.asset("assets/icons/ayarlar.svg"),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/ayarlar.svg"),
      ),
      child: SettingsPage(),
      initialRoute: SettingsPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => SettingsPage());
        }
      },
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

//-----------------------Sayfa yönlendirme fonksiyonu---------------------
//NavigationProvider.of(context).setTab(PAGENAME); şeklinde kullanılacak.
  void setTab(int tab) {
    _currentScreenIndex = tab;
    //_currentScreenIndex: başlangıç sayfası tab değerine eşitlendi
    notifyListeners();
  }
//-----------------------------------------------------------------------


  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != LOCATION_PAGE) {
        setTab(LOCATION_PAGE);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}



