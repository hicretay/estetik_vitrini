import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/reservationResultWidget.dart';
import 'package:estetikvitrini/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        body: ProgressHUD(
          child: Builder(builder: (context)=>
              BackGroundContainer(
              colors: backGroundColor2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding,bottom: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          "Randevularım",
                          style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: white, fontFamily: leadingFont),
                        ),
                        SizedBox(
                          width: maxSpace,
                        ),
                        CircleAvatar(
                          //iconun çevresini saran yapı tasarımı
                          maxRadius: 25,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            iconSize: iconSize,
                            icon: FaIcon(FontAwesomeIcons.calendar,size: 18,color: primaryColor),
                            onPressed: (){
                              NavigationProvider.of(context).setTab(FAVORITE_PAGE);
                            }
                          ),
                        ),
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
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: TableCalendarWidget(calendarFormat: CalendarFormat.twoWeeks),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index){
                              return ResevationResultWidget(
                              companyName: "Epilady Güzellik Salonu",
                              operation: "Cilt Bakımı",
                              time: "10:00",
                            );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
