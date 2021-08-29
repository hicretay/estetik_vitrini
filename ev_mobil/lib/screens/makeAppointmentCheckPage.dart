import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/appointmentObject.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../widgets/informationRowWidget.dart';

class MakeAppointmentCheckPage extends StatefulWidget {
  final AppointmentObject appointment;
  final dynamic companyInfo;
  MakeAppointmentCheckPage({Key key, this.companyInfo, this.appointment}) : super(key: key);

  @override
  _MakeAppointmentCheckPageState createState() => _MakeAppointmentCheckPageState(companyInfo: companyInfo, appointment: appointment);
}

class _MakeAppointmentCheckPageState extends State<MakeAppointmentCheckPage> {
  TextEditingController teName = TextEditingController();
  TextEditingController teNote = TextEditingController();
  String teOperation;

   AppointmentObject appointment;

   dynamic companyInfo;
   _MakeAppointmentCheckPageState({this.companyInfo, this.appointment});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
              Container(
              color: secondaryColor,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(//iconun çevresini saran yapı tasarımı
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                            child: IconButton(
                            iconSize: iconSize,
                            icon: Icon(Icons.arrow_back,color: secondaryColor),
                            onPressed: (){ Navigator.pop(context, false);}
                            ),
                          ),
                          SizedBox(width: maxSpace),
                          Text("Estetik Vitrini",
                          style     : TextStyle(
                          fontFamily: leadingFont, 
                          fontSize  : 20, 
                          color     : Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text( "Randevu Al",
                            style     : TextStyle(
                            fontFamily: leadingFont,
                            color     : Colors.white,
                            fontSize  : 45,
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.topLeft,
                            child: Text(companyInfo[0].companyName, 
                            style: TextStyle(
                            color: Colors.white),
                          ),
                        ),
                        SizedBox(height: maxSpace)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(decoration: BoxDecoration(
                        color       : Colors.white,
                        borderRadius: BorderRadius.vertical(
                        top         : Radius.circular(cardCurved),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(children: [
                  InformationRowWidget(
                    containerColor: secondaryColor,
                    operationName: "Tarih",
                    width: 250,
                    height: 50,
                    child: Text(appointment.appointmentTimeId,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InformationRowWidget(
                    containerColor: secondaryColor,
                    width: 250,
                    height: 50,
                    operationName: "Saat",
                    child: Text(
                      appointment.operation.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InformationRowWidget(
                    containerColor: secondaryColor,
                    operationName: "İşlem",
                    width: 250,
                    height: 50,
                    child: Text("Medikal Estetik",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InformationRowWidget(
                    containerColor: darkWhite,
                    width: 250,
                    height: 100,
                    operationName: "Özel Not",
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      controller: teNote,
                      cursorColor: primaryColor,
                      style: TextStyle(color: primaryColor, fontSize: 18),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Container(
                        width: 250,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: backGroundColor1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Center(
                          child: MaterialButton(
                            child: Text(
                              "Randevu Olustur",
                              style: TextStyle(
                                  fontFamily: leadingFont,
                                  color: Colors.white,
                                  fontSize: 22),
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                                NavigationProvider.of(context).setTab(RESERVATION_PAGE);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ));
  }
}


