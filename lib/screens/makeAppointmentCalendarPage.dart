import 'package:estetikvitrini/JsnClass/companyOperationJsn.dart';
import 'package:estetikvitrini/screens/makeAppointmentOperationPage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:estetikvitrini/settings/functions.dart';

class MakeAppointmentCalendarPage extends StatefulWidget { 
  final AppointmentObject? appointment;

  MakeAppointmentCalendarPage({this.appointment});

  @override
  _MakeAppointmentCalendarPageState createState() => _MakeAppointmentCalendarPageState(appointment: appointment!);
}

class _MakeAppointmentCalendarPageState extends State<MakeAppointmentCalendarPage> {
  AppointmentObject appointment;
  TextEditingController teSearch = TextEditingController();
  bool calendarSelected = false;
  bool reservationSelected = true;

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late  Map<DateTime, List<Event>> selectedEvents;

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
  

  @override
  void initState() { 
    super.initState();
    selectedEvents = {};
  }

  _MakeAppointmentCalendarPageState({required this.appointment});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProgressHUD(
          child: Builder(builder: (context)=>
              Scaffold(
                body: Container(
                color:  primaryColor,
                child: Column(
                  children: [
                    BackLeadingWidget(
                      backColor: primaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: leadingText(context, "randevu al")
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              appointment.companyNameS!, 
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox( height: maxSpace)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(cardCurved),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                             TableCalendar(                              
                             locale: "tr",
                             focusedDay: _focusedDay,
                             firstDay: DateTime.now(),
                             lastDay: DateTime.utc(2030, 3, 14),
                             shouldFillViewport: false,
                             startingDayOfWeek: StartingDayOfWeek.monday,
                             calendarFormat:  CalendarFormat.month,
                             calendarStyle: CalendarStyle(
                               isTodayHighlighted: true,
                               selectedDecoration: BoxDecoration(
                                 color: primaryColor,
                                 shape: BoxShape.rectangle,
                                 borderRadius: BorderRadius.circular(minCurved),
                               ),
                               outsideDecoration: boxDecoration,
                               defaultDecoration: boxDecoration,
                               weekendDecoration: boxDecoration,
                               defaultTextStyle: TextStyle(color: Theme.of(context).hintColor),
                               selectedTextStyle: TextStyle(
                                 color: Colors.white,
                               ),
                               todayDecoration: BoxDecoration(
                                 color: secondaryColor,
                                 shape: BoxShape.rectangle,
                                 borderRadius: BorderRadius.circular(minCurved),
                               ),
                             ),
                             selectedDayPredicate: (day) {
                               return isSameDay(_selectedDay, day);
                             },
                             onDaySelected: (selectedDay, focusedDay) {
                               setState(() {          
                                 _selectedDay = selectedDay;
                                 _focusedDay = focusedDay;
                               });
                             },
                             headerStyle: HeaderStyle(
                               formatButtonVisible: false,
                               titleCentered: true,
                             ),
                             eventLoader: _getEventsForDay,
                           )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            bottomNavigationBar: Container(
              color: Theme.of(context).backgroundColor,
              child: TextButtonWidget(
                buttonText: "Randevu alınacak işlemi seçiniz",
                icon: FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: white),
           //-----------------------------Randevu alınacak işlemi seçiniz butonu------------------------------
           onPressed: ()async{
           appointment.appointmentDate=(_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
           print(appointment.appointmentDate);
           final progressHUD = ProgressHUD.of(context);
           progressHUD!.show(); 
           final CompanyOperationJsn? companyOperation = await companyOperationJsnFunc(appointment.companyId!);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeAppointmentOperationPage(companyOperation: companyOperation!.result, appointment: appointment)));
           progressHUD.dismiss();
         }
         //-------------------------------------------------------------------------------------------------
                ),
            )
            ),
          ),
        ),
    );
  }
}
class Event {
  final String operation;
  Event({required this.operation});

  String toString() => this.operation;
}