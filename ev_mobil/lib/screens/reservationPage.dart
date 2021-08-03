import 'package:ev_mobil/settings/navigationProvider.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/backgroundContainer.dart';
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
    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
          colors: backGroundColor2,
          child: Column(
            children: [
               Padding(padding: const EdgeInsets.all(defaultPadding),
              child: Row(
              children: [
              CircleAvatar(
                //iconun çevresini saran yapı tasarımı
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                    iconSize: iconSize,
                    icon: Icon(Icons.arrow_back,color: primaryColor),
                    onPressed: (){
                      NavigationProvider.of(context).setTab(FAVORITE_PAGE);
                    },
                ),
              ),
              SizedBox(
                width: maxSpace,
              ),
              Text(
                "Estetik Vitrini",
                style: TextStyle(
                      fontFamily: leadingFont, fontSize: 20, color: Colors.white),
              ),
            ])),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Randevularım",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: white, fontFamily: leadingFont),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: TableCalendarWidget(calendarFormat: CalendarFormat.twoWeeks),
                      ),
                      Container(
                        // child: ListView.builder(
                        //   itemCount: reservations.length,
                        //   itemBuilder: (BuildContext context, int index){
                        //   return ResevationResultWidget(
                        //   companyName: "Epilady Güzellik Salonu",
                        //   operation: "Cilt Bakımı",
                        //   time: "10:00",
                        // );
                        // }),
                      ),
                      ResevationResultWidget(
                        companyName: "Epilady Güzellik Salonu",
                        operation: "Cilt Bakımı",
                        time: "10:00",
                      ),
                      ResevationResultWidget(
                        companyName: "Estecool Güzellik Merkezi",
                        operation: "Lazer Epilasyon",
                        time: "16:30",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
