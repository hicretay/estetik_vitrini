import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AppointmentOperationPage extends StatefulWidget {
  AppointmentOperationPage({Key key}) : super(key: key);


  @override
  _AppointmentOperationPageState createState() => _AppointmentOperationPageState();
}

class _AppointmentOperationPageState extends State<AppointmentOperationPage> {
  TextEditingController teCompanyName = TextEditingController();
  @override
  Widget build(BuildContext context) {
        return SafeArea(
        child: Scaffold(
        body: ProgressHUD(
        child: Builder(builder: (context)=>
              BackGroundContainer(
              colors: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? backGroundColor1 : backGroundColorDark,
              child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(maxSpace),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(//iconun çevresini saran yapı tasarımı
                        maxRadius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: primaryColor),
                        onPressed: (){ Navigator.pop(context, false);}
                        ),
                      ),
                      SizedBox(width: maxSpace),
                      Text("Randevu Islemleri",
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
                          child: Text("companyManager / companyName",  
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
                          textEditingController: teCompanyName,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index){
                          return buildAppointmentCard(context);
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

    Padding buildAppointmentCard(BuildContext context) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("İsim:"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Telefon:"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Randevu Tarihi ve Saati:"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Yapılacak İşlem:"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Not:"),
                                  ),
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
                                        onPressed: (){},),
                                    //------------------------------------------------------------------------------
                                    //-----------------------------DÜZENLEME ICONBUTTONI--------------------------------
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                      icon: Icon(LineIcons.edit,
                                      color: primaryColor,
                                      size : iconSize),
                                      onPressed: (){},)
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