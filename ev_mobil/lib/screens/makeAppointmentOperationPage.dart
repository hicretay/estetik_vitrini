import 'package:estetikvitrini/screens/makeAppointmentTimePage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class MakeAppointmentOperationPage extends StatefulWidget {
  final AppointmentObject appointment;
  final List companyOperation;
  final dynamic companyInfo;
  MakeAppointmentOperationPage({Key key, this.companyOperation, this.companyInfo, this.appointment}) : super(key: key);

  @override
  _MakeAppointmentOperationPageState createState() => _MakeAppointmentOperationPageState(companyOperation: companyOperation,companyInfo: companyInfo, appointment: appointment);
}

class _MakeAppointmentOperationPageState extends State<MakeAppointmentOperationPage> {
  AppointmentObject appointment;
  List checkedOperation = [];

  List companyOperation;
   dynamic companyInfo;
  _MakeAppointmentOperationPageState({this.companyOperation,this.companyInfo, this.appointment});

  Map<dynamic,bool> operationListMap = {};

   operationListFunc() {
    setState(() {
      for (var item in companyOperation) {
      Map<dynamic,bool> newItem = {item:false};
      operationListMap.addEntries(newItem.entries);
    }
  });
}
  @override
  void initState() { 
    super.initState();
      operationListFunc();
  }

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
                              appointment.companyNameS, 
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
                          SizedBox(height: defaultPadding),
                          ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical, //dikeyde kaydırılabilir
                          shrinkWrap: true,
                          itemCount: companyOperation.length, //_location mapi uzunluğu kadar
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), // yalnızca sol ve sağdan boşluk
                                //InkWell sarmaladığı widgeta tıklanabilirlik özelliği kazandırdı
                                //InkWell ile liste yapısının tamamı tıklanabilir hale geldi
                                 child:
                                 InkWell(
                                onTap: () {
                                  setState(() {
                                    //_location mapinin keyleri listeye çevrildi ve tıklandığında true olarak güncellendi
                                    operationListMap.update(operationListMap.keys.toList()[index],
                                        (value) => !value);
                                  });
                                },
                                child: Container(
                                  //locationların listeleneceği card genişliği
                                  height: deviceHeight(context) * 0.06,
                                  width: deviceWidth(context) * 0.06,
                                  decoration: BoxDecoration(
                                    // Container rengi gradient ile verildi
                                    borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                                    gradient: LinearGradient(
                                      //soldan sağa doğru color listteki renkleri yaydı
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      //operationListMap mapinin value(true - false) değerlerinin indexine göre rengi kontrol ediyor
                                      colors: 
                                      operationListMap.values.toList()[index]
                                          ? backGroundColor1 // true ise(seçili) ise renk koyu
                                          : backGroundColor3, // false ise seçilmemişse açık
                                    ),
                                  ),
                                  child: Center(
                                    //Bir seçim radiosu ve text yapısından oluşan Row
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      //İç container yapısı
                                      children: [
                                      SizedBox(width: deviceWidth(context)*0.04),
                                      Container(
                                      width  : deviceWidth(context)*0.06,
                                      height : deviceHeight(context)*0.06,
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                            //operationListMap mapinin valuelarının index değerine göre renk belirler
                                            colors: 
                                               operationListMap.values.toList()[index]
                                               ? backGroundColor1 // true ise(seçili) ise renk koyu
                                               : backGroundColor3, // false ise seçilmemişse açık
                                          ),
                                        ),
                                        //Dış container yapısı
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: lightWhite,
                                                width: 4.5 ),// mor dairenin genişliği
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: deviceWidth(context)*0.2),
                                      //operation isimlerinin gösterildiği text
                                        Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                          children: 
                                            [Text( companyOperation[index].operationName, 
                                            textAlign: TextAlign.center,
                                            style    : TextStyle(
                                            fontSize : 18, // operationların fontu
                                            color: operationListMap.values.toList()[index]
                                                   ? Colors.white // seçili ise açık text
                                                   : primaryColor, // seçili değilse koyu
                                            ),
                                      ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          //separatorBuilder list itemları arasına bir widget koymayı sağlıyor
                          //SizedBox ile itemlar arası boşluk sağlandı
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: minSpace);
                          },
                          ),
                           ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-----------------------------------RANDEVU SAATİNİ SEÇ BUTONU-------------------------------------------
              bottomNavigationBar: TextButtonWidget(
              buttonText: "Randevu Saatini Seç",
              onPressed: ()async{
                final progressHUD = ProgressHUD.of(context);
                progressHUD.show();
                    for (var i = 0; i < companyOperation.length; i++) {
                    if (operationListMap.values.toList()[i]) {
                      checkedOperation.add(operationListMap.keys.toList()[i]);
                    }
                  }
                  for (var item in checkedOperation) {
                  print(item.id);
                  print(item.operationName);
                  appointment.operation = item.id;
                  appointment.operationS = item.operationName;
                }
                final companyOperationTime = await companyOperationTimeJsnFunc([1,2]); 
                if(appointment.operation!=null){              
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentTimePage(companyOperationTime: companyOperationTime.result,companyInfo: companyInfo, appointment: appointment)));
                }
                else{
                  showToast(context, "Lütfen bir işlem seçiniz!");
                }
                progressHUD.dismiss();
                }),
                //--------------------------------------------------------------------------------------------------------------
          ),
        ),
      ),
    );
  }
}



