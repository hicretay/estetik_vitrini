import 'package:estetikvitrini/JsnClass/appointmentList.dart';
import 'package:estetikvitrini/JsnClass/companyAppointmentListJsn.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
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
    DateTime _selectedDay = DateTime.now();

    String user = "";


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
    //String calendarDate = (_selectedDay.day <= 9 ? "0"+_selectedDay.day.toString() :  _selectedDay.day.toString())+"."+ (_selectedDay.month <= 9 ? "0"+_selectedDay.month.toString() :  _selectedDay.month.toString()) +"."+_selectedDay.year.toString();
    final CompanyAppointmentListJsn? appointmentNewList = await appointmentCompanyListJsnFunc(userIdData!,"");
    setState(() {
      appointmentList = appointmentNewList!.result;
    });
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
                      child: SingleChildScrollView(
                        child: Column(children: [
                          TextFieldWidget(
                          hintText: "Randevu Tarihi",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          validator: null,
                          textEditingController: teCompanyName,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: appointmentList == null ? 0 : appointmentList!.length,
                          itemBuilder: (BuildContext context, int index){
                          return buildAppointmentCard(
                            context, 
                            index,
                            appointmentList![index].customerName, 
                            appointmentList![index].operationName, 
                            appointmentList![index].appointmentTime, 
                            appointmentList![index].phone, 
                            appointmentList![index].appointmentDate);
                        })
                        ],),
                      ),
                    ),
                  ),
                ],
              ),
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
      String appointmentDate) {

    return Padding(
    padding: const EdgeInsets.all(maxSpace),
    child: Column(
    children: [
      //-----------------------------Postu çevreleyecek container yapısı-----------------------------
      AspectRatio(
        aspectRatio: 1.5,
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
                    child: Align(alignment: Alignment.bottomLeft, 
                              child: Padding(padding: EdgeInsets.only(bottom: deviceHeight(context)*0.01),
                                child: Column(
                                  children: [
                                  Center(
                                    child: Row(
                                      children: [Column(
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
                                            padding: const EdgeInsets.all(minSpace),
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
                                            padding: const EdgeInsets.all(minSpace),
                                            child: Text(operationName,style: reservationText(context)),
                                          )
                                        ],)
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //     children: [
                                  //     Text("İsim:"),
                                  //     SizedBox(width: deviceWidth(context)*0.05),
                                  //     Text(customerName)]),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //     children: [
                                  //     Text("Telefon:"),
                                  //     SizedBox(width: deviceWidth(context)*0.05),
                                  //     Text(phone)]),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //     children: [
                                  //     Text("Randevu Tarihi:"),
                                  //     SizedBox(width: deviceWidth(context)*0.05),
                                  //     Text(appointmentDate)]),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //     children: [
                                  //     Text("Randevu Saati:"),
                                  //     SizedBox(width: deviceWidth(context)*0.05),
                                  //     Text(appointmentTime)]),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //       children: [
                                  //       Text("Yapılacak İşlem:"),
                                  //       SizedBox(width: deviceWidth(context)*0.05),
                                  //       Text(operationName)]),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //       children: [
                                  //       Text("Not:"),
                                  //       SizedBox(width: deviceWidth(context)*0.05),
                                  //       Text(operationName)]),
                                  // ),
                                ],),
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
                                                          final deleteAppointment =await appointmentDeleteJsnFunc(appointmentList![index].id);
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
                                      color: primaryColor,
                                      size : iconSize),
                                      onPressed : ()async{
                                        showDialog(context: context, builder: (BuildContext context){
                                          return ProgressHUD(
                                            child: Builder(builder: (context)=>
                                                AlertDialog(
                                                content: Text("Randevu onaylansın mı?",style: TextStyle(fontFamily: contentFont)),
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
                                                          final approveAppointment =await appointmentApproveJsnFunc(appointmentList![index].id);
                                                          if(approveAppointment!.success==true){
                                                            showToast(context, "Randevu başarıyla onaylandı!");
                                                          }
                                                          else{
                                                            showToast(context, "Randevu onaylanmadı!");
                                                          }
                                                          await appointmentListFunc();    
                                                          Navigator.of(context).pop();                          
                                                          progressHUD.dismiss();
                                                          }),
                                                      
                                                      MaterialButton(
                                                        color: primaryColor,
                                                        child: Text("Hayır",style: TextStyle(color: white)),
                                                        onPressed: (){
                                                          showToast(context, "Randevu onaylanmadı!");
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
}