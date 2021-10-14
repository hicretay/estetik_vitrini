import 'package:estetikvitrini/screens/favoritePage.dart';
import 'package:estetikvitrini/screens/homePage.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/screens/registerPage.dart';
import 'package:estetikvitrini/screens/reservationPage.dart';
import 'package:estetikvitrini/screens/searchPage.dart';
import 'package:estetikvitrini/screens/settingsPage.dart';
import 'package:estetikvitrini/screens/splashPage.dart';
import 'package:estetikvitrini/settings/root.dart';
import 'package:estetikvitrini/model/screenProviderModel.dart';
import 'package:estetikvitrini/widgets/exitAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../settings/consts.dart';

const HOME_PAGE = 0;
const FAVORITE_PAGE = 1;
const RESERVATION_PAGE = 2;
const SEARCH_PAGE = 3;
const SETTINGS_PAGE = 4;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) => Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = HOME_PAGE; // Başlangıç sayfası homePage
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
      scrollController: ScrollController(),
      child: HomePage(),
      title: "",
      icon: SvgPicture.asset("assets/icons/home.svg",height: 25,width: 25,color: primaryColor),
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/home.svg",height: 25,width: 25,color: primaryColor),
      ),
      initialRoute: HomePage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (_) => HomePage());
      },
    ),
    FAVORITE_PAGE: Screen(
      scrollController: ScrollController(),
      icon: SvgPicture.asset("assets/icons/star.svg",height: 25,width: 25, color: primaryColor),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child:SvgPicture.asset("assets/icons/star.svg",height: 25,width: 25, color: primaryColor),
      ),
      child: FavoritePage(),
      initialRoute: FavoritePage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      
      onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (_) => FavoritePage());
      },
    ),
    RESERVATION_PAGE: Screen(
      scrollController: ScrollController(),
      icon: SvgPicture.asset("assets/icons/calendar.svg",height: 25,width: 25, color: primaryColor),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child:SvgPicture.asset("assets/icons/calendar.svg",height: 25,width: 25, color: primaryColor),
      ),
      child: ReservationPage(),
      initialRoute: ReservationPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (_) => ReservationPage());
      },
    ),
    SEARCH_PAGE: Screen(  
      scrollController: ScrollController(),  
      icon: SvgPicture.asset("assets/icons/search.svg",height: 25,width: 25, color: primaryColor),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/search.svg",height: 25,width: 25, color: primaryColor),
      ),
      child: SearchPage(),
      initialRoute: SearchPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (_) => SearchPage());
      },
    ),
    SETTINGS_PAGE: Screen(
      scrollController: ScrollController(),
      icon: SvgPicture.asset("assets/icons/settings.svg",height: 25,width: 25, color: primaryColor),
      title: "",
      activeIcon: CircleAvatar(
        backgroundColor: secondaryColor,
        child: SvgPicture.asset("assets/icons/settings.svg",height: 25,width: 25, color: primaryColor),
      ),
      child: SettingsPage(),
      initialRoute: SettingsPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (_) {
            return MaterialPageRoute(builder: (_) => SettingsPage());
      },
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

//-----------------------Sayfa yönlendirme fonksiyonu---------------------
//NavigationProvider.of(context).setTab(PAGENAME); şeklinde kullanılacak.
  void setTab(int tab) async{
    if(tab == currentTabIndex){
      _scrollToStart();
      notifyListeners();
    }
    else{
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }
//-----------------------------------------------------------------------

    void _scrollToStart() async{
    await Future.delayed(const Duration(milliseconds: 300));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
        if (currentScreen.scrollController != null) {
        currentScreen.scrollController.animateTo(
        currentScreen.scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  });
  }

  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;
    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != HOME_PAGE) {
        setTab(HOME_PAGE);
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




