//import 'package:dropdown_search/dropdown_search.dart';
import 'package:estetikvitrini/JsnClass/appointmentDeleteJsn.dart';
import 'package:estetikvitrini/JsnClass/appointmentList.dart';
import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/screens/makeAppointmentCalendarPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/reservationResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:table_calendar/table_calendar.dart';


// ignore: must_be_immutable
class ReservationPage extends StatefulWidget {
  static const route = "reservationPage";
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  TextEditingController teSearch = TextEditingController();
  List appointmentList;
  List companyContent;
  List homeContent;

  int selection;
  String select;


  final navigatorKey = GlobalKey<NavigatorState>();


  Future appointmentListFunc() async{
    String calendarDate = (_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
    final AppointmentListJsn appointmentNewList = await appointmentListJsnFunc(1,calendarDate);
    setState(() {
      appointmentList = appointmentNewList.result;
    });
  }

   Map<String,int> companyMap = {};

  Future companyListFunc() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      companyContent = companyNewList.result;
   });
   }


   Future homeContentList() async{
     final ContentStreamJsn homeContentNewList = await contentStreamJsnFunc(3); 
     setState(() {
        homeContent = homeContentNewList.result;
     });
   }

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  
  Map<DateTime, List<Event>> selectedEvents = {
    // DateTime.now():[Event(operation: "işlem"),Event(operation: "işlem")],
    // DateTime.utc(2022, 9, 10):[Event(operation: "işlem"),],
  };

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [
     //Event(operation: "deneme"),
     // Event(operation: "deneme"),
  
    ];
  }
List<String> alertCompanyList = [];
//   for (var item in companyContent[index].companyName) {
//    alertCompanyList.add(item.companyName);
//  }


  @override
  void initState() { 
    super.initState();
    selectedEvents = {};
    appointmentListFunc();
    companyListFunc();
    homeContentList();
  }

  @override
  Widget build(BuildContext context) {
    final rootContext = context.findRootAncestorStateOfType<NavigatorState>().context;
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
              BackGroundContainer(
              colors: backGroundColor2,
              child: Column(
              children: [
              Padding(padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding,bottom: defaultPadding),
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
                           ///////////////////////////////////////////////////////////////////////
                              //   if (selectedEvents[_selectedDay] != null)
                              //  selectedEvents[_selectedDay].add( Event(operation: "islem"));
                              //  else {
                              //   selectedEvents[_selectedDay] = [
                              //     Event(operation: "islem")
                              //   ];
                              // }
                           showDialog(context: rootContext, builder: (BuildContext rootContext){
                             int compID = -1;
                             return AlertDialog(
                               actions: <Widget>[
                                 Container(
                                   width: deviceWidth(context),
                                   child: 
                                   SearchableDropdown(
                                     menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
                                     closeButton: null,
                                     dialogBox: false,
                                     isCaseSensitiveSearch: false,
                                     style: TextStyle(color: primaryColor),
                                     isExpanded: true,
                                     hint: Center(
                                     child: Text("Randevu alınacak firmayı seçiniz",
                                     textAlign: TextAlign.center,
                                     style    : TextStyle(
                                     fontSize : 18, 
                                     color    :  primaryColor,
                                     )),
                                     ),
                                     value: select,
                                     items: companyContent.map((data){
                                     return DropdownMenuItem(
                                     child: SizedBox(
                                     child: Center(
                                     child: Text(data.companyName, textAlign: TextAlign.center,
                                     style: TextStyle(color: primaryColor, fontSize: 20)),
                                     ),
                                     ),
                                     value: data.companyName);
                                     }).toList(),  
                                     onChanged: (value) {
                                     if (!mounted)
                                     return;                                  
                                     setState(() {
                                       select = value;
                                       for (var item in companyContent) {
                                         if(item.companyName==value){
                                           compID = item.id -1;
                                         }
                                         else{
                                           NavigationProvider.of(rootContext).setTab(RESERVATION_PAGE);
                                         }
                                       }
                                       print(companyContent[compID].id.toString());
                                       AppointmentObject appointment = AppointmentObject(companyId: companyContent[compID].id,userId: 1);
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentCalendarPage(indexx: companyContent[compID].id,appointment: appointment,companyInfo: homeContent)));
                                       Navigator.of(rootContext).pop(false);
                                     });
                                     },
                                     )
                                     
                                   ////////////////////////////////////////////////////////////
                                  // DropdownButton(   
                                  //    isExpanded: true,
                                  //    hint: Center(
                                  //    child: Text("Randevu alınacak firmayı seçiniz",
                                  //    textAlign: TextAlign.center,
                                  //    style    : TextStyle(
                                  //    fontSize : 18, 
                                  //    color    :  primaryColor,
                                  //    )),
                                  //    ),
                                  //    dropdownColor: white,
                                  //    value: selection,
                                  //    items: companyContent.map((data){
                                  //    return DropdownMenuItem(
                                  //    child: SizedBox(
                                  //    child: Center(
                                  //    child: Text(data.companyName, textAlign: TextAlign.center,
                                  //    style: TextStyle(color: primaryColor, fontSize: 20)),
                                  //    ),
                                  //    ),
                                  //    value: data.id);
                                  //    }).toList(),                                  
                                  //    onChanged: (value) {
                                  //    if (!mounted)
                                  //    return;                                  
                                  //    setState(() {
                                  //      selection = value;
                                  //      print(companyContent[selection-1].id.toString());
                                  //      AppointmentObject appointment = AppointmentObject(companyId: companyContent[selection-1].id,userId: 1);
                                  //      Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentCalendarPage(indexx: companyContent[selection-1].id,appointment: appointment,companyInfo: homeContent)));
                                  //      Navigator.of(rootContext).pop(false);
                                  //    });
                                  //    },
                                  //  )
                              )
                            ],
                          );
                        });
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
                        child  : SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child  : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: maxSpace,left: maxSpace),
                              child  : TableCalendar(
                              locale: "tr",
                              focusedDay: _focusedDay,
                              firstDay: DateTime.utc(2010, 10, 16),
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
                                  await appointmentListFunc();  // randevuları yenileme
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
                                
                                 setState(() {
                                    for (var item in companyContent[index].companyName) {
                                    alertCompanyList.add(item.companyName);
                                  }
                                 });
                                
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
