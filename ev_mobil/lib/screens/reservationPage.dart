import 'package:estetikvitrini/JsnClass/appointmentDeleteJsn.dart';
import 'package:estetikvitrini/JsnClass/appointmentList.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/reservationResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class ReservationPage extends StatefulWidget {
  static const route = "reservationPage";
  String selectedDay;
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController teSearch = TextEditingController();
  Map<CalendarFormat, String> days = {};
  List appointmentList;

  Future appointmentListFunc() async{
    String calendarDate = (_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
    final AppointmentListJsn appointmentNewList = await appointmentListJsnFunc(1,calendarDate);
    setState(() {
      appointmentList = appointmentNewList.result;
    });
  }

  Future fullDays() async{
    final AppointmentListJsn appointmentNewList = await appointmentListJsnFunc(1,"");
    setState(() {
      appointmentList = appointmentNewList.result;
    });
  }

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Event>> selectedEvents;

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [
    ];
  }


  @override
  void initState() { 
    super.initState();
    selectedEvents = {};
    appointmentListFunc();
  }

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
                         Text("Randevularım",
                          style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: white, fontFamily: leadingFont),
                        ),
                        CircleAvatar(//iconun çevresini saran yapı tasarımı
                          maxRadius: deviceWidth(context)*0.06,
                          backgroundColor: Colors.white,
                          child: IconButton(
                          iconSize: iconSize,
                          icon: FaIcon(FontAwesomeIcons.calendar,size: 18,color: primaryColor),
                          onPressed: ()async{
                            NavigationProvider.of(context).setTab(FAVORITE_PAGE);
                           //await appointmentListFunc();
                          }),
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
                        child  : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: maxSpace,left: maxSpace),
                              child  : TableCalendar(
                              locale: "tr",
                              focusedDay: _focusedDay,
                              firstDay: DateTime.now(),
                              lastDay: DateTime.utc(2030, 3, 14),
                              shouldFillViewport: false,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              calendarFormat: CalendarFormat.twoWeeks,
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
                              onDaySelected: (selectedDay, focusedDay) async{
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;   
                                  await appointmentListFunc();  
                                  
                            
                              },
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                              eventLoader: _getEventsForDay,
                            )
                            ),
                            ListView.builder(
                              physics    : NeverScrollableScrollPhysics(),
                              shrinkWrap : true,
                              itemCount  : appointmentList == null ? 0 : appointmentList.length,
                              itemBuilder: (BuildContext context, int index){
                              return ResevationResultWidget(
                              companyName: appointmentList[index].companyName,
                              operation  : appointmentList[index].operationName,
                              time       : appointmentList[index].appointmentTime,
                              date       : appointmentList[index].appointmentDate,
                              onTap      : ()async{
                                showDialog(context: context, builder: (BuildContext context){
                                  return ProgressHUD(
                                    child: Builder(builder: (context)=>
                                        AlertDialog(
                                        content: Text("Randevu iptal edilsin mi?",style: TextStyle(fontFamily: contentFont)),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              MaterialButton(
                                                color: primaryColor,
                                                child: Text("Evet"),
                                                onPressed: ()async{
                                                  final progressHUD = ProgressHUD.of(context);
                                                  progressHUD.show(); 
                                                  await appointmentDeleteJsnFunc(appointmentList[index].id);
                                                  final AppointmentDeleteJsn deleteAppointment = await appointmentDeleteJsnFunc2(appointmentList[index].id);
                                                  if(deleteAppointment.success==true){
                                                    showToast(context, "Randevu başarıyla iptal edildi!");
                                                  }
                                                  await appointmentListFunc();    
                                                  Navigator.of(context).pop();                          
                                                  progressHUD.dismiss();
                                                  }),
                                              SizedBox(width: deviceWidth(context)*0.01),
                                              MaterialButton(
                                                color: primaryColor,
                                                child: Text("Hayır"),
                                                onPressed: (){
                                                   showToast(context, "Randevu iptal edilmedi!");
                                                   Navigator.of(context).pop();
                                                },
                                                
                                              ),
                                          ],)
                                        ],
                                      ),
                                    ),
                                  );
                                });

                              },
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
class Event {
  final String operation;
  Event({this.operation});

  String toString() => this.operation;
}