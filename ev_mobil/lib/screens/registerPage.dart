import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  static const route = "/registerPage";
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txtNameSurname = TextEditingController();
  TextEditingController txtEMail = TextEditingController();
  TextEditingController txtTelephone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPasswordAgain = TextEditingController();

  bool checkedPrivacy = true;

  var maskFormatter = MaskTextInputFormatter(

    mask: '+90 (###) ### ## ##', 
    filter: { "#": RegExp(r'[0-9]')},
    initialText: "+90");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Builder(builder: (context)=>
            Stack(children:[
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [secondaryColor,primaryColor],
                  )),
                child: null,
            ),
            SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(children: [
                Padding(
                padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding*3,bottom: defaultPadding),
                child: Row(
                  children: [
                    CircleAvatar(
                      //iconun çevresini saran yapı tasarımı
                      maxRadius: 25,
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: primaryColor,size: 35),
                        onPressed: (){Navigator.pop(context, false);},
                      ),
                    ),
                  ],
                )
              ),
               //--------------------------giriş ikonu----------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: minSpace),
                  child: Container(
                    width: deviceWidth(context)*0.9,
                    height: deviceWidth(context)*0.2,
                    child: Center(child: SvgPicture.asset("assets/images/logobeyaz.svg",color: white,placeholderBuilder: (context)=> circularBasic))),
                ),  
               //------------------------------------------------------------------
                SingleChildScrollView(
                  reverse: true,
                  child: Padding(padding: const EdgeInsets.only(left: minSpace,right: minSpace,bottom: minSpace),
                    child: Column(children: [
                       //---------------------------Ad-Soyad textField'ı---------------------------------------
                        TextFieldWidget(textEditingController: txtNameSurname,
                        keyboardType: TextInputType.name,
                        hintText    : "Ad Soyad*", //ipucu metni
                        obscureText : false, // yazılanlar gizlenmesin
                        ),
                      //-----------------------------Eposta textField'ı----------------------------------------
                        TextFieldWidget(textEditingController: txtEMail,
                        keyboardType: TextInputType.emailAddress,
                        hintText    : "E-Posta*", //ipucu metni
                        obscureText : false, // yazılanlar gizlenmesin
                        ),
                      //-----------------------------Telefon textField'ı--------------------------------------
                        TextFieldWidget(textEditingController: txtTelephone,
                        keyboardType: TextInputType.phone,
                        hintText    : "Telefon* (Başında 0 olmadan)", //ipucu metni
                        obscureText : false, // yazılanlar gizlenmesin
                        inputFormatters: [maskFormatter],
                        ),
                      //-----------------------------Şifre textField'ı----------------------------------------
                        TextFieldWidget(
                        textEditingController: txtPassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText : true, // yazılanlar gizlensin
                        hintText    : "Şifre*", //ipucu metni
                        validator: (value) => (value ?? "").length > 2 ? null : "3 'ten küçük olmamalı"
                        ),
                      //----------------------------Şifre tekrar textField'ı---------------------------------
                        TextFieldWidget(
                        textEditingController: txtPasswordAgain,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText : true, // yazılanlar gizlensin
                        hintText    : "Şifre tekrar*", //ipucu metni
                        validator: (value) => (value ?? "").length > 2 ? null : "3 'ten küçük olmamalı"
                        ),
                        //-----------------------------------------------------------------------------------
                        Text("* ile işaretli alanların girilmesi zorunludur"),

                        Column(
                          children:[
                            CheckboxListTile(
                            value: checkedPrivacy, 
                            title: GestureDetector(
                            child: Text("Gizlilik Sözleşmesini kabul ediyorum",
                            style: TextStyle(color: secondaryColor,
                            decoration: TextDecoration.underline)),
                            onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewWidget(locationUrl: "https://estetikvitrini.com/privacy.html")));
                              },
                            ),
                            activeColor: secondaryColor,
                            checkColor: primaryColor,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value){
                            setState(() {
                                checkedPrivacy = value;
                              });
                            }),
                          ],
                        ),
                        Material(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            minWidth: deviceWidth(context) * 0.5, 
                            child: Text("Kayıt Ol",style: Theme.of(context).textTheme.button.copyWith(color: white,fontFamily: contentFont,fontSize: 20)),
                            onPressed: ()async{
                           
                            final progressUHD = ProgressHUD.of(context);
                            progressUHD.show(); 
                            final userAddData = await userAddJsnFunc(txtNameSurname.text, txtEMail.text, txtTelephone.text, txtPassword.text, "", "");
                           
                              if(checkedPrivacy == true){
                              if(userAddData.success==true){
                              if(txtPassword.text == txtPasswordAgain.text){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage())); 
                            }
                            else{
                              showToast(context, "Girilen şifreler birbirinden farklı !");
                            }}
                            else {
                              showToast(context, userAddData.result);
                            }
                            }
                            else{
                              showToast(context, "Gizlilik Sözleşmesini Onaylayınız !");
                            }
                            progressUHD.dismiss(); 
                          }),
                        ),
                      ],),
                  ),
                )
                ],),
              ),
            ),
          ],
            ),
        ),
      ),
    );
  }
}