// ignore_for_file: unnecessary_null_comparison

import 'package:estetikvitrini/screens/makeAppointmentCheckPage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MakeAppointmentTimePage extends StatefulWidget {
  final AppointmentObject? appointment;
  final List? companyOperationTime;

  MakeAppointmentTimePage({Key? key, this.companyOperationTime,  this.appointment}) : super(key: key);

  @override
  _MakeAppointmentTimePageState createState() => _MakeAppointmentTimePageState(companyOperationTime: companyOperationTime, appointment: appointment);
}

class _MakeAppointmentTimePageState extends State<MakeAppointmentTimePage> {
  AppointmentObject? appointment;
  List? companyOperationTime;


  _MakeAppointmentTimePageState({this.companyOperationTime,  this.appointment});

  int _checked = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProgressHUD(
        child: Builder(builder: (context)=>
            Scaffold(
            body: 
                Container(
                color: primaryColor,
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
                            child:  leadingText(context, "randevu al")
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              appointment!.companyNameS!, 
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
                          color:Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(cardCurved),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                            Padding(padding: const EdgeInsets.all(defaultPadding),
                            child: (companyOperationTime!.isEmpty || companyOperationTime!.length == 0) ? Center(child: Text("Uygun saat bulunamadı !")) : 
                            GridView.builder(
                              
                              shrinkWrap: true,                 
                              itemCount: companyOperationTime!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (1 / .5),
                                crossAxisCount : 4,
                                mainAxisSpacing: minSpace,
                                crossAxisSpacing: minSpace,
                              ), 
                              itemBuilder:  (BuildContext context, int index){
                                return Container(
                                color: _checked == index ? secondaryColor : Theme.of(context).backgroundColor, 
                                child: TextButton(
                                  child: Center(
                                  child: Text(companyOperationTime![index].operationStartTime,
                                       style: TextStyle(
                                       color: Theme.of(context).hintColor,
                                       ),
                                     ),
                                   ),
                                  onPressed: () {
                                    setState(() {
                                      //butona basıldığında değeri günceller
                                      _checked = index;
                                      appointment!.appointmentTimeId = companyOperationTime![index].id;
                                      appointment!.timeS = companyOperationTime![index].operationStartTime;
                                      print(companyOperationTime![index].id.toString());

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
          bottomNavigationBar: Container(
            color: Theme.of(context).backgroundColor,
            child: TextButtonWidget(
            buttonText: "Randevuyu Tamamla",
            icon: FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: white),
            onPressed: (){
            print(appointment!.timeS);
            final progressHUD = ProgressHUD.of(context);
            progressHUD!.show();
            if(appointment!.timeS!=null){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentCheckPage(appointment: appointment)));
            }
            else{
              showToast(context, "Lütfen bir saat seçiniz!");
            }
            progressHUD.dismiss();
            }),
          ),
          //--------------------------------------------------------------------------------------------
          ),
        ),
      ),
    );
  }
}