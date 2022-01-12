import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/screens/makeAppointmentTimePage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MakeAppointmentOperationPage extends StatefulWidget {
  final AppointmentObject? appointment;
  final List? companyOperation;
  MakeAppointmentOperationPage({Key? key, this.companyOperation, this.appointment}) : super(key: key);

  @override
  _MakeAppointmentOperationPageState createState() => _MakeAppointmentOperationPageState(companyOperation: companyOperation!,appointment: appointment!);
}

class _MakeAppointmentOperationPageState extends State<MakeAppointmentOperationPage> {
  AppointmentObject? appointment;
  List? checkedOperation = [];
  int _checked = -1;

  List? companyOperation;
  _MakeAppointmentOperationPageState({this.companyOperation,this.appointment});

  Map<dynamic,bool> operationListMap = {};

   operationListFunc() {
    setState(() {
      for (var item in companyOperation!) {
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
                            child:  leadingText(context, "randevu al"),
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
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(cardCurved),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                          SizedBox(height: defaultPadding),
                          (companyOperation!.isEmpty || companyOperation!.length == 0) ? Center(child: Text("Uygun işlem bulunamadı !")) : 
                          ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical, //dikeyde kaydırılabilir
                          shrinkWrap: true,
                          itemCount: companyOperation!.length, //_location mapi uzunluğu kadar
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), // yalnızca sol ve sağdan boşluk
                                //InkWell sarmaladığı widgeta tıklanabilirlik özelliği kazandırdı
                                //InkWell ile liste yapısının tamamı tıklanabilir hale geldi
                                 child:
                                 InkWell(
                                onTap: () {
                                  setState(() {
                                     _checked = index;
                                     appointment!.operationId =  companyOperation![index].id;
                                     appointment!.operationS =  companyOperation![index].operationName;
                                     print(appointment!.operationId);
                                     print(appointment!.operationS);                                   
                                  });
                                },
                                child: Container(
                                  //işlemlerin listeleneceği card genişliği
                                  height: 60,
                                  decoration: BoxDecoration(
                                    // Container rengi gradient ile verildi
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    gradient: LinearGradient(
                                      //soldan sağa doğru color listteki renkleri yaydı
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      //operationListMap mapinin value(true - false) değerlerinin indexine göre rengi kontrol ediyor
                                      colors: 
                                      _checked == index 
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
                                               _checked == index
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
                                      SizedBox(width: deviceWidth(context)*0.02),
                                      //operation isimlerinin gösterildiği text
                                        Row(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: deviceWidth(context)*0.7,
                                                child: Text( companyOperation![index].operationName, 
                                                style    : TextStyle(
                                                fontSize : 16, // operationların fontu
                                                color: _checked == index
                                                       ? Colors.white // seçili ise açık text
                                                       : primaryColor, // seçili değilse koyu
                                                ),
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
                            );
                          },
                          //separatorBuilder list itemları arasına bir widget koymayı sağlıyor
                          //SizedBox ile itemlar arası boşluk sağlandı
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: minSpace);
                          },
                          ),
                          SizedBox(height: deviceHeight(context)*0.01),
                          ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-----------------------------------RANDEVU SAATİNİ SEÇ BUTONU-------------------------------------------
              bottomNavigationBar: Container(
                color: Theme.of(context).backgroundColor,
                child: TextButtonWidget(
                buttonText: "Saat Seç",
                icon: FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: white),
                onPressed: ()async{
                  final progressHUD = ProgressHUD.of(context);
                  progressHUD!.show();
                  final companyOperationTime = await companyOperationTimeJsnFunc([appointment!.operationId]); 
                  // ignore: unnecessary_null_comparison
                  if(appointment!.operationId!=null){              
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentTimePage(companyOperationTime: companyOperationTime!.result,appointment: appointment!))); //MakeAppointmentPersonelPage(appointment: appointment,)
                  }
                  else{
                    showToast(context, "Lütfen bir işlem seçiniz!");
                  }
                  progressHUD.dismiss();
                  }),
              ),
                //--------------------------------------------------------------------------------------------------------------
          ),
        ),
      ),
    );
  }
}



