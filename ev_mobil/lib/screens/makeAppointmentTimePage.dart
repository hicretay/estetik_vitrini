import 'package:estetikvitrini/screens/makeAppointmentCheckPage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class MakeAppointmentTimePage extends StatefulWidget {
  final AppointmentObject appointment;
  final List companyOperationTime;
  final dynamic companyInfo;
  MakeAppointmentTimePage({Key key, this.companyOperationTime, this.companyInfo, this.appointment, }) : super(key: key);

  @override
  _MakeAppointmentTimePageState createState() => _MakeAppointmentTimePageState(companyOperationTime: companyOperationTime,companyInfo: companyInfo, appointment: appointment);
}

class _MakeAppointmentTimePageState extends State<MakeAppointmentTimePage> {
  AppointmentObject appointment;
  List companyOperationTime;
  dynamic companyInfo;
  _MakeAppointmentTimePageState({this.companyOperationTime, this.companyInfo, this.appointment});

  int _checked = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProgressHUD(
        child: Builder(builder: (context)=>
            Scaffold(
            body: 
                Container(
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
                            Padding(padding: const EdgeInsets.all(defaultPadding),
                            child: GridView.builder(
                              shrinkWrap: true,                 
                              itemCount: companyOperationTime.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (1 / .5),
                                crossAxisCount : 4,
                                mainAxisSpacing: minSpace,
                                crossAxisSpacing: minSpace,
                              ), 
                              itemBuilder:  (BuildContext context, int index){
                                return Container(
                                color: _checked == index ? secondaryColor : white, 
                                child: TextButton(
                                  child: Center(
                                  child: Text(companyOperationTime[index].operationStartTime,
                                       style: TextStyle(
                                       color: primaryColor,
                                       ),
                                     ),
                                   ),
                                  onPressed: () {
                                    setState(() {
                                      //butona basıldığında değeri günceller
                                      _checked = index;
                                      appointment.appointmentTimeId = companyOperationTime[index].id;
                                      appointment.timeS = companyOperationTime[index].operationStartTime;
                                      print(companyOperationTime[index].id.toString());

                                    });
                                  },
                                ),
                              );
                              }),
                             ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          //--------------------------------RANDEVUYU TAMAMLA BUTONU-----------------------------------
          bottomNavigationBar: TextButtonWidget(
          buttonText: "Randevuyu Tamamla",
          onPressed: (){
          //print(appointment.appointmentTimeId+"timee");
          final progressHUD = ProgressHUD.of(context);
          progressHUD.show();
          if(appointment.appointmentTimeId!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentCheckPage(companyInfo: companyInfo,appointment: appointment)));
          }
          else{
            showToast(context, "Lütfen bir saat seçiniz!");
          }
          progressHUD.dismiss();
          }),
          //--------------------------------------------------------------------------------------------
          ),
        ),
      ),
    );
  }
}