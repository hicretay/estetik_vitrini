import 'package:ev_mobil/settings/navigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'consts.dart';

class Root extends StatelessWidget {
  static const route = '/';
  //Uygulama için navigasyon başlangıc noktası

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final bottomNavigationBarItems = [
          //------------------Bottom Bar itemları görünümleri----------------
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/ev.svg"),
            label: "",
            activeIcon: CircleAvatar(
              backgroundColor: secondaryColor,
              child: SvgPicture.asset("assets/icons/ev.svg"),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/kalp.svg"),
            label: "",
            activeIcon: CircleAvatar(
              backgroundColor: secondaryColor,
              child: SvgPicture.asset("assets/icons/kalp.svg"),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/takvim.svg"),
            label: "",
            activeIcon: CircleAvatar(
              backgroundColor: secondaryColor,
              child: SvgPicture.asset("assets/icons/takvim.svg"),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/haritanoktası.svg"),
            label: "",
            activeIcon: CircleAvatar(
              backgroundColor: secondaryColor,
              child: SvgPicture.asset("assets/icons/haritanoktası.svg"),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/ayarlar.svg"),
            label: "",
            activeIcon: CircleAvatar(
              backgroundColor: secondaryColor,
              child: SvgPicture.asset("assets/icons/ayarlar.svg"),
            ),
          ),
        ];
        //------------------------------------------------------------

        // Her ekran için Navigatorı başlatır
        final screens = provider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return Scaffold(
          body: IndexedStack(
            children: screens,
            index: provider.currentTabIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavigationBarItems,
            currentIndex: provider.currentTabIndex,
            onTap: provider.setTab,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        );
      },
    );
  }
}
