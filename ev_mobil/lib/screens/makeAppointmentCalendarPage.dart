import 'package:estetikvitrini/JsnClass/companyOperationJsn.dart';
import 'package:estetikvitrini/screens/makeAppointmentOperationPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/tableCalendarWidget.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:estetikvitrini/settings/functions.dart';


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
           final progressHUD = ProgressHUD.of(context);
           progressHUD.show(); 
           final CompanyOperationJsn companyOperation = await companyOperationJsnFunc(1);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>MakeAppointmentOperationPage(companyOperation: companyOperation.result)));
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
