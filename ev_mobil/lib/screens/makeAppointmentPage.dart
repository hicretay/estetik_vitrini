import 'package:ev_mobil/settings/consts.dart';

import 'package:ev_mobil/widgets/headerWidget.dart';
import 'package:ev_mobil/widgets/reservationCalendarWidget.dart';
import 'package:flutter/material.dart';

class MakeAppointmentPage extends StatefulWidget {
  @override
  _MakeAppointmentPageState createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage> {
  TextEditingController teSearch = TextEditingController();
  bool calendarSelected = false;
  bool reservationSelected = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: secondaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: HeaderWidget(
                  primaryIcon: Icon(
                    Icons.arrow_back,
                    color: secondaryColor,
                  ),
                  secondaryIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                  onPressedSecondary: () {},
                  onPressedPrimary: () {
                    Navigator.pop(context, false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Randevu Al",
                        style: TextStyle(
                          fontFamily: leadingFont,
                          color: Colors.white,
                          fontSize: 45,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Estecool Güzellik Merkezi",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: maxSpace,
                    )
                  ],
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
                       ReservationCalendarWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
