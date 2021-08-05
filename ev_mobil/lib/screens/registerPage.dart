import 'package:ev_mobil/screens/loginPage.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  static const route = "/registerPage";
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txtEMail = TextEditingController();
  TextEditingController txtTelephone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPasswordAgain = TextEditingController();
  TextEditingController txtNameSurname = TextEditingController();


  bool checkedKVKK = false;
  bool checkedPrivacy = false;

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
                    // SizedBox(
                    //   width: maxSpace,
                    // ),
                    // Text(
                    //   "Kayıt Ol",
                    //   style: TextStyle(
                    //       fontFamily: leadingFont, fontSize: 25, color: Colors.white),
                    // ),
                  ],
                )
              ),
                 // SizedBox(height: deviceHeight(context) * 0.15), // giriş ikonu - cihaz üstü boşluk          
                       //--------------------------giriş ikonu----------------------------------
                        Center(child: SvgPicture.asset("assets/images/logobeyaz.svg")),  
                       //------------------------------------------------------------------
                        SizedBox(height: deviceHeight(context) * 0.05),
                        SingleChildScrollView(
                          reverse: true,
                          child: Padding(padding: const EdgeInsets.all(minSpace),
                            child: Column(children: [
                              //-----------------------------Eposta textField'ı----------------------------------------
                                  Padding(padding: const EdgeInsets.only(top: maxSpace,right: maxSpace,left: maxSpace),
                                    child       : TextFieldWidget(textEditingController: txtEMail,
                                    keyboardType: TextInputType.name,
                                    hintText    : "E-Posta", //ipucu metni
                                    obscureText : false, // yazılanlar gizlenmesin
                                  ),
                              ),
                               //-----------------------------Ad-Soyad textField'ı----------------------------------------
                                  Padding(padding: const EdgeInsets.only(top: maxSpace,right: maxSpace,left: maxSpace),
                                    child       : TextFieldWidget(textEditingController: txtNameSurname,
                                    keyboardType: TextInputType.name,
                                    hintText    : "Ad Soyad", //ipucu metni
                                    obscureText : false, // yazılanlar gizlenmesin
                                  ),
                              ),
                              //-----------------------------Telefon textField'ı--------------------------------------
                                  Padding(padding: const EdgeInsets.only(top: maxSpace,right: maxSpace,left: maxSpace),
                                    child       : TextFieldWidget(textEditingController: txtTelephone,
                                    keyboardType: TextInputType.name,
                                    hintText    : "Telefon", //ipucu metni
                                    obscureText : false, // yazılanlar gizlenmesin
                                  ),
                              ),
                              //-----------------------------Şifre textField'ı----------------------------------------
                                Padding(padding: const EdgeInsets.only(top: maxSpace,right: maxSpace,left: maxSpace),
                                    child: TextFieldWidget(
                                    textEditingController: txtPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText : true, // yazılanlar gizlensin
                                    hintText    : "Şifre", //ipucu metni
                                  ),
                                ),
                              //----------------------------Şifre tekrar textField'ı---------------------------------
                                Padding(padding: const EdgeInsets.only(top: maxSpace,right: maxSpace,left: maxSpace),
                                    child: TextFieldWidget(
                                    textEditingController: txtPasswordAgain,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText : true, // yazılanlar gizlensin
                                    hintText    : "Şifre tekrar", //ipucu metni
                                  ),
                                ),
                                //-----------------------------------------------------------------------------------
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      CheckboxListTile(
                                      value: checkedKVKK, 
                                      title: Text("KVKK Bildirimi",style: TextStyle(color: secondaryColor)),
                                      activeColor: secondaryColor,
                                      checkColor: primaryColor,
                                      contentPadding: EdgeInsets.only(left: deviceWidth(context)*0.25),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (value){
                                         setState(() {
                                              checkedKVKK=value;                                  
                                            });
                                          }),
                                      CheckboxListTile(
                                      value: checkedPrivacy, 
                                      title: Text("Gizlilik Sözleşmesi",style: TextStyle(color: secondaryColor)),
                                      activeColor: secondaryColor,
                                      checkColor: primaryColor,
                                      contentPadding: EdgeInsets.only(left: deviceWidth(context)*0.25),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (value){
                                      setState(() {
                                          checkedPrivacy = value;
                                        });
                                      }),
                                    ],
                                  ),
                                ),
                                Material(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: MaterialButton(
                                    minWidth: deviceWidth(context) * 0.5, //Buton minimum genişliği
                                    child: Text("Kayıt Ol",style: Theme.of(context).textTheme.button.copyWith(color: white,fontFamily: contentFont,fontSize: 20)),
                                    onPressed: (){
                                      final progressUHD = ProgressHUD.of(context);
                                      progressUHD.show(); 
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));    
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