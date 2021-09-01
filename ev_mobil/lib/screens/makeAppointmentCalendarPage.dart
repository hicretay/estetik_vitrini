import 'package:estetikvitrini/JsnClass/companyOperationJsn.dart';
import 'package:estetikvitrini/screens/makeAppointmentOperationPage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:estetikvitrini/settings/functions.dart';


class MakeAppointmentCalendarPage extends StatefulWidget { 
  final AppointmentObject appointment;
  final dynamic companyInfo;
  MakeAppointmentCalendarPage({this.companyInfo, this.appointment});

  @override
  _MakeAppointmentCalendarPageState createState() => _MakeAppointmentCalendarPageState(companyInfo: companyInfo , appointment: appointment);
}

class _MakeAppointmentCalendarPageState extends State<MakeAppointmentCalendarPage> {
  AppointmentObject appointment;
  TextEditingController teSearch = TextEditingController();
  bool calendarSelected = false;
  bool reservationSelected = true;

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
    Map<DateTime, List<Event>> selectedEvents;

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
  

  dynamic companyInfo;
  @override
  void initState() { 
    super.initState();
    selectedEvents = {};
  }

  _MakeAppointmentCalendarPageState({this.companyInfo,this.appointment});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProgressHUD(
          child: Builder(builder: (context)=>
              Scaffold(
                body: Container(
                color: secondaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                      children: [
                        CircleAvatar(
                          //iconun çevresini saran yapı tasarımı
                          maxRadius: deviceWidth(context)*0.06,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            iconSize: iconSize,
                            icon: Icon(Icons.arrow_back,color: secondaryColor,size: 23),
                            onPressed: (){Navigator.pop(context, false);},
                          ),
                        ),
                        SizedBox(width: maxSpace),
                        Text("Estetik Vitrini",
                          style     : TextStyle(
                          fontFamily: leadingFont, fontSize: 25, color: Colors.white),
                        ),
                      ],
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child:  Text("Randevu Al", //Büyük Başlık
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: white, fontFamily: leadingFont),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              companyInfo[0].companyName, 
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
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(cardCurved),
                            ),
                          ),
                          child: Column(
                            children: [
                             TableCalendar(                              
                             locale: "tr",
                             focusedDay: _focusedDay,
                             firstDay: DateTime.utc(2010, 10, 16),
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
            bottomNavigationBar: 
           TextButtonWidget(buttonText: "Randevu alınacak işlemi seçiniz",
           //-----------------------------Randevu alınacak işlemi seçiniz butonu------------------------------
           onPressed: ()async{
          appointment.appointmentDate=(_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
          print(appointment.appointmentDate);
           final progressHUD = ProgressHUD.of(context);
           progressHUD.show(); 
           final CompanyOperationJsn companyOperation = await companyOperationJsnFunc(1);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeAppointmentOperationPage(companyOperation: companyOperation.result,companyInfo: companyInfo, appointment: appointment)));
           progressHUD.dismiss();
         }
         //-------------------------------------------------------------------------------------------------
              )
            ),
          ),
        ),
    );
  }
}
class Event {
  final String operation;
  Event({this.operation});

  String toString() => this.operation;
}