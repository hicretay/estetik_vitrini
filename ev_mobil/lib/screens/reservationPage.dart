import 'package:estetikvitrini/JsnClass/appointmentList.dart';
import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/companyOperationJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/makeAppointmentOperationPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/reservationResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

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

  String select; // firma seçimi dropDown değeri

  int userIdData;

  Future appointmentListFunc() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     userIdData = prefs.getInt("userIdData"); 
    String calendarDate = (_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
    final AppointmentListJsn appointmentNewList = await appointmentListJsnFunc(userIdData,calendarDate);
    setState(() {
      appointmentList = appointmentNewList.result;
    });
  }

  Future companyListFunc() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      companyContent = companyNewList.result;
   });
   }

   Future homeContentList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     userIdData = prefs.getInt("userIdData"); 
     final ContentStreamJsn homeContentNewList = await contentStreamJsnFunc(userIdData,0); 
     setState(() {
        homeContent = homeContentNewList.result;
     });
   }

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
 
  Map<DateTime, List> selectedEvents = {
    // DateTime.now():[Event(operation: "işlem"),Event(operation: "işlem")],
    // DateTime.utc(2022, 9, 10):[Event(operation: "işlem"),],
  };

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [
    // Event(operation: "deneme"),
    ];
  }

  @override
  void initState() { 
    super.initState();
    selectedEvents = {};
    appointmentListFunc();
    companyListFunc();
    homeContentList();
    WidgetsBinding.instance.addPostFrameCallback((_){ 
    //code will run when widget rendering complete
  });
  }

  @override
  Widget build(BuildContext context) {
    //final rootContext = context.findRootAncestorStateOfType<NavigatorState>().context;
    String calendarDate = (_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Scaffold(
          floatingActionButton: CircleAvatar(//iconun çevresini saran yapı tasarımı
          maxRadius: deviceWidth(context)*0.06,
          backgroundColor: primaryColor,
          child: IconButton(
          iconSize: iconSize,
          icon: FaIcon(FontAwesomeIcons.calendar,size: 18,color: white),
          onPressed: ()async{
           ///////////////////////////////////////////////////////////////////////
              //   if (selectedEvents[_selectedDay] != null)
              //  selectedEvents[_selectedDay].add( Event(operation: "islem"));
              //  else {
              //   selectedEvents[_selectedDay] = [
              //     Event(operation: "islem")
              //   ];
              // }
           showDialog(context: context, builder: (BuildContext context){
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
                     onChanged: (value) async{                                 
                       select = value;
                       for (var item in companyContent) {
                         if(item.companyName==value){
                           compID = item.id;
                         }
                       }
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                       userIdData = prefs.getInt("userIdData"); 
                       AppointmentObject appointment = AppointmentObject(companyId: compID,userId: userIdData, companyNameS: value, campaignId: 0);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentCalendarPage(appointment: appointment)));
                       final CompanyOperationJsn companyOperation = await companyOperationJsnFunc(appointment.companyId);
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentOperationPage(companyOperation: companyOperation.result, appointment: appointment)));
                       print(value);
                       print(compID);
                     },
                     )
              )
            ],
            );
          });
         }),
       ),
          body: ProgressHUD(
            child: Builder(builder: (context)=>
                BackGroundContainer(
                colors: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? backGroundColor2 : backGroundColorDark,
                child: Column(
                children: [
                Padding(padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding*2,bottom: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                           Text("Randevularım",
                            style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: white, fontFamily: leadingFont),
                          ),
                          
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
                          child  : Column(
                            children: [
                              Column(
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
                                      defaultTextStyle: TextStyle(color: Theme.of(context).hintColor),
                                      outsideTextStyle: TextStyle(color: Theme.of(context).hintColor),
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
                                ],
                              ),
                                Padding(
                                padding: const EdgeInsets.only(left: defaultPadding,top: defaultPadding,bottom: defaultPadding),
                                child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(calendarDate + " Randevu Listesi",     
                                style     : TextStyle(
                                fontWeight: FontWeight.bold,
                                color     : Theme.of(context).hintColor),
                                 )),
                                ),
                            
                                Flexible(
                                  child: RefreshIndicator(
                                    onRefresh:()=> appointmentListFunc(),
                                    color: primaryColor,
                                    backgroundColor: secondaryColor,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap : true,
                                      itemCount  : appointmentList == null ? 0 : appointmentList.length,
                                      controller: NavigationProvider.of(context).screens[RESERVATION_PAGE].scrollController,
                                      itemBuilder: (BuildContext context, int index){  
                                      return ResevationResultWidget(
                                      companyName : appointmentList[index].companyName,
                                      operation   : appointmentList[index].operationName,
                                      time        : appointmentList[index].appointmentTime,
                                      date        : appointmentList[index].appointmentDate,
                                      confirmButton: GestureDetector(child: 
                                                     Icon(Icons.check_box_rounded,size: 18,color: appointmentList[index].confirmed ? tertiaryColor  : Theme.of(context).hintColor),
                                                     onTap: (){
                                                       showToast(context, "Randevu onayı bekleniyor...");
                                                     }),
                                         onTap    : ()async{
                                        showDialog(context: context, builder: (BuildContext context){
                                          return ProgressHUD(
                                            child: Builder(builder: (context)=>
                                                AlertDialog(
                                                content: Text("Randevu iptal edilsin mi?",style: TextStyle(fontFamily: contentFont)),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      MaterialButton(
                                                        color: primaryColor,
                                                        child: Text("Evet",style: TextStyle(color: white)),
                                                        onPressed: ()async{
                                                          final progressHUD = ProgressHUD.of(context);
                                                          progressHUD.show(); 
                                                          final deleteAppointment =await appointmentDeleteJsnFunc(appointmentList[index].id);
                                                          if(deleteAppointment.success==true){
                                                            showToast(context, "Randevu başarıyla iptal edildi!");
                                                          }
                                                          else{
                                                            showToast(context, "Randevu iptal edilemedi!");
                                                          }
                                                          await appointmentListFunc();    
                                                          Navigator.of(context).pop();                          
                                                          progressHUD.dismiss();
                                                          }),
                                                      
                                                      MaterialButton(
                                                        color: primaryColor,
                                                        child: Text("Hayır",style: TextStyle(color: white)),
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
                                  ),
                                ),
                            ],
                          ),
                      ),
                    )
                  ],
                ),
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
