import 'package:ev_mobil/settings/navigationProvider.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/backgroundContainer.dart';
import 'package:ev_mobil/widgets/headerWidget.dart';
import 'package:ev_mobil/widgets/reservationResultWidget.dart';
import 'package:ev_mobil/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationPage extends StatefulWidget {
  static const route = "reservationPage";
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController teSearch = TextEditingController();
  Map<CalendarFormat, String> days = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        colors: backGroundColor2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: HeaderWidget(
                primaryIcon: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
                secondaryIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                onPressedPrimary: () {
                  NavigationProvider.of(context).setTab(FAVORITE_PAGE);
                },
                onPressedSecondary: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Randevularım",
                  style: TextStyle(
                    fontFamily: leadingFont,
                    color: Colors.white,
                    fontSize: 45,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(cardCurved),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: TableCalendarWidget(),
                      ),
                      ResevationResultWidget(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


