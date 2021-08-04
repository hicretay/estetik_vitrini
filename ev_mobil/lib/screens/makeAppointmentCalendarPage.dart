import 'package:ev_mobil/screens/makeAppointmentOperationPage.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

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
                child: Row(
                  children: [
                    CircleAvatar(
                      //iconun çevresini saran yapı tasarımı
                      maxRadius: 25,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: secondaryColor,size: 25),
                        onPressed: (){Navigator.pop(context, false);},
                      ),
                    ),
                    SizedBox(
                      width: maxSpace,
                    ),
                    Text(
                      "Estetik Vitrini",
                      style: TextStyle(
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
                       TableCalendarWidget(calendarFormat: CalendarFormat.month),
                       TextButton(
                        style: ButtonStyle(),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeAppointmentOperationPage()));
                        },
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                        Text("Randevu alınacak işlemi seçiniz",
                        style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontFamily: contentFont)),
                        SizedBox(width: deviceWidth(context)*0.01),
                        FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: secondaryColor,)])
                        )
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
