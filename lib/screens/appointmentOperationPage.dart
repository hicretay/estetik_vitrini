import 'package:estetikvitrini/JsnClass/companyAppointmentListJsn.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentOperationPage extends StatefulWidget {
  AppointmentOperationPage({Key? key}) : super(key: key);


  @override
  _AppointmentOperationPageState createState() => _AppointmentOperationPageState();
}

class _AppointmentOperationPageState extends State<AppointmentOperationPage> {
    TextEditingController teCompanyName = TextEditingController();
    List? appointmentList;
    int? userIdData;

    String user = "";
    DateTime? date;

    String getDate(){
      if(date == null){
        return "";
      }
      else{
        return (date!.day <= 9 ? "0"+date!.day.toString() :  date!.day.toString())+"."+ 
        (date!.month <= 9 ? "0"+date!.month.toString() :  date!.month.toString()) +"."+date!.year.toString();
      }
    }

    getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? newuser = prefs.getString("namesurname");
    setState(() {
      user = newuser!; 
    });
    }

  
    Future appointmentListFunc() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userIdData = prefs.getInt("userIdData"); 
    final CompanyAppointmentListJsn? appointmentNewList = await appointmentCompanyListJsnFunc(1, getDate());
    if (!mounted)
    return;
    setState(() {
      appointmentList = appointmentNewList!.result;
    });
    return appointmentList;
  }

  @override
  void initState() {
    setState(() {
      appointmentListFunc();
      getUserName();
    });   
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
        return SafeArea(
        child: Scaffold(
        body: ProgressHUD(
        child: Builder(builder: (context)=>
              BackGroundContainer(
              child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(maxSpace),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                            iconSize: iconSize,
                            icon: Icon(Icons.arrow_back,color: primaryColor),
                            onPressed: (){ Navigator.pop(context, false);}
                            ),
                          ),
                          SizedBox(width: maxSpace),
                          Text("Randevu İşlemleri",
                          style     : TextStyle(
                          fontFamily: leadingFont, 
                          fontSize  : 25, 
                          color     : Colors.white),
                          ),
                        ],
                      ),
                    ],
                  )),
                      Padding(padding: const EdgeInsets.only(left: defaultPadding),
                          child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(user,  
                              style: TextStyle(color: Colors.white,fontSize: 20),
                              ),
                            ),
                            SizedBox(height: maxSpace)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),
                          ),
                          child: RefreshIndicator(
                            onRefresh:()=> appointmentListFunc(),
                                  color: primaryColor,
                                  backgroundColor: secondaryColor,
                            child: FutureBuilder<dynamic>(
                              future: appointmentListFunc(),
                              builder: (context, snapshot) {
                                if(snapshot.hasError){
                                  return Center(child: Text("Hata Oluştu"));
                                }
                                else{
                                  if(snapshot.hasData){
                                  dynamic appointmentData = snapshot.requireData;
                                  return SingleChildScrollView(
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: deviceHeight(context)*0.01),
                                      child: GestureDetector(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: maxSpace),
                                          child: Container(
                                            width: deviceWidth(context)/2.5,
                                            height: deviceHeight(context)*0.04,
                                          child:Center(
                                            child: Text("Tarihe Göre Listele",style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontFamily: contentFont
                                            )),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.all(Radius.circular(minSpace))
                                          ),
                                          ),
                                        ),
                                        onTap: ()=> pickDate(context),
                                      ),
                                    ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: appointmentData.length == null ? 0 :appointmentData.length,
                                    itemBuilder: (BuildContext context, int index){
                                    return Center(
                                      child: buildAppointmentCard(
                                        context, 
                                        index,
                                        appointmentData![index].customerName, 
                                        appointmentData![index].operationName, 
                                        appointmentData![index].appointmentTime, 
                                        appointmentData![index].phone, 
                                        appointmentData![index].appointmentDate,
                                        appointmentData),
                                    );
                                  })
                                  ],),
                                );
                                }
                                else{
                                  return circularBasic;
                                }
                              }
                            }),
                          ),
                        ),
                      ),
                    ],
                  )
            ),
          ),
        ),
      ),
    );
  }

    Padding buildAppointmentCard(
      BuildContext context, 
      int index,
      String customerName, 
      String operationName, 
      String appointmentTime, 
      String phone, 
      String appointmentDate,
      dynamic appointmentData) {

    return Padding(
    padding: const EdgeInsets.all(maxSpace),
    child: Column(
    children: [
      //-----------------------------Postu çevreleyecek container yapısı-----------------------------
      AspectRatio(
        aspectRatio: 1.6,
        child: Material(
          borderRadius:  BorderRadius.circular(cardCurved),
          elevation: 10,
          child: Container(                           
            width: double.infinity, 
            decoration: BoxDecoration(
              color: lightWhite,
              borderRadius: BorderRadius.circular(cardCurved),
            ),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                    //--------------Resmi çevreyelecek container yapısı------------------
                    child: Container(
                    width: deviceWidth(context),                     
                      //----------------Resim üzerinde yer alacak yapılar-----------------
                    child: Padding(padding: EdgeInsets.only(top: deviceHeight(context)*0.01),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Row(
                            children: [
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text("İsim:",style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text("Telefon:",style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text("Randevu Tarihi:",style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text("Randevu Saati:",style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text("Yapılacak İşlem:",style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: minSpace,right: minSpace,left: minSpace),
                                  child: Text("Not:",style: reservationText(context)),
                                ),
                              ]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text(customerName,style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text(phone,style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text(appointmentDate,style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text(appointmentTime,style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(minSpace),
                                  child: Text(operationName,style: reservationText(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: minSpace,right: minSpace,left: minSpace),
                                  child: Text(operationName,style: reservationText(context)),
                                )
                              ],)
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),
                  ),
                ),
                //-------------------------------------ICONBUTTONLAR PANELİ----------------------------------------
                Padding(
                  padding:const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                  child: Container(
                          width: deviceWidth(context),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, 
                          children: [
                            //-----------------Butonların yer aldığı container--------------------
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(minSpace),
                              ),
                              width: double.infinity, 
                              height: 40,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                    //------------------------------SİLME ICONBUTTONI----------------------------
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(LineIcons.trash,
                                        color: primaryColor),
                                        onPressed    : ()async{
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
                                                          progressHUD!.show(); 
                                                          final deleteAppointment =await appointmentDeleteJsnFunc(appointmentData![index].id);
                                                          if(deleteAppointment!.success==true){
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
                                      ),
                                    //------------------------------------------------------------------------------
                                    //-----------------------------ONAYLAMA ICONBUTTONI--------------------------------
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                      icon: Icon(LineIcons.checkSquare,
                                      color: appointmentData![index].confirmed == true ? Colors.green : primaryColor,
                                      size : iconSize),
                                      onPressed : ()async{
                                        showDialog(context: context, builder: (BuildContext context){
                                          return ProgressHUD(
                                            child: Builder(builder: (context)=>
                                                AlertDialog(
                                                content: Text(appointmentData![index].confirmed == true ? 
                                                "Randevu onayı kaldırılsın mı?" : "Randevu onaylansın mı?",
                                                style: TextStyle(fontFamily: contentFont)),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      MaterialButton(
                                                        color: primaryColor,
                                                        child: Text("Evet",style: TextStyle(color: white)),
                                                        onPressed: ()async{
                                                          final progressHUD = ProgressHUD.of(context);
                                                          progressHUD!.show(); 
                                                          final approveAppointment =await appointmentApproveJsnFunc(appointmentData![index].id);
                                                          if(approveAppointment!.success==true){
                                                            showToast(context, appointmentData![index].confirmed == true ? "Randevu onayı kaldırıldı!": "Randevu başarıyla onaylandı!");
                                                          }
                                                          else{
                                                            showToast(context, "İşlem yapılmadı!");
                                                          }
                                                          await appointmentListFunc();    
                                                          Navigator.of(context).pop();                          
                                                          progressHUD.dismiss();
                                                          }),
                                                      
                                                      MaterialButton(
                                                        color: primaryColor,
                                                        child: Text("Hayır",style: TextStyle(color: white)),
                                                        onPressed: (){
                                                          showToast(context, "Herhangi bir işlem yapılmadı!");
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                  ],)
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      },)
                                    //------------------------------------------------------------------------------
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //------------------------------------------------------------------
                          ],
                        )),
                ),
                SizedBox(height: maxSpace),
              ],
            ),
          ),
        ),
      ),
    ]),
  );
 }

 Future pickDate(BuildContext context) async{
   final initialDate = DateTime.now();
   final newDate = await showDatePicker(
     context: context, 
     initialDate: date ?? initialDate, 
     firstDate: DateTime(DateTime.now().year -1), 
     lastDate: DateTime(DateTime.now().year + 1),
     builder: (context, child) {
      return Theme(
      data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: secondaryColor),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary
          ),
          textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: secondaryColor,
          ),
        ),
      ),
      child: child!,
      );
    },
  );

  if(newDate == null) return;
  setState(() {
    date = newDate;
    //appointmentListFunc();
  });
   
 }
}