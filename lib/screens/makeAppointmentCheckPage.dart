// ignore_for_file: unnecessary_null_comparison

import 'package:estetikvitrini/JsnClass/appointmentList.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/informationRowWidget.dart';
import 'package:estetikvitrini/settings/functions.dart';

class MakeAppointmentCheckPage extends StatefulWidget {
  final AppointmentObject? appointment;
  final int? indexx;
  MakeAppointmentCheckPage({Key? key, this.appointment, this.indexx}) : super(key: key);

  @override
  _MakeAppointmentCheckPageState createState() => _MakeAppointmentCheckPageState( appointment: appointment!);
}

class _MakeAppointmentCheckPageState extends State<MakeAppointmentCheckPage> {
  TextEditingController teNote = TextEditingController();
  late String? teOperation;
  late int? userIdData;


   AppointmentObject appointment;

   _MakeAppointmentCheckPageState({required this.appointment});

  late List? appointmentList;

  Future appointmentListFunc() async{
    final AppointmentListJsn? appointmentNewList = await appointmentListJsnFunc(1,"");
    setState(() {
      appointmentList = appointmentNewList!.result!;
    });
  }

  @override
  void initState() { 
    super.initState();
    appointmentListFunc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
              Container(
              color: primaryColor,
              child: Column(
                children: [
                  BackLeadingWidget(
                    backColor: primaryColor,
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: leadingText(context, "randevu al"),
                        ),
                        Align(alignment: Alignment.topLeft,
                            child: Text(appointment.companyNameS!, 
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
                        color       : passivePurple,
                        borderRadius: BorderRadius.vertical(
                        top         : Radius.circular(cardCurved),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(children: [
                  InformationRowWidget(
                    containerColor: Colors.black26,
                    operationName: "Tarih",
                    width: deviceWidth(context)*0.6,
                    height: deviceWidth(context)*0.15,
                    child: Text(appointment.appointmentDate! != null ? appointment.appointmentDate! : "tarih",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InformationRowWidget(
                    containerColor: Colors.black26,
                    width:  deviceWidth(context)*0.6,
                    height: deviceWidth(context)*0.15,
                    operationName: "Saat",
                    child: Text(
                      appointment.timeS!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InformationRowWidget(
                    containerColor: Colors.black26,
                    operationName: "İşlem",
                    width:  deviceWidth(context)*0.6,
                    height: deviceWidth(context)*0.17,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(deviceWidth(context)*0.01),
                        child: Text(appointment.operationS!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  InformationRowWidget(
                    containerColor: darkWhite,
                    width:  deviceWidth(context)*0.6,
                    height: deviceWidth(context)*0.3,
                    operationName: "Özel Not",
                    child: TextFormField(
                      maxLength: 250,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
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
                        width: deviceWidth(context)*0.6,
                        height: deviceWidth(context)*0.15,
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
                                  fontSize: 18),
                            ),
                            onPressed: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData"); 
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD!.show(); 
                              if(userIdData != 0){
                                final appointmentAddData = await appointmentAddJsnFunc(userIdData!, appointment.companyId!, appointment.campaignId! == null ? 0 : appointment.campaignId!, appointment.appointmentDate!, appointment.appointmentTimeId!, appointment.operationId!, teNote.text);
                                if(appointmentAddData!.success == true){
                                  await showToast(context, "Randevu başarıyla kaydedildi!");
                                }
                                else{
                                  await showToast(context, "Randevu kaydı başarısız!");
                                }
                                await appointmentListFunc();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                //Navigator.pop(context);
                                //Navigator.pop(context);
                                progressHUD.dismiss();
                              }
                              else{
                                showNotMemberAlert(context);
                                progressHUD.dismiss();
                              }
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




